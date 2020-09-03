-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Wed Sep  2 16:24:02 2020
-- Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               d:/code/zed-68k/zed68k.srcs/sources_1/bd/design_1/ip/design_1_UART_FIFO_IO_cntl_pr_0_0/design_1_UART_FIFO_IO_cntl_pr_0_0_sim_netlist.vhdl
-- Design      : design_1_UART_FIFO_IO_cntl_pr_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_UART_FIFO_IO_cntl_pr_0_0_UART_FIFO_IO_cntl_proc is
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
  attribute ORIG_REF_NAME of design_1_UART_FIFO_IO_cntl_pr_0_0_UART_FIFO_IO_cntl_proc : entity is "UART_FIFO_IO_cntl_proc";
end design_1_UART_FIFO_IO_cntl_pr_0_0_UART_FIFO_IO_cntl_proc;

architecture STRUCTURE of design_1_UART_FIFO_IO_cntl_pr_0_0_UART_FIFO_IO_cntl_proc is
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
entity design_1_UART_FIFO_IO_cntl_pr_0_0 is
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
  attribute NotValidForBitStream of design_1_UART_FIFO_IO_cntl_pr_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_UART_FIFO_IO_cntl_pr_0_0 : entity is "design_1_UART_FIFO_IO_cntl_pr_0_0,UART_FIFO_IO_cntl_proc,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of design_1_UART_FIFO_IO_cntl_pr_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of design_1_UART_FIFO_IO_cntl_pr_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of design_1_UART_FIFO_IO_cntl_pr_0_0 : entity is "UART_FIFO_IO_cntl_proc,Vivado 2020.1";
end design_1_UART_FIFO_IO_cntl_pr_0_0;

architecture STRUCTURE of design_1_UART_FIFO_IO_cntl_pr_0_0 is
  signal \<const1>\ : STD_LOGIC;
  attribute x_interface_info : string;
  attribute x_interface_info of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of clk : signal is "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_1_clk100_i, INSERT_VIP 0";
  attribute x_interface_info of rst : signal is "xilinx.com:signal:reset:1.0 rst RST";
  attribute x_interface_parameter of rst : signal is "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0";
begin
  fifoM_rd_en <= \<const1>\;
U0: entity work.design_1_UART_FIFO_IO_cntl_pr_0_0_UART_FIFO_IO_cntl_proc
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
VCC: unisim.vcomponents.VCC
     port map (
      P => \<const1>\
    );
end STRUCTURE;
