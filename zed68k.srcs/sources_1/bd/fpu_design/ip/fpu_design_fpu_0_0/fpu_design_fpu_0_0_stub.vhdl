-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Mon Jul 26 14:30:14 2021
-- Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/code/zed-68k/zed68k.srcs/sources_1/bd/fpu_design/ip/fpu_design_fpu_0_0/fpu_design_fpu_0_0_stub.vhdl
-- Design      : fpu_design_fpu_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35ticsg324-1L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fpu_design_fpu_0_0 is
  Port ( 
    clk_i : in STD_LOGIC;
    opa_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    opb_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    fpu_op_i : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rmode_i : in STD_LOGIC_VECTOR ( 1 downto 0 );
    output_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    start_i : in STD_LOGIC;
    ready_o : out STD_LOGIC;
    ine_o : out STD_LOGIC;
    overflow_o : out STD_LOGIC;
    underflow_o : out STD_LOGIC;
    div_zero_o : out STD_LOGIC;
    inf_o : out STD_LOGIC;
    zero_o : out STD_LOGIC;
    qnan_o : out STD_LOGIC;
    snan_o : out STD_LOGIC
  );

end fpu_design_fpu_0_0;

architecture stub of fpu_design_fpu_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_i,opa_i[31:0],opb_i[31:0],fpu_op_i[2:0],rmode_i[1:0],output_o[31:0],start_i,ready_o,ine_o,overflow_o,underflow_o,div_zero_o,inf_o,zero_o,qnan_o,snan_o";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "fpu,Vivado 2020.1";
begin
end;
