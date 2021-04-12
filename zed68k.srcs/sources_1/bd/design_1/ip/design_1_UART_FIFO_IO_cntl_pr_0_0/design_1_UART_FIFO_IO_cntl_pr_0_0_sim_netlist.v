// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Fri Apr  9 21:25:29 2021
// Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/code/zed-68k/zed68k.srcs/sources_1/bd/design_1/ip/design_1_UART_FIFO_IO_cntl_pr_0_0/design_1_UART_FIFO_IO_cntl_pr_0_0_sim_netlist.v
// Design      : design_1_UART_FIFO_IO_cntl_pr_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_UART_FIFO_IO_cntl_pr_0_0,UART_FIFO_IO_cntl_proc,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "UART_FIFO_IO_cntl_proc,Vivado 2020.1" *) 
(* NotValidForBitStream *)
module design_1_UART_FIFO_IO_cntl_pr_0_0
   (clk,
    rst,
    uart_rx_dv,
    uart_tx_rfd,
    fifoM_full,
    fifoM_empty,
    fifoM_wr_ack,
    uart_rx_rd_en,
    uart_tx_wr_en,
    fifoM_wr_en,
    fifoM_rd_en);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_1_clk100_i, INSERT_VIP 0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input rst;
  input uart_rx_dv;
  input uart_tx_rfd;
  input fifoM_full;
  input fifoM_empty;
  input fifoM_wr_ack;
  output uart_rx_rd_en;
  output uart_tx_wr_en;
  output fifoM_wr_en;
  output fifoM_rd_en;

  wire \<const1> ;
  wire clk;
  wire fifoM_empty;
  wire fifoM_full;
  wire fifoM_wr_ack;
  wire fifoM_wr_en;
  wire uart_rx_dv;
  wire uart_rx_rd_en;
  wire uart_tx_rfd;
  wire uart_tx_wr_en;

  assign fifoM_rd_en = \<const1> ;
  VCC VCC
       (.P(\<const1> ));
  design_1_UART_FIFO_IO_cntl_pr_0_0_UART_FIFO_IO_cntl_proc inst
       (.clk(clk),
        .fifoM_empty(fifoM_empty),
        .fifoM_full(fifoM_full),
        .fifoM_wr_ack(fifoM_wr_ack),
        .fifoM_wr_en(fifoM_wr_en),
        .uart_rx_dv(uart_rx_dv),
        .uart_rx_rd_en(uart_rx_rd_en),
        .uart_tx_rfd(uart_tx_rfd),
        .uart_tx_wr_en(uart_tx_wr_en));
endmodule

(* ORIG_REF_NAME = "UART_FIFO_IO_cntl_proc" *) 
module design_1_UART_FIFO_IO_cntl_pr_0_0_UART_FIFO_IO_cntl_proc
   (uart_tx_wr_en,
    fifoM_wr_en,
    uart_rx_rd_en,
    clk,
    fifoM_wr_ack,
    fifoM_full,
    uart_rx_dv,
    uart_tx_rfd,
    fifoM_empty);
  output uart_tx_wr_en;
  output fifoM_wr_en;
  output uart_rx_rd_en;
  input clk;
  input fifoM_wr_ack;
  input fifoM_full;
  input uart_rx_dv;
  input uart_tx_rfd;
  input fifoM_empty;

  wire clk;
  wire fifoM_empty;
  wire fifoM_full;
  wire fifoM_wr_ack;
  wire fifoM_wr_en;
  wire fifoM_wr_en_i_1_n_0;
  wire uart_rx_dv;
  wire uart_rx_rd_en;
  wire uart_rx_rd_en_i_1_n_0;
  wire uart_tx_rfd;
  wire uart_tx_wr_en;
  wire uart_tx_wr_en_next;
  wire uart_tx_wr_en_next0;

  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h4F44)) 
    fifoM_wr_en_i_1
       (.I0(fifoM_wr_ack),
        .I1(fifoM_wr_en),
        .I2(fifoM_full),
        .I3(uart_rx_dv),
        .O(fifoM_wr_en_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    fifoM_wr_en_reg
       (.C(clk),
        .CE(1'b1),
        .D(fifoM_wr_en_i_1_n_0),
        .Q(fifoM_wr_en),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT1 #(
    .INIT(2'h1)) 
    uart_rx_rd_en_i_1
       (.I0(fifoM_full),
        .O(uart_rx_rd_en_i_1_n_0));
  FDRE uart_rx_rd_en_reg
       (.C(clk),
        .CE(1'b1),
        .D(uart_rx_rd_en_i_1_n_0),
        .Q(uart_rx_rd_en),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h2)) 
    uart_tx_wr_en_next_i_1
       (.I0(uart_tx_rfd),
        .I1(fifoM_empty),
        .O(uart_tx_wr_en_next0));
  FDRE uart_tx_wr_en_next_reg
       (.C(clk),
        .CE(1'b1),
        .D(uart_tx_wr_en_next0),
        .Q(uart_tx_wr_en_next),
        .R(1'b0));
  FDRE uart_tx_wr_en_reg
       (.C(clk),
        .CE(1'b1),
        .D(uart_tx_wr_en_next),
        .Q(uart_tx_wr_en),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
