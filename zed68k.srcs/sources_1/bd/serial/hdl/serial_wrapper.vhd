--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
--Date        : Wed Sep  2 16:21:23 2020
--Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
--Command     : generate_target serial_wrapper.bd
--Design      : serial_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity serial_wrapper is
  port (
    cts : out STD_LOGIC;
    reset_n : in STD_LOGIC;
    rts : out STD_LOGIC;
    sys_clk : in STD_LOGIC;
    tx_data : in STD_LOGIC_VECTOR ( 7 downto 0 );
    tx_send_active : out STD_LOGIC;
    tx_wr_en : in STD_LOGIC;
    txd : out STD_LOGIC
  );
end serial_wrapper;

architecture STRUCTURE of serial_wrapper is
  component serial is
  port (
    sys_clk : in STD_LOGIC;
    tx_data : in STD_LOGIC_VECTOR ( 7 downto 0 );
    tx_wr_en : in STD_LOGIC;
    cts : out STD_LOGIC;
    rts : out STD_LOGIC;
    reset_n : in STD_LOGIC;
    txd : out STD_LOGIC;
    tx_send_active : out STD_LOGIC
  );
  end component serial;
begin
serial_i: component serial
     port map (
      cts => cts,
      reset_n => reset_n,
      rts => rts,
      sys_clk => sys_clk,
      tx_data(7 downto 0) => tx_data(7 downto 0),
      tx_send_active => tx_send_active,
      tx_wr_en => tx_wr_en,
      txd => txd
    );
end STRUCTURE;
