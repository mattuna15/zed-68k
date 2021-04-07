//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
//Date        : Mon Apr  5 21:22:51 2021
//Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (LED,
    clk100_i,
    cts,
    m68_rxd,
    rd_clk,
    rd_data_cnt,
    rd_en,
    reset_n,
    rts,
    rxd1);
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

  wire [7:0]LED;
  wire clk100_i;
  wire cts;
  wire [7:0]m68_rxd;
  wire rd_clk;
  wire [8:0]rd_data_cnt;
  wire rd_en;
  wire reset_n;
  wire rts;
  wire rxd1;

  design_1 design_1_i
       (.LED(LED),
        .clk100_i(clk100_i),
        .cts(cts),
        .m68_rxd(m68_rxd),
        .rd_clk(rd_clk),
        .rd_data_cnt(rd_data_cnt),
        .rd_en(rd_en),
        .reset_n(reset_n),
        .rts(rts),
        .rxd1(rxd1));
endmodule
