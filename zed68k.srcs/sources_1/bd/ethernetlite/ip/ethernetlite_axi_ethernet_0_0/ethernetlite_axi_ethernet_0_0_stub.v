// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Tue May  4 10:56:05 2021
// Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/code/zed-68k/zed68k.srcs/sources_1/bd/ethernetlite/ip/ethernetlite_axi_ethernet_0_0/ethernetlite_axi_ethernet_0_0_stub.v
// Design      : ethernetlite_axi_ethernet_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "axi_ethernet,Vivado 2020.1" *)
module ethernetlite_axi_ethernet_0_0(address, wr_data, wr_byte_mask, i_cen, i_wren, 
  i_valid_p, rd_data, o_ready_p, wr_ack_p, o_valid_p, sys_resetn, sys_clock, ui_clk, 
  ui_clk_sync_rst, s_axi_awaddr, s_axi_awlen, s_axi_awsize, s_axi_awburst, s_axi_awvalid, 
  s_axi_awready, s_axi_wdata, s_axi_wstrb, s_axi_wlast, s_axi_wvalid, s_axi_wready, 
  s_axi_bready, s_axi_bid, s_axi_bresp, s_axi_bvalid, s_axi_araddr, s_axi_arlen, s_axi_arsize, 
  s_axi_arburst, s_axi_arvalid, s_axi_arready, s_axi_rready, s_axi_rid, s_axi_rdata, 
  s_axi_rresp, s_axi_rlast, s_axi_rvalid, init_calib_complete)
/* synthesis syn_black_box black_box_pad_pin="address[31:0],wr_data[31:0],wr_byte_mask[3:0],i_cen,i_wren,i_valid_p,rd_data[31:0],o_ready_p,wr_ack_p,o_valid_p,sys_resetn,sys_clock,ui_clk,ui_clk_sync_rst,s_axi_awaddr[31:0],s_axi_awlen[7:0],s_axi_awsize[2:0],s_axi_awburst[1:0],s_axi_awvalid,s_axi_awready,s_axi_wdata[31:0],s_axi_wstrb[3:0],s_axi_wlast,s_axi_wvalid,s_axi_wready,s_axi_bready,s_axi_bid[3:0],s_axi_bresp[1:0],s_axi_bvalid,s_axi_araddr[31:0],s_axi_arlen[7:0],s_axi_arsize[2:0],s_axi_arburst[1:0],s_axi_arvalid,s_axi_arready,s_axi_rready,s_axi_rid[3:0],s_axi_rdata[31:0],s_axi_rresp[1:0],s_axi_rlast,s_axi_rvalid,init_calib_complete" */;
  input [31:0]address;
  input [31:0]wr_data;
  input [3:0]wr_byte_mask;
  input i_cen;
  input i_wren;
  input i_valid_p;
  output [31:0]rd_data;
  output o_ready_p;
  output wr_ack_p;
  output o_valid_p;
  input sys_resetn;
  input sys_clock;
  input ui_clk;
  input ui_clk_sync_rst;
  output [31:0]s_axi_awaddr;
  output [7:0]s_axi_awlen;
  output [2:0]s_axi_awsize;
  output [1:0]s_axi_awburst;
  output s_axi_awvalid;
  input s_axi_awready;
  output [31:0]s_axi_wdata;
  output [3:0]s_axi_wstrb;
  output s_axi_wlast;
  output s_axi_wvalid;
  input s_axi_wready;
  output s_axi_bready;
  input [3:0]s_axi_bid;
  input [1:0]s_axi_bresp;
  input s_axi_bvalid;
  output [31:0]s_axi_araddr;
  output [7:0]s_axi_arlen;
  output [2:0]s_axi_arsize;
  output [1:0]s_axi_arburst;
  output s_axi_arvalid;
  input s_axi_arready;
  output s_axi_rready;
  input [3:0]s_axi_rid;
  input [31:0]s_axi_rdata;
  input [1:0]s_axi_rresp;
  input s_axi_rlast;
  input s_axi_rvalid;
  input init_calib_complete;
endmodule
