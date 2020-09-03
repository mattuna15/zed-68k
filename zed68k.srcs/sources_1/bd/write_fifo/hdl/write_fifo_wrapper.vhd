--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
--Date        : Sat Aug 29 11:10:27 2020
--Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
--Command     : generate_target write_fifo_wrapper.bd
--Design      : write_fifo_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity write_fifo_wrapper is
  port (
    clk : in STD_LOGIC;
    data_count : out STD_LOGIC_VECTOR ( 8 downto 0 );
    din : in STD_LOGIC_VECTOR ( 44 downto 0 );
    dout : out STD_LOGIC_VECTOR ( 44 downto 0 );
    rd_en : in STD_LOGIC;
    rst : in STD_LOGIC;
    wr_ack : out STD_LOGIC;
    wr_en : in STD_LOGIC
  );
end write_fifo_wrapper;

architecture STRUCTURE of write_fifo_wrapper is
  component write_fifo is
  port (
    rst : in STD_LOGIC;
    clk : in STD_LOGIC;
    wr_ack : out STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 44 downto 0 );
    dout : out STD_LOGIC_VECTOR ( 44 downto 0 );
    rd_en : in STD_LOGIC;
    data_count : out STD_LOGIC_VECTOR ( 8 downto 0 );
    wr_en : in STD_LOGIC
  );
  end component write_fifo;
begin
write_fifo_i: component write_fifo
     port map (
      clk => clk,
      data_count(8 downto 0) => data_count(8 downto 0),
      din(44 downto 0) => din(44 downto 0),
      dout(44 downto 0) => dout(44 downto 0),
      rd_en => rd_en,
      rst => rst,
      wr_ack => wr_ack,
      wr_en => wr_en
    );
end STRUCTURE;
