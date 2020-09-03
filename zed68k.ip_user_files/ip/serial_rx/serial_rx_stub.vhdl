-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Wed Sep  2 20:50:37 2020
-- Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub d:/code/zed-68k/zed68k.srcs/sources_1/ip/serial_rx/serial_rx_stub.vhdl
-- Design      : serial_rx
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity serial_rx is
  Port ( 
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

end serial_rx;

architecture stub of serial_rx is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "LED[7:0],clk100_i,cts,m68_rxd[7:0],rd_clk,rd_data_cnt[8:0],rd_en,reset_n,rts,rxd1";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "design_1,Vivado 2020.1";
begin
end;
