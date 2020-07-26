-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Sun Jul 26 15:01:19 2020
-- Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/code/zed-68k/zed68k.srcs/sources_1/bd/design_1/ip/design_1_UART_FIFO_IO_cntl_pr_0_0/design_1_UART_FIFO_IO_cntl_pr_0_0_stub.vhdl
-- Design      : design_1_UART_FIFO_IO_cntl_pr_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_UART_FIFO_IO_cntl_pr_0_0 is
  Port ( 
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    uart_rx_dv : in STD_LOGIC;
    uart_tx_rfd : in STD_LOGIC;
    fifoM_full : in STD_LOGIC;
    fifoM_empty : in STD_LOGIC;
    fifoM_wr_ack : in STD_LOGIC;
    uart_rx_rd_en : out STD_LOGIC;
    uart_tx_wr_en : out STD_LOGIC;
    fifoM_wr_en : out STD_LOGIC;
    fifoM_rd_en : out STD_LOGIC
  );

end design_1_UART_FIFO_IO_cntl_pr_0_0;

architecture stub of design_1_UART_FIFO_IO_cntl_pr_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,rst,uart_rx_dv,uart_tx_rfd,fifoM_full,fifoM_empty,fifoM_wr_ack,uart_rx_rd_en,uart_tx_wr_en,fifoM_wr_en,fifoM_rd_en";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "UART_FIFO_IO_cntl_proc,Vivado 2020.1";
begin
end;
