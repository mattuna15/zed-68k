// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Sat Aug  1 17:37:35 2020
// Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub d:/code/zed-68k/zed68k.srcs/sources_1/ip/pll/pll_stub.v
// Design      : pll
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module pll(clk200, clk50, clk25, clk100, resetn, locked, clk_in)
/* synthesis syn_black_box black_box_pad_pin="clk200,clk50,clk25,clk100,resetn,locked,clk_in" */;
  output clk200;
  output clk50;
  output clk25;
  output clk100;
  input resetn;
  output locked;
  input clk_in;
endmodule