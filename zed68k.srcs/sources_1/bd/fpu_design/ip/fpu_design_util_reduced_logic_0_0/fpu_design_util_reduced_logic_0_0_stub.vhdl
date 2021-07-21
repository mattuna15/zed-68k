-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Wed Jul 21 11:23:51 2021
-- Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/code/zed-68k/zed68k.srcs/sources_1/bd/fpu_design/ip/fpu_design_util_reduced_logic_0_0/fpu_design_util_reduced_logic_0_0_stub.vhdl
-- Design      : fpu_design_util_reduced_logic_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35ticsg324-1L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fpu_design_util_reduced_logic_0_0 is
  Port ( 
    Op1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    Res : out STD_LOGIC
  );

end fpu_design_util_reduced_logic_0_0;

architecture stub of fpu_design_util_reduced_logic_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "Op1[7:0],Res";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "util_reduced_logic_v2_0_4_util_reduced_logic,Vivado 2020.1";
begin
end;
