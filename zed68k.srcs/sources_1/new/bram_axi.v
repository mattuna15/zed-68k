// Retro <-> AXI DDR3 
// Matt Pearcem(c) 2020
// Requires 166 clock, 200 ref clock and 100 system clock
// Tested on Arty A7-35

module main_axi_control(

        //cpu bus
        input [31:0]    address, 
        input [15:0]    wr_data,
        input [1:0]     wr_byte_mask,
        input      i_cen, //active low -enable
        input      i_wren, //active low_write enable
        input      i_valid, //active high valid in
        output reg [15:0]   rd_data,
        output reg     o_ready, //active high ready signal
        output reg     wr_ack, // active high write complete
        output reg     o_valid, //active high valid read data ready
        

	    
	    //clocks
	    input 	     sys_resetn,
	    input 	     sys_clock,
	    
	    
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
   output reg [2:0] 		  s_axi_arsize = 3'b010, // 4 bytes
   output reg [1:0] 		  s_axi_arburst = 2'b0, // fixed
   output reg [1:0]           s_axi_arcache = 4'b1010,
   output reg [1:0]           s_axi_awcache = 4'b0110,
   output reg			  s_axi_arvalid,
   input 		  s_axi_arready,
   // Slave Interface Read Data Ports
   output reg 			  s_axi_rready,
   input [3:0] 		  s_axi_rid,
   input [31:0] 		  s_axi_rdata,
   input [1:0] 		  s_axi_rresp,
   input 		  s_axi_rlast,
   input 		  s_axi_rvalid
	    
	    );
	    
    
  (* dont_touch="true" *) reg [7:0] 		  state;
   
   always @(posedge sys_clock) begin
   
      if (!sys_resetn) begin
	   s_axi_awvalid <= 0;
	   s_axi_wlast <= 0;
	   s_axi_wvalid <= 0;
	   s_axi_bready <= 0;
	   s_axi_arvalid <= 0;
	   s_axi_rready <= 0;
	   state <= 0;
	 
	   rd_data <= 32'b0;
	   o_ready <= 0;
	   o_valid <= 0;
	   wr_ack <= 0;
	 
      end else 
      begin
      
      
	    case (state)
	       0: begin
	        o_ready <= 1;
	        o_valid <= 0;
	        wr_ack <= 0;
	       
	        if (i_valid & !i_wren & !i_cen) begin
                s_axi_awaddr <= {16'b0, address[15:0]};
                
                if (address[1:0] == 2'b00 || address[1:0] == 2'b01) begin
                    s_axi_wdata <= {wr_data, 16'b0};
                    s_axi_wstrb <= {wr_byte_mask,2'b0};
                end
                else
                if (address[1:0] == 2'b10 || address[1:0] == 2'b11) begin
                    s_axi_wdata <= {16'b0, wr_data};
                    s_axi_wstrb <= {2'b0, wr_byte_mask};
                end
                state <= 1;             
                o_ready <= 0;
            end 
            else if (i_valid & i_wren & !i_cen) begin // read
                o_ready <= 0;
                s_axi_araddr <={16'b0,address[15:0]};
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
	      if (address[1:0] == 2'b00 || address[1:0] == 2'b01) begin
                rd_data <= s_axi_rdata[31:16];
          end
          else
          if (address[1:0] == 2'b10 || address[1:0] == 2'b11) begin
                rd_data <= s_axi_rdata[15:0];
          end
	      
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