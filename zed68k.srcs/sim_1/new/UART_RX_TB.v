//////////////////////////////////////////////////////////////////////
// File Downloaded from http://www.nandland.com
//////////////////////////////////////////////////////////////////////

// This testbench will exercise the UART RX.
// It sends out byte 0x37, and ensures the RX receives it correctly.
`timescale 1ns/10ps

module UART_RX_TB();

  // Testbench uses a 25 MHz clock (same as Go Board)
  // Want to interface to 115200 baud UART
  // 25000000 / 115200 = 217 Clocks Per Bit.
  parameter c_CLOCK_PERIOD_NS = 10;
  parameter c_CLKS_PER_BIT    = 868;
  parameter c_BIT_PERIOD      = 8600;
  
  reg r_Clock = 0;
  reg t_Clock = 0;
  reg r_RX_Serial = 1;
  reg reset_n = 0;
  wire serial_valid = 0;
  wire [7:0] w_RX_Byte;
  

  // Takes in input byte and serializes it 
  task UART_WRITE_BYTE;
    input [7:0] i_Data;
    integer     ii;
    begin
      
      // Send Start Bit
      r_RX_Serial <= 1'b0;
      #(c_BIT_PERIOD);
      #1000;
      
      // Send Data Byte
      for (ii=0; ii<8; ii=ii+1)
        begin
          r_RX_Serial <= i_Data[ii];
          #(c_BIT_PERIOD);
        end
      
      // Send Stop Bit
      r_RX_Serial <= 1'b1;
      #(c_BIT_PERIOD);
     end
  endtask // UART_WRITE_BYTE
  
  
//  UART_RX #(.CLKS_PER_BIT(c_CLKS_PER_BIT)) UART_RX_INST
//    (.i_Clock(r_Clock),
//     .i_RX_Serial(r_RX_Serial),
//     .o_RX_DV(),
//     .o_RX_Byte(w_RX_Byte)
//     );
  design_1_wrapper design_1_wrapper
    (
      .rd_en(0),
      .LED(),
      .m68_rxd(w_RX_Byte),
      .rd_clk(t_Clock),
      .reset_n(reset_n),
      .rxd1(r_RX_Serial),
      .serial_int(serial_valid),
      .sys_clock(r_Clock),
      .cts(),
      .rts()
    );  
 
 //clocks
  always
    #(c_CLOCK_PERIOD_NS/2) r_Clock <= !r_Clock;
    
  always
    #(c_CLOCK_PERIOD_NS) t_Clock <= !t_Clock;

  
  // Main Testing:
  initial
    begin
    
      reset_n = 0; #50; reset_n = 1; 
      // Send a command to the UART (exercise Rx)
      @(posedge r_Clock);
      UART_WRITE_BYTE(8'h37);
      UART_WRITE_BYTE(8'h63);
      UART_WRITE_BYTE(8'h37);
      UART_WRITE_BYTE(8'h63);
      UART_WRITE_BYTE(8'h37);
      UART_WRITE_BYTE(8'h63);
      UART_WRITE_BYTE(8'h37);
      UART_WRITE_BYTE(8'h63);
      UART_WRITE_BYTE(8'h37);
      UART_WRITE_BYTE(8'h63);
      UART_WRITE_BYTE(8'h37);
      UART_WRITE_BYTE(8'h00);
      
      @(posedge r_Clock);
            
      // Check that the correct command was received
      if (w_RX_Byte == 8'h37)
        $display("Test Passed - Correct Byte Received");
      else
        $display("Test Failed - Incorrect Byte Received");
    end
endmodule
