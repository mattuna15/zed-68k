-- (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
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

-- IP VLNV: mattpearce:user:axiddr:1.0
-- IP Revision: 10

-- The following code must appear in the VHDL architecture header.

------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
COMPONENT axiddr_0
  PORT (
    address : IN STD_LOGIC_VECTOR(27 DOWNTO 0);
    wr_data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    wr_byte_mask : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    i_cen : IN STD_LOGIC;
    i_wren : IN STD_LOGIC;
    i_valid_p : IN STD_LOGIC;
    rd_data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    o_ready_p : OUT STD_LOGIC;
    wr_ack_p : OUT STD_LOGIC;
    o_valid_p : OUT STD_LOGIC;
    ddr3_sdram_addr : OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
    ddr3_sdram_ba : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    ddr3_sdram_cas_n : OUT STD_LOGIC;
    ddr3_sdram_ck_n : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    ddr3_sdram_ck_p : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    ddr3_sdram_cke : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    ddr3_sdram_cs_n : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    ddr3_sdram_dm : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    ddr3_sdram_dq : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    ddr3_sdram_dqs_n : INOUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    ddr3_sdram_dqs_p : INOUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    ddr3_sdram_odt : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    ddr3_sdram_ras_n : OUT STD_LOGIC;
    ddr3_sdram_reset_n : OUT STD_LOGIC;
    ddr3_sdram_we_n : OUT STD_LOGIC;
    sys_resetn : IN STD_LOGIC;
    sys_clock : IN STD_LOGIC;
    clock166 : IN STD_LOGIC;
    clock200 : IN STD_LOGIC;
    init_calib_complete : OUT STD_LOGIC
  );
END COMPONENT;
-- COMP_TAG_END ------ End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
your_instance_name : axiddr_0
  PORT MAP (
    address => address,
    wr_data => wr_data,
    wr_byte_mask => wr_byte_mask,
    i_cen => i_cen,
    i_wren => i_wren,
    i_valid_p => i_valid_p,
    rd_data => rd_data,
    o_ready_p => o_ready_p,
    wr_ack_p => wr_ack_p,
    o_valid_p => o_valid_p,
    ddr3_sdram_addr => ddr3_sdram_addr,
    ddr3_sdram_ba => ddr3_sdram_ba,
    ddr3_sdram_cas_n => ddr3_sdram_cas_n,
    ddr3_sdram_ck_n => ddr3_sdram_ck_n,
    ddr3_sdram_ck_p => ddr3_sdram_ck_p,
    ddr3_sdram_cke => ddr3_sdram_cke,
    ddr3_sdram_cs_n => ddr3_sdram_cs_n,
    ddr3_sdram_dm => ddr3_sdram_dm,
    ddr3_sdram_dq => ddr3_sdram_dq,
    ddr3_sdram_dqs_n => ddr3_sdram_dqs_n,
    ddr3_sdram_dqs_p => ddr3_sdram_dqs_p,
    ddr3_sdram_odt => ddr3_sdram_odt,
    ddr3_sdram_ras_n => ddr3_sdram_ras_n,
    ddr3_sdram_reset_n => ddr3_sdram_reset_n,
    ddr3_sdram_we_n => ddr3_sdram_we_n,
    sys_resetn => sys_resetn,
    sys_clock => sys_clock,
    clock166 => clock166,
    clock200 => clock200,
    init_calib_complete => init_calib_complete
  );
-- INST_TAG_END ------ End INSTANTIATION Template ---------

