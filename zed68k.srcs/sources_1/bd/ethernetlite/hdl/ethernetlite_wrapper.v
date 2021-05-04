//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
//Date        : Tue May  4 10:54:01 2021
//Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
//Command     : generate_target ethernetlite_wrapper.bd
//Design      : ethernetlite_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module ethernetlite_wrapper
   (address,
    eth_intr,
    eth_mdio_mdc_mdc,
    eth_mdio_mdc_mdio_io,
    eth_mii_col,
    eth_mii_crs,
    eth_mii_rst_n,
    eth_mii_rx_clk,
    eth_mii_rx_dv,
    eth_mii_rx_er,
    eth_mii_rxd,
    eth_mii_tx_clk,
    eth_mii_tx_en,
    eth_mii_txd,
    i_cen,
    i_valid_p,
    i_wren,
    o_ready_p,
    o_valid_p,
    rd_data,
    sys_clock,
    sys_resetn,
    wr_ack_p,
    wr_byte_mask,
    wr_data);
  input [31:0]address;
  output eth_intr;
  output eth_mdio_mdc_mdc;
  inout eth_mdio_mdc_mdio_io;
  input eth_mii_col;
  input eth_mii_crs;
  output eth_mii_rst_n;
  input eth_mii_rx_clk;
  input eth_mii_rx_dv;
  input eth_mii_rx_er;
  input [3:0]eth_mii_rxd;
  input eth_mii_tx_clk;
  output eth_mii_tx_en;
  output [3:0]eth_mii_txd;
  input i_cen;
  input i_valid_p;
  input i_wren;
  output o_ready_p;
  output o_valid_p;
  output [31:0]rd_data;
  input sys_clock;
  input sys_resetn;
  output wr_ack_p;
  input [3:0]wr_byte_mask;
  input [31:0]wr_data;

  wire [31:0]address;
  wire eth_intr;
  wire eth_mdio_mdc_mdc;
  wire eth_mdio_mdc_mdio_i;
  wire eth_mdio_mdc_mdio_io;
  wire eth_mdio_mdc_mdio_o;
  wire eth_mdio_mdc_mdio_t;
  wire eth_mii_col;
  wire eth_mii_crs;
  wire eth_mii_rst_n;
  wire eth_mii_rx_clk;
  wire eth_mii_rx_dv;
  wire eth_mii_rx_er;
  wire [3:0]eth_mii_rxd;
  wire eth_mii_tx_clk;
  wire eth_mii_tx_en;
  wire [3:0]eth_mii_txd;
  wire i_cen;
  wire i_valid_p;
  wire i_wren;
  wire o_ready_p;
  wire o_valid_p;
  wire [31:0]rd_data;
  wire sys_clock;
  wire sys_resetn;
  wire wr_ack_p;
  wire [3:0]wr_byte_mask;
  wire [31:0]wr_data;

  IOBUF eth_mdio_mdc_mdio_iobuf
       (.I(eth_mdio_mdc_mdio_o),
        .IO(eth_mdio_mdc_mdio_io),
        .O(eth_mdio_mdc_mdio_i),
        .T(eth_mdio_mdc_mdio_t));
  ethernetlite ethernetlite_i
       (.address(address),
        .eth_intr(eth_intr),
        .eth_mdio_mdc_mdc(eth_mdio_mdc_mdc),
        .eth_mdio_mdc_mdio_i(eth_mdio_mdc_mdio_i),
        .eth_mdio_mdc_mdio_o(eth_mdio_mdc_mdio_o),
        .eth_mdio_mdc_mdio_t(eth_mdio_mdc_mdio_t),
        .eth_mii_col(eth_mii_col),
        .eth_mii_crs(eth_mii_crs),
        .eth_mii_rst_n(eth_mii_rst_n),
        .eth_mii_rx_clk(eth_mii_rx_clk),
        .eth_mii_rx_dv(eth_mii_rx_dv),
        .eth_mii_rx_er(eth_mii_rx_er),
        .eth_mii_rxd(eth_mii_rxd),
        .eth_mii_tx_clk(eth_mii_tx_clk),
        .eth_mii_tx_en(eth_mii_tx_en),
        .eth_mii_txd(eth_mii_txd),
        .i_cen(i_cen),
        .i_valid_p(i_valid_p),
        .i_wren(i_wren),
        .o_ready_p(o_ready_p),
        .o_valid_p(o_valid_p),
        .rd_data(rd_data),
        .sys_clock(sys_clock),
        .sys_resetn(sys_resetn),
        .wr_ack_p(wr_ack_p),
        .wr_byte_mask(wr_byte_mask),
        .wr_data(wr_data));
endmodule
