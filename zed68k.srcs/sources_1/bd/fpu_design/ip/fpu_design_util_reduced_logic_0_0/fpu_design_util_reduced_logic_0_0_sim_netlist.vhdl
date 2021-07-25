-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Sun Jul 25 07:37:12 2021
-- Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               d:/code/zed-68k/zed68k.srcs/sources_1/bd/fpu_design/ip/fpu_design_util_reduced_logic_0_0/fpu_design_util_reduced_logic_0_0_sim_netlist.vhdl
-- Design      : fpu_design_util_reduced_logic_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35ticsg324-1L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fpu_design_util_reduced_logic_0_0_util_reduced_logic_v2_0_4_util_reduced_logic is
  port (
    Res : out STD_LOGIC;
    Op1 : in STD_LOGIC_VECTOR ( 4 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of fpu_design_util_reduced_logic_0_0_util_reduced_logic_v2_0_4_util_reduced_logic : entity is "util_reduced_logic_v2_0_4_util_reduced_logic";
end fpu_design_util_reduced_logic_0_0_util_reduced_logic_v2_0_4_util_reduced_logic;

architecture STRUCTURE of fpu_design_util_reduced_logic_0_0_util_reduced_logic_v2_0_4_util_reduced_logic is
begin
Res0: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => Op1(0),
      I1 => Op1(3),
      I2 => Op1(4),
      I3 => Op1(1),
      I4 => Op1(2),
      O => Res
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fpu_design_util_reduced_logic_0_0 is
  port (
    Op1 : in STD_LOGIC_VECTOR ( 4 downto 0 );
    Res : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of fpu_design_util_reduced_logic_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of fpu_design_util_reduced_logic_0_0 : entity is "fpu_design_util_reduced_logic_0_0,util_reduced_logic_v2_0_4_util_reduced_logic,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of fpu_design_util_reduced_logic_0_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of fpu_design_util_reduced_logic_0_0 : entity is "util_reduced_logic_v2_0_4_util_reduced_logic,Vivado 2020.1";
end fpu_design_util_reduced_logic_0_0;

architecture STRUCTURE of fpu_design_util_reduced_logic_0_0 is
begin
inst: entity work.fpu_design_util_reduced_logic_0_0_util_reduced_logic_v2_0_4_util_reduced_logic
     port map (
      Op1(4 downto 0) => Op1(4 downto 0),
      Res => Res
    );
end STRUCTURE;
