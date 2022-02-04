// Retro <-> AXI DDR3 
// Matt Pearcem(c) 2020
// Requires 166 clock, 200 ref clock and 100 system clock
// Tested on Arty A7-35

module axi_ethernet(

        //cpu bus
        input [31:0]    address, 
        input [31:0]    wr_data,
        input [3:0]     wr_byte_mask,
        input      i_cen, //active low -enable
        input      i_wren, //active low_write enable
        input      i_valid_p, //active high valid in
        output reg [31:0]   rd_data,
        output      o_ready_p, //active high ready signal
        output      wr_ack_p, // active high write complete
        output      o_valid_p, //active high valid read data ready
        

	    
	    //clocks
	    input 	     sys_resetn,
	    input 	     sys_clock,

	    input ui_clk,
	    input ui_clk_sync_rst,
	    
	    
	     // Slave Interface Write Address Ports
   output reg [31:0] 		  s_axi_awaddr = 32'b0,
   output reg [7:0] 		  s_axi_awlen = 8'b0, // 1
   output reg [2:0] 		  s_axi_awsize = 3'b010,// 4 bytes
   output reg [1:0] 		  s_axi_awburst = 2'b0, // fixed
   output reg 			  s_axi_awvalid,
   input 		  s_axi_awready,
   // Slave Interface Write Data Ports
   output reg [31:0] 		  s_axi_wdata, //= 32'hcafe_beef;
   output reg [3:0] 		  s_axi_wstrb,//= 4'b1111;
   output reg 			  s_axi_wlast,
   output reg 			  s_axi_wvalid,
   input 		          s_axi_wready,
   // Slave Interface Write Response Ports
   output reg 			  s_axi_bready,
   input  [3:0] 		  s_axi_bid,
   input [1:0] 		  s_axi_bresp,
   input 		  s_axi_bvalid,
   // Slave Interface Read Address Ports
   output reg [31:0] 		  s_axi_araddr = 32'b0,
   output reg [7:0] 		  s_axi_arlen = 8'b0, // 1
   output reg [2:0] 		  s_axi_arsize = 3'b01, // 4 bytes
   output reg [1:0] 		  s_axi_arburst = 2'b0, // fixed
   output reg			  s_axi_arvalid,
   input 		  s_axi_arready,
   // Slave Interface Read Data Ports
   output reg 			  s_axi_rready,
   input [3:0] 		  s_axi_rid,
   input [31:0] 		  s_axi_rdata,
   input [1:0] 		  s_axi_rresp,
   input 		  s_axi_rlast,
   input 		  s_axi_rvalid,
   	    
	    input init_calib_complete
	    
	    );
	    
	reg wr_ack = 1'b0;
	reg o_ready = 1'b0;
	reg o_valid = 1'b0;
   
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
                s_axi_wstrb <= {wr_byte_mask};
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
