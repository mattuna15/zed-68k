// Retro <-> AXI DDR3 
// Matt Pearcem(c) 2020
// Requires 166 clock, 200 ref clock and 100 system clock
// Tested on Arty A7-35

module main_memory_control (

        //cpu bus
        input [27:0]    address, // Must be left shifted by 3
        input [15:0]    wr_data,
        input [1:0]     wr_byte_mask,
        input      i_cen, //active low -enable
        input      i_wren, //active low_write enable
        input      i_valid_p, //active high valid in
        output reg [15:0]   rd_data,
        output      o_ready_p, //active high ready signal
        output      wr_ack_p, // active high write complete
        output      o_valid_p, //active high valid read data ready
        
        //axi bus
	    output [13:0]    ddr3_sdram_addr,
	    output [2:0]     ddr3_sdram_ba,
	    output 	     ddr3_sdram_cas_n,
	    output [0:0]     ddr3_sdram_ck_n,
	    output [0:0]     ddr3_sdram_ck_p,
	    output [0:0]     ddr3_sdram_cke,
	    output [0:0]     ddr3_sdram_cs_n,
	    output [1:0]     ddr3_sdram_dm,
	    inout [15:0]     ddr3_sdram_dq,
	    inout [1:0]      ddr3_sdram_dqs_n,
	    inout [1:0]      ddr3_sdram_dqs_p,
	    output [0:0]     ddr3_sdram_odt,
	    output 	     ddr3_sdram_ras_n,
	    output 	     ddr3_sdram_reset_n,
	    output 	     ddr3_sdram_we_n,
	    
	    //clocks
	    input 	     sys_resetn,
	    input 	     sys_clock,
	    input        clock166,
	    input        clock200,
	    
	    //init
	    output       init_calib_complete
	    );
	    
	reg wr_ack = 1'b0;
	reg o_ready = 1'b0;
	reg o_valid = 1'b0;
   
   // user interface signals
   wire 		  ui_clk;
   wire 		  ui_clk_sync_rst;
   wire 		  mmcm_locked;
   wire 		  app_sr_active;
   wire 		  app_ref_ack;
   wire 		  app_zq_ack;
   // Slave Interface Write Address Ports
   reg [27:0] 		  s_axi_awaddr = 28'b0;
   wire [7:0] 		  s_axi_awlen = 8'b0; // 1
   wire [2:0] 		  s_axi_awsize = 3'b010; // 4 bytes
   wire [1:0] 		  s_axi_awburst = 2'b0; // fixed
   reg 			  s_axi_awvalid;
   wire 		  s_axi_awready;
   // Slave Interface Write Data Ports
   reg [31:0] 		  s_axi_wdata ;//= 32'hcafe_beef;
   reg [3:0] 		  s_axi_wstrb ;//= 4'b1111;
   reg 			  s_axi_wlast;
   reg 			  s_axi_wvalid;
   wire 		  s_axi_wready;
   // Slave Interface Write Response Ports
   reg 			  s_axi_bready;
   wire [3:0] 		  s_axi_bid;
   wire [1:0] 		  s_axi_bresp;
   wire 		  s_axi_bvalid;
   // Slave Interface Read Address Ports
   reg [27:0] 		  s_axi_araddr = 28'b0;
   wire [7:0] 		  s_axi_arlen = 8'b0; // 1
   wire [2:0] 		  s_axi_arsize = 3'b010; // 4 bytes
   wire [1:0] 		  s_axi_arburst = 2'b0; // fixed
   reg 			  s_axi_arvalid;
   wire 		  s_axi_arready;
   // Slave Interface Read Data Ports
   reg 			  s_axi_rready;
   wire [3:0] 		  s_axi_rid;
   wire [31:0] 		  s_axi_rdata;
   wire [1:0] 		  s_axi_rresp;
   wire 		  s_axi_rlast;
   wire 		  s_axi_rvalid;
   
   memory_wrapper mig_inst(
			  .ddr3_dq(ddr3_sdram_dq),
			  .ddr3_dqs_n(ddr3_sdram_dqs_n),
			  .ddr3_dqs_p(ddr3_sdram_dqs_p),
			  .ddr3_addr(ddr3_sdram_addr),
			  .ddr3_ba(ddr3_sdram_ba),
			  .ddr3_ras_n(ddr3_sdram_ras_n),
			  .ddr3_cas_n(ddr3_sdram_cas_n),
			  .ddr3_we_n(ddr3_sdram_we_n),
			  .ddr3_reset_n(ddr3_sdram_reset_n),
			  .ddr3_ck_p(ddr3_sdram_ck_p),
			  .ddr3_ck_n(ddr3_sdram_ck_n),
			  .ddr3_cke(ddr3_sdram_cke),
			  .ddr3_cs_n(ddr3_sdram_cs_n),
			  .ddr3_dm(ddr3_sdram_dm),
			  .ddr3_odt(ddr3_sdram_odt),
			  .sys_clk_i(clock166), //166 mhz
			  .clk_ref_i(clock200), //200 mhz
			  // User Interface
			  .ui_clk(ui_clk),
			  .ui_clk_sync_rst(ui_clk_sync_rst),
			  // Slave Interface Write Address Ports
			  .S_AXI_awid(4'b0),
			  .S_AXI_awaddr(s_axi_awaddr),
			  .S_AXI_awlen(s_axi_awlen),
			  .S_AXI_awsize(s_axi_awsize),
			  .S_AXI_awburst(s_axi_awburst),
			  .S_AXI_awlock(1'b0), // normal access
			  .S_AXI_awcache(4'b0110),
			  .S_AXI_awprot(3'b0),
			  .S_AXI_awqos(4'b0),
			  .S_AXI_awvalid(s_axi_awvalid),
			  .S_AXI_awready(s_axi_awready),
			  // Slave Interface Write Data Ports
			  .S_AXI_wdata(s_axi_wdata),
			  .S_AXI_wstrb(s_axi_wstrb),
			  .S_AXI_wlast(s_axi_wlast),
			  .S_AXI_wvalid(s_axi_wvalid),
			  .S_AXI_wready(s_axi_wready),
			  // Slave Interface Write Response Ports
			  .S_AXI_bready(s_axi_bready),
			  .S_AXI_bid(s_axi_bid),
			  .S_AXI_bresp(s_axi_bresp),
			  .S_AXI_bvalid(s_axi_bvalid),
			  // Slave Interface Read Address Ports
			  .S_AXI_arid(4'b0),
			  .S_AXI_araddr(s_axi_araddr),
			  .S_AXI_arlen(s_axi_arlen),
			  .S_AXI_arsize(s_axi_arsize),
			  .S_AXI_arburst(s_axi_arburst),
			  .S_AXI_arlock(1'b0),
			  .S_AXI_arcache(4'b1010),
			  .S_AXI_arprot(3'b0),
			  .S_AXI_arqos(4'b0),
			  .S_AXI_arvalid(s_axi_arvalid),
			  .S_AXI_arready(s_axi_arready),
			  // Slave Interface Read Data Ports
			  .S_AXI_rready(s_axi_rready),
			  .S_AXI_rid(s_axi_rid),
			  .S_AXI_rdata(s_axi_rdata),
			  .S_AXI_rresp(s_axi_rresp),
			  .S_AXI_rlast(s_axi_rlast),
			  .S_AXI_rvalid(s_axi_rvalid),
			  .init_calib_complete(init_calib_complete),
			  .sys_rst(sys_resetn));
   
   wire 		  clk = ui_clk;
   wire 		  clk_resetn = !ui_clk_sync_rst;
   wire i_valid;

    Signal_CrossDomain valid_inp(
    .clkA(sys_clock),
    .SignalIn_clkA(i_valid_p),   // this is a one-clock pulse from the clkA domain
    .clkB(clk),
    .SignalOut_clkB(i_valid)   // from which we generate a one-clock pulse in clkB domain
    );
	
    Signal_CrossDomain wrack(
    .clkA(clk),
    .SignalIn_clkA(wr_ack),   // this is a one-clock pulse from the clkA domain
    .clkB(sys_clock),
    .SignalOut_clkB(wr_ack_p)   // from which we generate a one-clock pulse in clkB domain
    );
    
    Signal_CrossDomain oready(
    .clkA(clk),
    .SignalIn_clkA(o_ready),   // this is a one-clock pulse from the clkA domain
    .clkB(sys_clock),
    .SignalOut_clkB(o_ready_p)   // from which we generate a one-clock pulse in clkB domain
    );
    

    Signal_CrossDomain ovalid(
    .clkA(clk),
    .SignalIn_clkA(o_valid),   // this is a one-clock pulse from the clkA domain
    .clkB(sys_clock),
    .SignalOut_clkB(o_valid_p)   // from which we generate a one-clock pulse in clkB domain
    );
    
  (* dont_touch="true" *) reg [7:0] 		  state;
   
   always @(posedge clk) begin
   
   
      if (!clk_resetn & !init_calib_complete) begin
	   s_axi_awvalid <= 0;
	   s_axi_wlast <= 0;
	   s_axi_wvalid <= 0;
	   s_axi_bready <= 0;
	   s_axi_arvalid <= 0;
	   s_axi_rready <= 0;
	   state <= 0;
	 
	   rd_data <= 16'b0;
	   o_ready <= 0;
	   o_valid <= 0;
	   wr_ack <= 0;
	 
      end else 
      begin
      
//              input [27:0]    address,
//        input [15:0]    wr_data,
//        input [1:0]     wr_byte_mask,
//        input [0:0]     i_cen, //active low -enable
//        input [0:0]     i_wren, //active low_write enable
//        input [0:0]     i_valid, //active high valid
//        output [15:0]   rd_data,
//        output [0:0]    o_ready, //active high ready
//        output [0:0]    o_valid, //active high valid
      

	    case (state)
	       0: begin
	        o_ready <= 1;
	        o_valid <= 0;
	        wr_ack <= 0;
	       
	        if (i_valid & !i_wren & !i_cen) begin
                s_axi_awaddr <= address;
                s_axi_wdata <= wr_data;
                s_axi_wstrb <= {2'b0, wr_byte_mask};
                state <= 1;             o_ready <= 0;
            end 
            else if (i_valid & i_wren & !i_cen) begin // read
                o_ready <= 0;
                s_axi_araddr <= address;
                state <= 7;
            end
        
         end 
	     1: begin
	           s_axi_awvalid <= 1;
	           state <= 2;
	       end
	   
	   2: begin
	       if (s_axi_awready) begin
		      s_axi_awvalid <= 0;
		      state <= 3;
	       end
	      end
	   
	   3: begin
	           s_axi_wlast <= 1;
	           s_axi_wvalid <= 1;
	           state <= 4;
	       end
	   
	   4: begin
	      if (s_axi_wready) begin
		      s_axi_wvalid <= 0;
		      state <= 5;
	      end
	   end
	   
	   5: begin
	      if (s_axi_bvalid) begin
		      s_axi_bready <= 1;

		      if (s_axi_bresp == 2'b00)
		          state <= 6;
		      else
		          state <= 100;
	          end
	   end
	   
	   6: begin
	      s_axi_bready <= 0;
	      wr_ack <= 1; //write finished
	      state <= 100; 
	   end
	   
	   7: begin
	      s_axi_arvalid <= 1;
	      state <= 8;
	   end

	   8: begin
	      if (s_axi_arready) begin
		      s_axi_arvalid <= 0;
		      state <= 9;
	      end
	   end

	   9: begin
	      if (s_axi_rvalid) begin
		      s_axi_rready <= 1;

		      if (s_axi_rresp == 2'b00)
		          state <= 10;
		      else
		          state <= 100;
	          end
	      
	   end

	   10: begin
	      s_axi_rready <= 0;
	      rd_data <= s_axi_rdata;
	      o_valid <= 1;
	      state <= 100;
	   end
	   
	   100: begin	      
	       
	      s_axi_rready <= 0;
	      o_ready <= 1;
          o_valid <= 0;
          wr_ack <= 0;
          state <= 0;
	   end
	   
	 endcase

   end
   
   end
   
endmodule

module Signal_CrossDomain(
    input clkA,   // we actually don't need clkA in that example, but it is here for completeness as we'll need it in further examples
    input SignalIn_clkA,
    input clkB,
    output SignalOut_clkB
);

// We use a two-stages shift-register to synchronize SignalIn_clkA to the clkB clock domain
reg [1:0] SyncA_clkB;
always @(posedge clkB) SyncA_clkB[0] <= SignalIn_clkA;   // notice that we use clkB
always @(posedge clkB) SyncA_clkB[1] <= SyncA_clkB[0];   // notice that we use clkB

assign SignalOut_clkB = SyncA_clkB[1];  // new signal synchronized to (=ready to be used in) clkB domain
endmodule
