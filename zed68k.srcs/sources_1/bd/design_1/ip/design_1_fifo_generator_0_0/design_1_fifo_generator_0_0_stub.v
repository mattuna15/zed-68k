// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Sun Mar 28 21:35:21 2021
// Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top design_1_fifo_generator_0_0 -prefix
//               design_1_fifo_generator_0_0_ design_1_fifo_generator_0_0_stub.v
// Design      : design_1_fifo_generator_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_5,Vivado 2020.1" *)
module design_1_fifo_generator_0_0(wr_clk, rd_clk, din, wr_en, rd_en, dout, full, wr_ack, 
  empty, valid, rd_data_count, wr_data_count)
/* synthesis syn_black_box black_box_pad_pin="wr_clk,rd_clk,din[7:0],wr_en,rd_en,dout[7:0],full,wr_ack,empty,valid,rd_data_count[8:0],wr_data_count[8:0]" */;
  input wr_clk;
  input rd_clk;
  input [7:0]din;
  input wr_en;
  input rd_en;
  output [7:0]dout;
  output full;
  output wr_ack;
  output empty;
  output valid;
  output [8:0]rd_data_count;
  output [8:0]wr_data_count;
endmodule
