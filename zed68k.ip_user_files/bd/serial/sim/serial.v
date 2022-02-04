//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
//Date        : Tue Jan 25 09:01:06 2022
//Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
//Command     : generate_target serial.bd
//Design      : serial
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* HW_HANDOFF = "serial.hwdef" *) (* core_generation_info = "serial,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=serial,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=5,numReposBlks=5,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=2,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) 
module serial
   (cts,
    reset_n,
    rts,
    sys_clk,
    tx_data,
    tx_send_active,
    tx_wr_en,
    txd);
  output cts;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 RST.RESET_N RST" *) (* x_interface_parameter = "XIL_INTERFACENAME RST.RESET_N, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input reset_n;
  output rts;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 CLK.SYS_CLK CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME CLK.SYS_CLK, ASSOCIATED_RESET reset_n, CLK_DOMAIN serial_sys_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input sys_clk;
  input [7:0]tx_data;
  output [0:0]tx_send_active;
  input tx_wr_en;
  output txd;

  wire UART_FIFO_IO_cntl_pr_0_fifoM_rd_en;
  wire UART_FIFO_IO_cntl_pr_0_uart_rx_rd_en;
  wire UART_FIFO_IO_cntl_pr_0_uart_tx_wr_en;
  wire UART_TX_0_o_TX_Active;
  wire UART_TX_0_o_TX_Serial;
  wire clk_0_1;
  wire [7:0]din_0_1;
  wire [7:0]fifo_generator_0_dout;
  wire fifo_generator_0_full;
  wire fifo_generator_0_valid;
  wire fifo_generator_0_wr_ack;
  wire rst_0_1;
  wire [0:0]util_vector_logic_0_Res;
  wire [0:0]util_vector_logic_1_Res;
  wire wr_en_0_1;

  assign clk_0_1 = sys_clk;
  assign cts = UART_FIFO_IO_cntl_pr_0_uart_rx_rd_en;
  assign din_0_1 = tx_data[7:0];
  assign rst_0_1 = reset_n;
  assign rts = UART_FIFO_IO_cntl_pr_0_uart_tx_wr_en;
  assign tx_send_active[0] = util_vector_logic_0_Res;
  assign txd = UART_TX_0_o_TX_Serial;
  assign wr_en_0_1 = tx_wr_en;
  serial_UART_FIFO_IO_cntl_pr_0_0 UART_FIFO_IO_cntl_pr_0
       (.clk(clk_0_1),
        .fifoM_empty(1'b0),
        .fifoM_full(fifo_generator_0_full),
        .fifoM_rd_en(UART_FIFO_IO_cntl_pr_0_fifoM_rd_en),
        .fifoM_wr_ack(fifo_generator_0_wr_ack),
        .rst(rst_0_1),
        .uart_rx_dv(1'b0),
        .uart_rx_rd_en(UART_FIFO_IO_cntl_pr_0_uart_rx_rd_en),
        .uart_tx_rfd(util_vector_logic_1_Res),
        .uart_tx_wr_en(UART_FIFO_IO_cntl_pr_0_uart_tx_wr_en));
  serial_UART_TX_0_0 UART_TX_0
       (.i_Clk(clk_0_1),
        .i_TX_Byte(fifo_generator_0_dout),
        .i_TX_DV(fifo_generator_0_valid),
        .o_TX_Active(UART_TX_0_o_TX_Active),
        .o_TX_Serial(UART_TX_0_o_TX_Serial));
  serial_fifo_generator_0_0 fifo_generator_0
       (.clk(clk_0_1),
        .din(din_0_1),
        .dout(fifo_generator_0_dout),
        .full(fifo_generator_0_full),
        .rd_en(UART_FIFO_IO_cntl_pr_0_fifoM_rd_en),
        .valid(fifo_generator_0_valid),
        .wr_ack(fifo_generator_0_wr_ack),
        .wr_en(wr_en_0_1));
  serial_util_vector_logic_0_0 util_vector_logic_0
       (.Op1(fifo_generator_0_full),
        .Res(util_vector_logic_0_Res));
  serial_util_vector_logic_0_1 util_vector_logic_1
       (.Op1(UART_TX_0_o_TX_Active),
        .Res(util_vector_logic_1_Res));
endmodule
