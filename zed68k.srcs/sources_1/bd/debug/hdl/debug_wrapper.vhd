--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
--Date        : Mon Aug  3 13:58:33 2020
--Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
--Command     : generate_target debug_wrapper.bd
--Design      : debug_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity debug_wrapper is
  port (
    address : in STD_LOGIC_VECTOR ( 26 downto 0 );
    clk : in STD_LOGIC;
    rdf_rdy : in STD_LOGIC_VECTOR ( 0 to 0 );
    readdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    state : in STD_LOGIC_VECTOR ( 2 downto 0 );
    tmp : in STD_LOGIC_VECTOR ( 0 to 0 );
    wdf_rdy : in STD_LOGIC_VECTOR ( 0 to 0 );
    writedata : in STD_LOGIC_VECTOR ( 63 downto 0 )
  );
end debug_wrapper;

architecture STRUCTURE of debug_wrapper is
  component debug is
  port (
    clk : in STD_LOGIC;
    address : in STD_LOGIC_VECTOR ( 26 downto 0 );
    state : in STD_LOGIC_VECTOR ( 2 downto 0 );
    readdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    writedata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    wdf_rdy : in STD_LOGIC_VECTOR ( 0 to 0 );
    rdf_rdy : in STD_LOGIC_VECTOR ( 0 to 0 );
    tmp : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component debug;
begin
debug_i: component debug
     port map (
      address(26 downto 0) => address(26 downto 0),
      clk => clk,
      rdf_rdy(0) => rdf_rdy(0),
      readdata(63 downto 0) => readdata(63 downto 0),
      state(2 downto 0) => state(2 downto 0),
      tmp(0) => tmp(0),
      wdf_rdy(0) => wdf_rdy(0),
      writedata(63 downto 0) => writedata(63 downto 0)
    );
end STRUCTURE;
