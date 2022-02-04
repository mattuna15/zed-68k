//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
//Date        : Tue Jan 25 08:59:13 2022
//Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* HW_HANDOFF = "design_1.hwdef" *) (* core_generation_info = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=3,numReposBlks=3,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=2,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) 
module design_1
   (clk100_i,
    cts,
    m68_rxd,
    rd_en,
    reset_n,
    rts,
    rx_data_count,
    rxd1,
    valid);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 CLK.CLK100_I CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME CLK.CLK100_I, ASSOCIATED_RESET reset_n, CLK_DOMAIN design_1_clk100_i, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input clk100_i;
  output cts;
  output [7:0]m68_rxd;
  input rd_en;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 RST.RESET_N RST" *) (* x_interface_parameter = "XIL_INTERFACENAME RST.RESET_N, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input reset_n;
  output rts;
  output [8:0]rx_data_count;
  input rxd1;
  output valid;

  wire UART_FIFO_IO_cntl_pr_0_fifoM_wr_en;
  wire UART_FIFO_IO_cntl_pr_0_uart_rx_rd_en;
  wire UART_FIFO_IO_cntl_pr_0_uart_tx_wr_en;
  wire [7:0]UART_RX_0_o_RX_Byte;
  wire UART_RX_0_o_RX_DV;
  wire clk_wiz_0_clk_out1;
  wire [8:0]fifo_generator_0_data_count;
  wire [7:0]fifo_generator_0_dout;
  wire fifo_generator_0_empty;
  wire fifo_generator_0_full;
  wire fifo_generator_0_valid;
  wire fifo_generator_0_wr_ack;
  wire rd_en_0_1;
  wire reset_n_1;
  wire rxd1_1;

  assign clk_wiz_0_clk_out1 = clk100_i;
  assign cts = UART_FIFO_IO_cntl_pr_0_uart_rx_rd_en;
  assign m68_rxd[7:0] = fifo_generator_0_dout;
  assign rd_en_0_1 = rd_en;
  assign reset_n_1 = reset_n;
  assign rts = UART_FIFO_IO_cntl_pr_0_uart_tx_wr_en;
  assign rx_data_count[8:0] = fifo_generator_0_data_count;
  assign rxd1_1 = rxd1;
  assign valid = fifo_generator_0_valid;
  design_1_UART_FIFO_IO_cntl_pr_0_0 UART_FIFO_IO_cntl_pr_0
       (.clk(clk_wiz_0_clk_out1),
        .fifoM_empty(fifo_generator_0_empty),
        .fifoM_full(fifo_generator_0_full),
        .fifoM_wr_ack(fifo_generator_0_wr_ack),
        .fifoM_wr_en(UART_FIFO_IO_cntl_pr_0_fifoM_wr_en),
        .rst(reset_n_1),
        .uart_rx_dv(UART_RX_0_o_RX_DV),
        .uart_rx_rd_en(UART_FIFO_IO_cntl_pr_0_uart_rx_rd_en),
        .uart_tx_rfd(1'b0),
        .uart_tx_wr_en(UART_FIFO_IO_cntl_pr_0_uart_tx_wr_en));
  design_1_UART_RX_0_0 UART_RX_0
       (.i_Clk(clk_wiz_0_clk_out1),
        .i_RX_Serial(rxd1_1),
        .o_RX_Byte(UART_RX_0_o_RX_Byte),
        .o_RX_DV(UART_RX_0_o_RX_DV));
  design_1_fifo_generator_0_0 fifo_generator_0
       (.clk(clk_wiz_0_clk_out1),
        .data_count(fifo_generator_0_data_count),
        .din(UART_RX_0_o_RX_Byte),
        .dout(fifo_generator_0_dout),
        .empty(fifo_generator_0_empty),
        .full(fifo_generator_0_full),
        .rd_en(rd_en_0_1),
        .valid(fifo_generator_0_valid),
        .wr_ack(fifo_generator_0_wr_ack),
        .wr_en(UART_FIFO_IO_cntl_pr_0_fifoM_wr_en));
endmodule
