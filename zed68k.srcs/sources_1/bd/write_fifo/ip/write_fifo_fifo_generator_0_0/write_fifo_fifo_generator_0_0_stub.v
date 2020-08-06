// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Wed Aug  5 13:33:21 2020
// Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/code/zed-68k/zed68k.srcs/sources_1/bd/write_fifo/ip/write_fifo_fifo_generator_0_0/write_fifo_fifo_generator_0_0_stub.v
// Design      : write_fifo_fifo_generator_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_5,Vivado 2020.1" *)
module write_fifo_fifo_generator_0_0(clk, srst, din, wr_en, rd_en, dout, full, wr_ack, empty, 
  data_count)
/* synthesis syn_black_box black_box_pad_pin="clk,srst,din[42:0],wr_en,rd_en,dout[42:0],full,wr_ack,empty,data_count[8:0]" */;
  input clk;
  input srst;
  input [42:0]din;
  input wr_en;
  input rd_en;
  output [42:0]dout;
  output full;
  output wr_ack;
  output empty;
  output [8:0]data_count;
endmodule
