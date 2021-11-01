-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Sun Oct 31 06:50:13 2021
-- Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               d:/code/zed-68k/zed68k.srcs/sources_1/bd/serial/ip/serial_UART_FIFO_IO_cntl_pr_0_0/serial_UART_FIFO_IO_cntl_pr_0_0_sim_netlist.vhdl
-- Design      : serial_UART_FIFO_IO_cntl_pr_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity serial_UART_FIFO_IO_cntl_pr_0_0_UART_FIFO_IO_cntl_proc is
  port (
    uart_tx_wr_en : out STD_LOGIC;
    fifoM_wr_en : out STD_LOGIC;
    uart_rx_rd_en : out STD_LOGIC;
    clk : in STD_LOGIC;
    fifoM_wr_ack : in STD_LOGIC;
    fifoM_full : in STD_LOGIC;
    uart_rx_dv : in STD_LOGIC;
    uart_tx_rfd : in STD_LOGIC;
    fifoM_empty : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of serial_UART_FIFO_IO_cntl_pr_0_0_UART_FIFO_IO_cntl_proc : entity is "UART_FIFO_IO_cntl_proc";
end serial_UART_FIFO_IO_cntl_pr_0_0_UART_FIFO_IO_cntl_proc;

architecture STRUCTURE of serial_UART_FIFO_IO_cntl_pr_0_0_UART_FIFO_IO_cntl_proc is
  signal \^fifom_wr_en\ : STD_LOGIC;
  signal fifoM_wr_en_i_1_n_0 : STD_LOGIC;
  signal uart_rx_rd_en_i_1_n_0 : STD_LOGIC;
  signal uart_tx_wr_en_next : STD_LOGIC;
  signal uart_tx_wr_en_next0 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of fifoM_wr_en_i_1 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of uart_rx_rd_en_i_1 : label is "soft_lutpair0";
begin
  fifoM_wr_en <= \^fifom_wr_en\;
fifoM_wr_en_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4F44"
    )
        port map (
      I0 => fifoM_wr_ack,
      I1 => \^fifom_wr_en\,
      I2 => fifoM_full,
      I3 => uart_rx_dv,
      O => fifoM_wr_en_i_1_n_0
    );
fifoM_wr_en_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => fifoM_wr_en_i_1_n_0,
      Q => \^fifom_wr_en\,
      R => '0'
    );
uart_rx_rd_en_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => fifoM_full,
      O => uart_rx_rd_en_i_1_n_0
    );
uart_rx_rd_en_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => uart_rx_rd_en_i_1_n_0,
      Q => uart_rx_rd_en,
      R => '0'
    );
uart_tx_wr_en_next_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => uart_tx_rfd,
      I1 => fifoM_empty,
      O => uart_tx_wr_en_next0
    );
uart_tx_wr_en_next_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => uart_tx_wr_en_next0,
      Q => uart_tx_wr_en_next,
      R => '0'
    );
uart_tx_wr_en_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => uart_tx_wr_en_next,
      Q => uart_tx_wr_en,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity serial_UART_FIFO_IO_cntl_pr_0_0 is
  port (
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
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of serial_UART_FIFO_IO_cntl_pr_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of serial_UART_FIFO_IO_cntl_pr_0_0 : entity is "serial_UART_FIFO_IO_cntl_pr_0_0,UART_FIFO_IO_cntl_proc,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of serial_UART_FIFO_IO_cntl_pr_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of serial_UART_FIFO_IO_cntl_pr_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of serial_UART_FIFO_IO_cntl_pr_0_0 : entity is "UART_FIFO_IO_cntl_proc,Vivado 2020.1";
end serial_UART_FIFO_IO_cntl_pr_0_0;

architecture STRUCTURE of serial_UART_FIFO_IO_cntl_pr_0_0 is
  signal \<const1>\ : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN serial_sys_clk, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of rst : signal is "xilinx.com:signal:reset:1.0 rst RST";
  attribute X_INTERFACE_PARAMETER of rst : signal is "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0";
begin
  fifoM_rd_en <= \<const1>\;
VCC: unisim.vcomponents.VCC
     port map (
      P => \<const1>\
    );
inst: entity work.serial_UART_FIFO_IO_cntl_pr_0_0_UART_FIFO_IO_cntl_proc
     port map (
      clk => clk,
      fifoM_empty => fifoM_empty,
      fifoM_full => fifoM_full,
      fifoM_wr_ack => fifoM_wr_ack,
      fifoM_wr_en => fifoM_wr_en,
      uart_rx_dv => uart_rx_dv,
      uart_rx_rd_en => uart_rx_rd_en,
      uart_tx_rfd => uart_tx_rfd,
      uart_tx_wr_en => uart_tx_wr_en
    );
end STRUCTURE;
