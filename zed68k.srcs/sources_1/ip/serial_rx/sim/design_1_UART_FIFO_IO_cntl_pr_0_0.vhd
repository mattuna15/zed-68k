-- (c) Copyright 1995-2020 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:module_ref:UART_FIFO_IO_cntl_proc:1.0
-- IP Revision: 1

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY design_1_UART_FIFO_IO_cntl_pr_0_0 IS
  PORT (
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    uart_rx_dv : IN STD_LOGIC;
    uart_tx_rfd : IN STD_LOGIC;
    fifoM_full : IN STD_LOGIC;
    fifoM_empty : IN STD_LOGIC;
    fifoM_wr_ack : IN STD_LOGIC;
    uart_rx_rd_en : OUT STD_LOGIC;
    uart_tx_wr_en : OUT STD_LOGIC;
    fifoM_wr_en : OUT STD_LOGIC;
    fifoM_rd_en : OUT STD_LOGIC
  );
END design_1_UART_FIFO_IO_cntl_pr_0_0;

ARCHITECTURE design_1_UART_FIFO_IO_cntl_pr_0_0_arch OF design_1_UART_FIFO_IO_cntl_pr_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF design_1_UART_FIFO_IO_cntl_pr_0_0_arch: ARCHITECTURE IS "yes";
  COMPONENT UART_FIFO_IO_cntl_proc IS
    PORT (
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      uart_rx_dv : IN STD_LOGIC;
      uart_tx_rfd : IN STD_LOGIC;
      fifoM_full : IN STD_LOGIC;
      fifoM_empty : IN STD_LOGIC;
      fifoM_wr_ack : IN STD_LOGIC;
      uart_rx_rd_en : OUT STD_LOGIC;
      uart_tx_wr_en : OUT STD_LOGIC;
      fifoM_wr_en : OUT STD_LOGIC;
      fifoM_rd_en : OUT STD_LOGIC
    );
  END COMPONENT UART_FIFO_IO_cntl_proc;
  ATTRIBUTE IP_DEFINITION_SOURCE : STRING;
  ATTRIBUTE IP_DEFINITION_SOURCE OF design_1_UART_FIFO_IO_cntl_pr_0_0_arch: ARCHITECTURE IS "module_ref";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER OF rst: SIGNAL IS "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF rst: SIGNAL IS "xilinx.com:signal:reset:1.0 rst RST";
  ATTRIBUTE X_INTERFACE_PARAMETER OF clk: SIGNAL IS "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_1_clk100_i, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF clk: SIGNAL IS "xilinx.com:signal:clock:1.0 clk CLK";
BEGIN
  U0 : UART_FIFO_IO_cntl_proc
    PORT MAP (
      clk => clk,
      rst => rst,
      uart_rx_dv => uart_rx_dv,
      uart_tx_rfd => uart_tx_rfd,
      fifoM_full => fifoM_full,
      fifoM_empty => fifoM_empty,
      fifoM_wr_ack => fifoM_wr_ack,
      uart_rx_rd_en => uart_rx_rd_en,
      uart_tx_wr_en => uart_tx_wr_en,
      fifoM_wr_en => fifoM_wr_en,
      fifoM_rd_en => fifoM_rd_en
    );
END design_1_UART_FIFO_IO_cntl_pr_0_0_arch;