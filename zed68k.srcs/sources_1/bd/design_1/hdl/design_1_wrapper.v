//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
//Date        : Sun Oct 31 17:37:15 2021
//Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (clk100_i,
    cts,
    m68_rxd,
    rd_en,
    reset_n,
    rts,
    rx_data_count,
    rxd1,
    valid);
  input clk100_i;
  output cts;
  output [7:0]m68_rxd;
  input rd_en;
  input reset_n;
  output rts;
  output [8:0]rx_data_count;
  input rxd1;
  output valid;

  wire clk100_i;
  wire cts;
  wire [7:0]m68_rxd;
  wire rd_en;
  wire reset_n;
  wire rts;
  wire [8:0]rx_data_count;
  wire rxd1;
  wire valid;

  design_1 design_1_i
       (.clk100_i(clk100_i),
        .cts(cts),
        .m68_rxd(m68_rxd),
        .rd_en(rd_en),
        .reset_n(reset_n),
        .rts(rts),
        .rx_data_count(rx_data_count),
        .rxd1(rxd1),
        .valid(valid));
endmodule
