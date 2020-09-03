// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Wed Sep  2 20:50:37 2020
// Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub d:/code/zed-68k/zed68k.srcs/sources_1/ip/serial_rx/serial_rx_stub.v
// Design      : serial_rx
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "design_1,Vivado 2020.1" *)
module serial_rx(LED, clk100_i, cts, m68_rxd, rd_clk, rd_data_cnt, 
  rd_en, reset_n, rts, rxd1)
/* synthesis syn_black_box black_box_pad_pin="LED[7:0],clk100_i,cts,m68_rxd[7:0],rd_clk,rd_data_cnt[8:0],rd_en,reset_n,rts,rxd1" */;
  output [7:0]LED;
  input clk100_i;
  output cts;
  output [7:0]m68_rxd;
  input rd_clk;
  output [8:0]rd_data_cnt;
  input rd_en;
  input reset_n;
  output rts;
  input rxd1;
endmodule
