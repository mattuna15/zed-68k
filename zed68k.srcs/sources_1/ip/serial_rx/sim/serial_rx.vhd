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

-- IP VLNV: xilinx.com:user:design_1:1.0
-- IP Revision: 2

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY serial_rx IS
  PORT (
    LED : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    clk100_i : IN STD_LOGIC;
    cts : OUT STD_LOGIC;
    m68_rxd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    rd_clk : IN STD_LOGIC;
    rd_data_cnt : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
    rd_en : IN STD_LOGIC;
    reset_n : IN STD_LOGIC;
    rts : OUT STD_LOGIC;
    rxd1 : IN STD_LOGIC
  );
END serial_rx;

ARCHITECTURE serial_rx_arch OF serial_rx IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF serial_rx_arch: ARCHITECTURE IS "yes";
  COMPONENT design_1 IS
    PORT (
      LED : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      clk100_i : IN STD_LOGIC;
      cts : OUT STD_LOGIC;
      m68_rxd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      rd_clk : IN STD_LOGIC;
      rd_data_cnt : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
      rd_en : IN STD_LOGIC;
      reset_n : IN STD_LOGIC;
      rts : OUT STD_LOGIC;
      rxd1 : IN STD_LOGIC
    );
  END COMPONENT design_1;
  ATTRIBUTE IP_DEFINITION_SOURCE : STRING;
  ATTRIBUTE IP_DEFINITION_SOURCE OF serial_rx_arch: ARCHITECTURE IS "IPI";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER OF reset_n: SIGNAL IS "XIL_INTERFACENAME RST.RESET_N, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF reset_n: SIGNAL IS "xilinx.com:signal:reset:1.0 RST.RESET_N RST";
  ATTRIBUTE X_INTERFACE_PARAMETER OF rd_clk: SIGNAL IS "XIL_INTERFACENAME CLK.RD_CLK, FREQ_HZ 100000000, PHASE 0.000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF rd_clk: SIGNAL IS "xilinx.com:signal:clock:1.0 CLK.RD_CLK CLK";
  ATTRIBUTE X_INTERFACE_PARAMETER OF clk100_i: SIGNAL IS "XIL_INTERFACENAME CLK.CLK100_I, FREQ_HZ 100000000, PHASE 0.000, ASSOCIATED_RESET reset_n, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF clk100_i: SIGNAL IS "xilinx.com:signal:clock:1.0 CLK.CLK100_I CLK";
BEGIN
  U0 : design_1
    PORT MAP (
      LED => LED,
      clk100_i => clk100_i,
      cts => cts,
      m68_rxd => m68_rxd,
      rd_clk => rd_clk,
      rd_data_cnt => rd_data_cnt,
      rd_en => rd_en,
      reset_n => reset_n,
      rts => rts,
      rxd1 => rxd1
    );
END serial_rx_arch;
