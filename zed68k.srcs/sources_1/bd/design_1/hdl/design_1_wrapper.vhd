--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
--Date        : Wed Sep  2 16:21:20 2020
--Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
--Command     : generate_target design_1_wrapper.bd
--Design      : design_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_wrapper is
  port (
    LED : out STD_LOGIC_VECTOR ( 7 downto 0 );
    clk100_i : in STD_LOGIC;
    cts : out STD_LOGIC;
    m68_rxd : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rd_clk : in STD_LOGIC;
    rd_data_cnt : out STD_LOGIC_VECTOR ( 8 downto 0 );
    rd_en : in STD_LOGIC;
    reset_n : in STD_LOGIC;
    rts : out STD_LOGIC;
    rxd1 : in STD_LOGIC
  );
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  port (
    rxd1 : in STD_LOGIC;
    rd_clk : in STD_LOGIC;
    m68_rxd : out STD_LOGIC_VECTOR ( 7 downto 0 );
    LED : out STD_LOGIC_VECTOR ( 7 downto 0 );
    reset_n : in STD_LOGIC;
    cts : out STD_LOGIC;
    rts : out STD_LOGIC;
    rd_en : in STD_LOGIC;
    rd_data_cnt : out STD_LOGIC_VECTOR ( 8 downto 0 );
    clk100_i : in STD_LOGIC
  );
  end component design_1;
begin
design_1_i: component design_1
     port map (
      LED(7 downto 0) => LED(7 downto 0),
      clk100_i => clk100_i,
      cts => cts,
      m68_rxd(7 downto 0) => m68_rxd(7 downto 0),
      rd_clk => rd_clk,
      rd_data_cnt(8 downto 0) => rd_data_cnt(8 downto 0),
      rd_en => rd_en,
      reset_n => reset_n,
      rts => rts,
      rxd1 => rxd1
    );
end STRUCTURE;
