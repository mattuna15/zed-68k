// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Sat Aug  1 16:05:46 2020
// Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/code/zed-68k/zed68k.srcs/sources_1/bd/design_1/ip/design_1_UART_FIFO_IO_cntl_pr_0_0/design_1_UART_FIFO_IO_cntl_pr_0_0_stub.v
// Design      : design_1_UART_FIFO_IO_cntl_pr_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "UART_FIFO_IO_cntl_proc,Vivado 2020.1" *)
module design_1_UART_FIFO_IO_cntl_pr_0_0(clk, rst, uart_rx_dv, uart_tx_rfd, fifoM_full, 
  fifoM_empty, fifoM_wr_ack, uart_rx_rd_en, uart_tx_wr_en, fifoM_wr_en, fifoM_rd_en)
/* synthesis syn_black_box black_box_pad_pin="clk,rst,uart_rx_dv,uart_tx_rfd,fifoM_full,fifoM_empty,fifoM_wr_ack,uart_rx_rd_en,uart_tx_wr_en,fifoM_wr_en,fifoM_rd_en" */;
  input clk;
  input rst;
  input uart_rx_dv;
  input uart_tx_rfd;
  input fifoM_full;
  input fifoM_empty;
  input fifoM_wr_ack;
  output uart_rx_rd_en;
  output uart_tx_wr_en;
  output fifoM_wr_en;
  output fifoM_rd_en;
endmodule
