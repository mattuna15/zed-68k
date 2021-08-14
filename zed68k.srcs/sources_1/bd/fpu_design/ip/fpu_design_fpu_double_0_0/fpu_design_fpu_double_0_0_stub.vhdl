-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Fri Aug 13 16:55:38 2021
-- Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/code/zed-68k/zed68k.srcs/sources_1/bd/fpu_design/ip/fpu_design_fpu_double_0_0/fpu_design_fpu_double_0_0_stub.vhdl
-- Design      : fpu_design_fpu_double_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35ticsg324-1L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fpu_design_fpu_double_0_0 is
  Port ( 
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    enable : in STD_LOGIC;
    rmode : in STD_LOGIC_VECTOR ( 1 downto 0 );
    fpu_op : in STD_LOGIC_VECTOR ( 2 downto 0 );
    opa : in STD_LOGIC_VECTOR ( 63 downto 0 );
    opb : in STD_LOGIC_VECTOR ( 63 downto 0 );
    out_fp : out STD_LOGIC_VECTOR ( 63 downto 0 );
    ready : out STD_LOGIC;
    underflow : out STD_LOGIC;
    overflow : out STD_LOGIC;
    inexact : out STD_LOGIC;
    exception : out STD_LOGIC;
    invalid : out STD_LOGIC
  );

end fpu_design_fpu_double_0_0;

architecture stub of fpu_design_fpu_double_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,rst,enable,rmode[1:0],fpu_op[2:0],opa[63:0],opb[63:0],out_fp[63:0],ready,underflow,overflow,inexact,exception,invalid";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "fpu_double,Vivado 2020.1";
begin
end;
