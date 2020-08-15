// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Sat Aug 15 12:49:05 2020
// Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/code/zed-68k/zed68k.srcs/sources_1/bd/design_1/ip/design_1_UART_RX_0_0/design_1_UART_RX_0_0_stub.v
// Design      : design_1_UART_RX_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "UART_RX,Vivado 2020.1" *)
module design_1_UART_RX_0_0(i_Clk, i_RX_Serial, o_RX_DV, o_RX_Byte)
/* synthesis syn_black_box black_box_pad_pin="i_Clk,i_RX_Serial,o_RX_DV,o_RX_Byte[7:0]" */;
  input i_Clk;
  input i_RX_Serial;
  output o_RX_DV;
  output [7:0]o_RX_Byte;
endmodule
