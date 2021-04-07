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

// Use CDC using registers
//`define VIA_REG

module sdram_ddr_wrapper (
    input clk,          // SDRAM reference clock 200MHz
    input clk_rtl,      // Slower the logic runs on
    input clk_ref_i,
    input i_rst,        // Synchronous reset
    output o_ui_clk,    // output of the UI clock 200MHz
    output o_ui_rst,
    
    //// SRAM like interface ////
    // cpu (Fast memory)
    input       [31:0] wrap_Addr,   // Address bus (Upper part not used)
    input              wrap_CS,     // Chip select 
    input              wrap_L,      // Low byte [0:7]
    input              wrap_U,      // High byte [8:15] 
    input              wrap_WE,     // Write enable
    input       [15:0] wrap_WR,     // Data to write
    input              wrap_big_r,  // Indicate the reading of an additional 48-bits
    output      [15:0] wrap_RD,     // Data to read
    output      [47:0] wrap_RD48,   // Additional 48-bit output
    output             wrap_ready,  // Transaction ready
    
    // The big read transfers 48 bits in total, 
    // [15:0]   wrap_RD
    // [16:47]  wrap_RD48
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
    
    output      [1:0]  ddr3_dm,
    
    output      [0:0]  ddr3_odt,
    output      [0:0]  ddr3_cs_n,
    
    output             init_calib_complete
    );

    ////
    // IMPORTANT !
    //
    // This routine crosses the clock boundary between the DDR3 o_ui_clk
    //  and the clk_ui clock. 
    // The clk_ui clock must be not synchronous with the input clock of 
    // the MIGi module.
    // The clk_rtl clock must be be derived from the o_ui_clk. 
    // i.e. (Using BUFR + devider)
    /////

    // CDC registers
    // Output
    reg     r_clk_rtl_;     // Trailing clock register
    wire     r_ready;        // only change when clk_rtl has a pos edge
    wire    w_ready;        // only change when clk_rtl has a pos edge

    // Wires
    wire    [31:0]  w_Addr;
    wire            w_CS;
    wire            w_L;
    wire            w_U;
    wire            w_WE;
    wire    [15:0]  w_WR;
    wire            w_big_r;

    // SDRAM wrapper
    sdram_ddr_controller my_sdram_ctrl (
        .clk(clk),
        .clk_ref_i(clk_ref_i),
        .i_rst(i_rst),
        .o_ui_clk(o_ui_clk),
        .o_ui_rst(o_ui_rst),
        
        //// SRAM like interface ////
        // cpu (Fast memory)
        .sd_Addr(w_Addr),     // Address bus (Upper part not used)
        .sd_CS(w_CS),         // Chip select 
        .sd_L(w_L),           // Low byte [0:7]
        .sd_U(w_U),           // High byte [8:15] 
        .sd_WE(w_WE),         // Write enable
        .sd_WR(w_WR),         // Data to write
        .sd_RD(wrap_RD),         // Data to read
        .sd_RD48(wrap_RD48),     // Data to read 48-bits extra
        .sd_big_r(w_big_r),      // When asserted, read 64-bit instead of 16
        .sd_ready(w_ready),   // Transaction ready

        
        //// SDRAM DDR3 ////
        
        // DDR3 Inouts
        .ddr3_dq(ddr3_dq),        
        .ddr3_dqs_n(ddr3_dqs_n),
        .ddr3_dqs_p(ddr3_dqs_p),
      
        // DDR3 Outputs
        .ddr3_addr(ddr3_addr),
        .ddr3_ba(ddr3_ba),
        .ddr3_ras_n(ddr3_ras_n),
        .ddr3_cas_n(ddr3_cas_n),
        .ddr3_we_n(ddr3_we_n),
        .ddr3_reset_n(ddr3_reset_n),
        .ddr3_cs_n(ddr3_cs_n),
        .ddr3_ck_p(ddr3_ck_p),
        .ddr3_ck_n(ddr3_ck_n),
        .ddr3_cke(ddr3_cke),
        
        .ddr3_dm(ddr3_dm),
        
        .ddr3_odt(ddr3_odt),
        
        .init_calib_complete(init_calib_complete)
    );
    
Signal_CrossDomain ready_cdc (
    .clkA(o_ui_clk),
    .SignalIn_clkA(w_ready),   // this is a one-clock pulse from the clkA domain
    .clkB(clk_rtl),
    .SignalOut_clkB(r_ready)   // from which we generate a one-clock pulse in clkB domain
);

// Assign the outputs
assign wrap_ready = r_ready;
assign w_Addr = wrap_Addr;
assign w_CS = wrap_CS;
assign w_L = wrap_L;
assign w_U = wrap_U;
assign w_WR = wrap_WR;
assign w_big_r = wrap_big_r;

endmodule
// Advance pointer when read is donepp_rd_data
