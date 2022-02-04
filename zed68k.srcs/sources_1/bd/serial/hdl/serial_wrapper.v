//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
//Date        : Tue Jan 25 09:01:06 2022
//Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
//Command     : generate_target serial_wrapper.bd
//Design      : serial_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module serial_wrapper
   (cts,
    reset_n,
    rts,
    sys_clk,
    tx_data,
    tx_send_active,
    tx_wr_en,
    txd);
  output cts;
  input reset_n;
  output rts;
  input sys_clk;
  input [7:0]tx_data;
  output [0:0]tx_send_active;
  input tx_wr_en;
  output txd;

  wire cts;
  wire reset_n;
  wire rts;
  wire sys_clk;
  wire [7:0]tx_data;
  wire [0:0]tx_send_active;
  wire tx_wr_en;
  wire txd;

  serial serial_i
       (.cts(cts),
        .reset_n(reset_n),
        .rts(rts),
        .sys_clk(sys_clk),
        .tx_data(tx_data),
        .tx_send_active(tx_send_active),
        .tx_wr_en(tx_wr_en),
        .txd(txd));
endmodule
