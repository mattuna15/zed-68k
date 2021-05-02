`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2020 01:05:06 PM
// Design Name: 
// Module Name: sdram_ddr_wrapper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


//`define ALI_DEBUG

module sdram_ddr_controller (
    input clk,          // SDRAM reference clock 200MHz
    input clk_ref_i,
    input i_rst,        // Synchronous reset
    output o_ui_clk,    // output of the UI clock 200MHz
    output o_ui_rst,
    
    //// SRAM like interface ////
    // cpu (Fast memory)
    input       [31:0] sd_Addr,   // Address bus (Upper part not used)
    input              sd_CS,     // Chip select 
    input              sd_L,      // Low byte [0:7]
    input              sd_U,      // High byte [8:15] 
    input              sd_WE,     // Write enable
    input       [15:0] sd_WR,     // Data to write
    input              sd_big_r,  // Indicate the reading of an additional 48-bits
    output      [15:0] sd_RD,     // Data to read
    output      [47:0] sd_RD48,   // Additional 48-bit output
    output             sd_ready,  // Transaction ready
    
    // The big read transfers 48 bits in total, 
    // [15:0]   sd_RD
    // [16:47]  sd_RD48
    // This to allow more memory bandwidth to the chipset
    // The 64-bit bus created this way is read only

    //// SDRAM DDR3 ////
    
    // DDR3 Inouts
    inout       [15:0] ddr3_dq,        
    inout       [1:0]  ddr3_dqs_n,
    inout       [1:0]  ddr3_dqs_p,
  
    // DDR3 Outputs
    output      [13:0] ddr3_addr,
    output      [2:0]  ddr3_ba,
    output             ddr3_ras_n,
    output             ddr3_cas_n,
    output             ddr3_we_n,
    output             ddr3_reset_n,
    output      [0:0]  ddr3_ck_p,
    output      [0:0]  ddr3_ck_n,
    output      [0:0]  ddr3_cke,
    output      [0:0]  ddr3_cs_n,
    
    output      [1:0]  ddr3_dm,
    
    output      [0:0]  ddr3_odt,
    
    output             init_calib_complete
    );
    
    //// DDR STATE MACHINE ////
    
    // STATES
    localparam STATE_START              = 0;
    localparam STATE_IDLE               = 1;
    localparam STATE_READ_CACHE         = 2;
    localparam STATE_WRITE_CACHE        = 3;
    localparam STATE_READ_SDRAM         = 4;
    localparam STATE_READ_DONE_SDRAM    = 5;
    localparam STATE_WRITE_SDRAM        = 6;
    localparam STATE_WRITE_DONE_SDRAM   = 7;
    localparam STATE_RETURN_RESULT      = 8;
    localparam STATE_UPDATE_ENTRY       = 9;
    
    //// CACHE registers
    reg [5:0]       cache_state = STATE_START;
    reg [1:0]       cache_ptr = 2'b0;
    reg [2:0]       cache_e_set = 3'b0;
    reg [15:0]      cache_e_mask  [0:3];
    reg [127:0]     cache_e_data  [0:3];
    reg [27:0]      cache_e_addr  [0:3];    
    
    //// MIG interface ////
    reg   [27:0]    app_addr = 28'h0;
    reg   [2:0]     app_cmd = 3'h0;
    reg             app_en = 1'b0;
    reg   [127:0]   app_wdf_data = 128'h0;
    reg             app_wdf_end = 1'b1;
    reg             app_wdf_wren = 1'b0;
    wire  [127:0]   app_rd_data;
    wire            app_rd_data_end;
    wire            app_rd_data_valid;
    wire            app_rdy;
    wire            app_wdf_rdy;
    reg             app_sr_req = 1'b0;
    reg             app_ref_req = 1'b0;
    reg             app_zq_req = 1'b0;
    wire            app_sr_active;
    wire            app_ref_ack;
    wire            app_zq_ack;
    wire            ui_clk;
    wire            ui_clk_sync_rst;
    wire  [15:0]    app_wdf_mask = 16'h0;

    //// State machine registers ////
    reg     [31:0]  r_Addr;     // Address bus (Upper part not used)
    reg             r_L;        // Low byte [0:7]
    reg             r_U;        // High byte [8:15] 
    reg     [15:0]  r_WR;       // Data to write
    reg     [63:0]  r_RD;       // Data to read
    reg             r_ready = 1'b0;    // Transaction ready
    reg     [27:0]  r_SD_Addr;  // Address to read from or write to in SD_RAM
    reg     [127:0] r_SD_Data;  // SD read/write register
    reg             r_WE;       // Write enable

    //// Memory wrapper tasks and functions ////
    
    // Mig memory commands
    localparam CMD_WRITE = 3'b000;
    localparam CMD_READ = 3'b001;

    // Macro to translate the input address to the cache address
    // Address in SDRAM = ignore last 4 bits in address, because
    // SDRam is 16 bit and address bus is 8 bit (-1 bit)
    // SDRam works with 8 16 bit bursts (-3 bits)
    `define M_CACHE_ADDR(addr) {addr[28:4],3'b000} 
    
    // Read Cache
    integer byte_loop;
    integer read_loop;
    reg [7:0]   v_byte_found; // Found higher byte?
    reg [7:0]   v_byte_select; // Upper or lower byte select?
    reg [31:0]  v_u_Addr; // Higher byte variable
    task task_read_cache;
        input [5:0] next_state_found;
        input [5:0] next_state_notfound;
        begin
            // Default action
            cache_state <= next_state_found;
			v_byte_select[0] = r_L;
			v_byte_select[1] = r_U;
			if (sd_big_r) begin
				v_byte_select[7:2] = 6'h3f;
			end

			// Writing is only done to cache, the cache is written to cache on a replace action
			// The outer loop that looks up the bytes it needs to write
			// The inner for loop creates the intries to look into the different cache registers
			for (byte_loop = 0; byte_loop < 8; byte_loop = byte_loop+1) begin
				if (v_byte_select[byte_loop]) begin // Did we request the low byte?
					v_u_Addr = r_Addr + byte_loop;
					// Check if in cache, if it is return value
					for (read_loop = 0; read_loop < 4; read_loop = read_loop + 1) begin
						if((cache_e_set[read_loop] == 1'b1) && (`M_CACHE_ADDR(v_u_Addr) == cache_e_addr[read_loop])) begin
							r_RD[byte_loop*8 +: 8] <= cache_e_data[read_loop][(v_u_Addr[3:0])*8 +: 8]; // Select lower byte from cache
							v_byte_found[byte_loop] = 1'b1; // Indicate we found the Low byte
						end
					end
					if (v_byte_found[byte_loop] == 1'b0) begin
						r_SD_Addr <= `M_CACHE_ADDR(v_u_Addr);
						cache_state <= next_state_notfound;
					end
				end 
				else begin // Low byte not requested
					r_RD[byte_loop*8 +: 8] <= 8'h00;
				end
			end

            // If both upper and lower byte are found set ready flag
            // and return to idle
            if (v_byte_found == v_byte_select) begin
                r_ready <= 1'b1; 
            end
        end
    endtask

    // Write cache
    integer write_loop;
    task task_write_cache;
        input [5:0] next_state_found;
        input [5:0] next_state_notfound;
        begin
            // Default action
            cache_state <= next_state_found;
            v_byte_found = 8'b00;
            v_byte_select[0] = r_L;
            v_byte_select[1] = r_U;
			v_byte_select[7:2] = 6'h00;

			// Writing is only done to cache, the cache is written to cache on a replace action
			// The outer loop that looks up the bytes it needs to write
			// The inner for loop creates the intries to look into the different cache registers
            for (byte_loop = 0; byte_loop < 2; byte_loop = byte_loop + 1) begin
                // Check if in cache, if it is return value
                if (v_byte_select[byte_loop]) begin // Did we request the low byte?
                    v_u_Addr = r_Addr + byte_loop;
					// Check if in cache, if it is return value
                    for (write_loop = 0; write_loop < 4; write_loop = write_loop+1) begin
                        if((cache_e_set[write_loop] == 1'b1) && (`M_CACHE_ADDR(v_u_Addr) == cache_e_addr[write_loop])) begin
                            cache_e_data[write_loop][(v_u_Addr[3:0])*8 +: 8] <= r_WR[byte_loop*8 +: 8]; // Select lower byte from cache
                            cache_e_mask[write_loop][v_u_Addr[3:0]] <= 1'b1;
                            v_byte_found[byte_loop] = 1'b1; // Indicate we found the Low byte
                        end
                    end
                    if (v_byte_found[byte_loop] == 1'b0) begin
                        r_SD_Addr <= `M_CACHE_ADDR(v_u_Addr);
                        cache_state <= next_state_notfound;
                    end
                end 
            end

            // If both upper and lower byte are found set ready flag
            // and return to idle
            if (v_byte_found == v_byte_select) begin
                r_ready <= 1'b1; 
            end
        end
    endtask

    // Replace / Fill cache entry
    task task_update_entry;
        input [5:0] next_state_store;
        input [5:0] next_state_fill;
        begin
            // If occupied and dirty
            if (cache_e_set[cache_ptr] == 1'b1 & cache_e_mask[cache_ptr] != 16'b0) begin
                cache_state <= next_state_store;
            end 
            else begin 
                cache_state <= next_state_fill;
            end
        end
    endtask
    
    // Read SDRAM
    task task_read_sdram;
        input [5:0] next_state;
        begin
            if (app_rdy) begin
              app_en <= 1;
              app_addr <= r_SD_Addr;
              app_cmd <= CMD_READ;
              cache_state <= next_state;
            end
        end
    endtask

    // Read SDRAM done
    task task_read_done_rdram;
        input [5:0] next_on_read;
        input [5:0] next_on_write;
        begin
            if (app_rdy & app_en) begin
              app_en <= 0;
            end
    
            if (app_rd_data_valid) begin
              cache_e_data[cache_ptr] <= app_rd_data;   // Set data
              cache_e_set[cache_ptr] <= 1'b1;         // Set value as being occupied
              cache_e_mask[cache_ptr] <= 16'h0;         // No data changed yet
              cache_e_addr[cache_ptr] <= r_SD_Addr;     // Store address of page

              // Advance pointer when read is done
              cache_ptr <= cache_ptr + 1;               // Next cache position

              // When done reading, return to the cache read or write
              cache_state <= next_on_read;                // Next State
              if (r_WE == 1'b1) begin
                  cache_state <= next_on_write;
              end
            end
        end
    endtask

    // Write SDRAM
    task task_write_sdram;
        input [5:0] next_state;
        begin
            if (app_rdy & app_wdf_rdy) begin
              app_en <= 1;                              // Command started
              app_wdf_wren <= 1;                        // We want to write
              app_addr <= cache_e_addr[cache_ptr];      // To address r_addr
              app_cmd <= CMD_WRITE;                     // Give the command 'WRITE' 
              app_wdf_data <= cache_e_data[cache_ptr];  // 128 bits of data to be written
              cache_state <= next_state;                // Go to next state
            end
        end
    endtask

    task task_write_sdram_done;
        input [5:0] next_state;
        begin
            if (app_rdy & app_en) begin         // This signals the command is accepted
                app_en <= 0;
            end

            if (app_wdf_rdy & app_wdf_wren) begin
                app_wdf_wren <= 0;
            end

            if (~app_en & ~app_wdf_wren) begin
                cache_e_mask[cache_ptr] <= 16'h0;         // Page has been saved, not dirty
                cache_state <= next_state;                // Next State
            end
        end
    endtask

    //// Memory wrapper state machine ////
    always @(posedge ui_clk) begin
        case (cache_state) 
            STATE_START: begin
                r_ready <= 1'b0; // Nothing is ready
                if(init_calib_complete == 1'b1) begin
                    cache_state <= STATE_IDLE;
                end
            end
            // Wait for new command
            STATE_IDLE: begin
                r_ready <= 1'b1; // Ready strobe

                if (sd_CS == 1'b1) begin
                    r_ready <= 1'b0; // Ready strobe
                    r_L <= sd_L;
                    r_U <= sd_U;
                    r_WE <= sd_WE;
                    r_Addr <= sd_Addr;
                    // Read ?
                    if(sd_WE == 1'b0) begin
                        cache_state <= STATE_READ_CACHE;
                    end
                    // Write ?
                    else begin
                        r_WR <= sd_WR;
                        cache_state <= STATE_WRITE_CACHE;
                    end
                end
            end
            // Read from cache, if not available read from SDRAM
            STATE_READ_CACHE: begin
                task_read_cache(STATE_IDLE, STATE_UPDATE_ENTRY);
            end
            STATE_UPDATE_ENTRY: begin
                task_update_entry(STATE_WRITE_SDRAM, STATE_READ_SDRAM);
            end
            // Initiate read from SDRAM
            STATE_READ_SDRAM: begin
                task_read_sdram(STATE_READ_DONE_SDRAM);
            end
            // Handle cache update whin read is done
            STATE_READ_DONE_SDRAM: begin
                task_read_done_rdram(STATE_READ_CACHE, STATE_WRITE_CACHE);
            end
            // Write to cache, if not available read from SDRAM
            STATE_WRITE_CACHE: begin
                task_write_cache(STATE_IDLE, STATE_UPDATE_ENTRY);
            end
            // Write to SDRAM
            STATE_WRITE_SDRAM: begin
                task_write_sdram(STATE_WRITE_DONE_SDRAM);
            end
            // Handle cache update when write is done
            STATE_WRITE_DONE_SDRAM: begin
                task_write_sdram_done(STATE_UPDATE_ENTRY);
            end
            // return result
            STATE_RETURN_RESULT: begin
           //     r_ready <= 1'b1;
                cache_state <= STATE_IDLE;
            end
        endcase
    end

    // output
    assign sd_ready = r_ready;
    assign sd_RD = r_RD[15:0];
	assign sd_RD48 = r_RD[63:16];
    assign o_ui_clk = ui_clk;
    assign o_ui_rst = ui_clk_sync_rst;
    
    // Instantiating the DDR3 controller
    mig_7series_0 u_mig_7 (

		// Memory interface ports
		.ddr3_addr                      (ddr3_addr),  // output [13:0]		ddr3_addr
		.ddr3_ba                        (ddr3_ba),  // output [2:0]		ddr3_ba
		.ddr3_cas_n                     (ddr3_cas_n),  // output			ddr3_cas_n
		.ddr3_ck_n                      (ddr3_ck_n),  // output [0:0]		ddr3_ck_n
		.ddr3_ck_p                      (ddr3_ck_p),  // output [0:0]		ddr3_ck_p
		.ddr3_cke                       (ddr3_cke),  // output [0:0]		ddr3_cke
		.ddr3_ras_n                     (ddr3_ras_n),  // output			ddr3_ras_n
		.ddr3_reset_n                   (ddr3_reset_n),  // output			ddr3_reset_n
		.ddr3_we_n                      (ddr3_we_n),  // output			ddr3_we_n
		.ddr3_dq                        (ddr3_dq),  // inout [15:0]		ddr3_dq
		.ddr3_dqs_n                     (ddr3_dqs_n),  // inout [1:0]		ddr3_dqs_n
		.ddr3_dqs_p                     (ddr3_dqs_p),  // inout [1:0]		ddr3_dqs_p
		.init_calib_complete            (init_calib_complete),  // output			init_calib_complete
		.ddr3_cs_n(ddr3_cs_n),  
		.ddr3_dm                        (ddr3_dm),  // output [1:0]		ddr3_dm
		.ddr3_odt                       (ddr3_odt),  // output [0:0]		ddr3_odt
		// Application interface ports
		.app_addr                       (app_addr),  // input [27:0]		app_addr
		.app_cmd                        (app_cmd),  // input [2:0]		app_cmd
		.app_en                         (app_en),  // input				app_en
		.app_wdf_data                   (app_wdf_data),  // input [127:0]		app_wdf_data
		.app_wdf_end                    (app_wdf_end),  // input				app_wdf_end
		.app_wdf_wren                   (app_wdf_wren),  // input				app_wdf_wren
		.app_rd_data                    (app_rd_data),  // output [127:0]		app_rd_data
		.app_rd_data_end                (app_rd_data_end),  // output			app_rd_data_end
		.app_rd_data_valid              (app_rd_data_valid),  // output			app_rd_data_valid
		.app_rdy                        (app_rdy),  // output			app_rdy
		.app_wdf_rdy                    (app_wdf_rdy),  // output			app_wdf_rdy
		.app_sr_req                     (app_sr_req),  // input			app_sr_req
		.app_ref_req                    (app_ref_req),  // input			app_ref_req
		.app_zq_req                     (app_zq_req),  // input			app_zq_req
		.app_sr_active                  (app_sr_active),  // output			app_sr_active
		.app_ref_ack                    (app_ref_ack),  // output			app_ref_ack
		.app_zq_ack                     (app_zq_ack),  // output			app_zq_ack
		.ui_clk                         (ui_clk),  // output			ui_clk
		.ui_clk_sync_rst                (ui_clk_sync_rst),  // output			ui_clk_sync_rst
		.app_wdf_mask                   (app_wdf_mask),  // input [15:0]		app_wdf_mask
		// System Clock Ports
		.sys_clk_i                      (clk),
		.clk_ref_i                      (clk_ref_i),
		.sys_rst                        (i_rst) // input sys_rst
    );

endmodule
// Advance pointer when read is donepp_rd_data
