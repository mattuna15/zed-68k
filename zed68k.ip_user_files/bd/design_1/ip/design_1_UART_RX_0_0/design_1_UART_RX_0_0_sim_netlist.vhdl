-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Sat Aug 15 12:49:05 2020
-- Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               d:/code/zed-68k/zed68k.srcs/sources_1/bd/design_1/ip/design_1_UART_RX_0_0/design_1_UART_RX_0_0_sim_netlist.vhdl
-- Design      : design_1_UART_RX_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_UART_RX_0_0_UART_RX is
  port (
    o_RX_DV : out STD_LOGIC;
    o_RX_Byte : out STD_LOGIC_VECTOR ( 7 downto 0 );
    i_RX_Serial : in STD_LOGIC;
    i_Clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_UART_RX_0_0_UART_RX : entity is "UART_RX";
end design_1_UART_RX_0_0_UART_RX;

architecture STRUCTURE of design_1_UART_RX_0_0_UART_RX is
  signal \^o_rx_byte\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \^o_rx_dv\ : STD_LOGIC;
  signal \r_Bit_Index[0]_i_1_n_0\ : STD_LOGIC;
  signal \r_Bit_Index[1]_i_1_n_0\ : STD_LOGIC;
  signal \r_Bit_Index[2]_i_1_n_0\ : STD_LOGIC;
  signal \r_Bit_Index[2]_i_2_n_0\ : STD_LOGIC;
  signal \r_Bit_Index_reg_n_0_[0]\ : STD_LOGIC;
  signal \r_Bit_Index_reg_n_0_[1]\ : STD_LOGIC;
  signal \r_Bit_Index_reg_n_0_[2]\ : STD_LOGIC;
  signal \r_Clk_Count[0]_i_1_n_0\ : STD_LOGIC;
  signal \r_Clk_Count[1]_i_1_n_0\ : STD_LOGIC;
  signal \r_Clk_Count[2]_i_1_n_0\ : STD_LOGIC;
  signal \r_Clk_Count[3]_i_1_n_0\ : STD_LOGIC;
  signal \r_Clk_Count[4]_i_1_n_0\ : STD_LOGIC;
  signal \r_Clk_Count[5]_i_1_n_0\ : STD_LOGIC;
  signal \r_Clk_Count[6]_i_1_n_0\ : STD_LOGIC;
  signal \r_Clk_Count[6]_i_2_n_0\ : STD_LOGIC;
  signal \r_Clk_Count[7]_i_1_n_0\ : STD_LOGIC;
  signal \r_Clk_Count[8]_i_1_n_0\ : STD_LOGIC;
  signal \r_Clk_Count[8]_i_2_n_0\ : STD_LOGIC;
  signal \r_Clk_Count[8]_i_3_n_0\ : STD_LOGIC;
  signal \r_Clk_Count[8]_i_4_n_0\ : STD_LOGIC;
  signal \r_Clk_Count[8]_i_5_n_0\ : STD_LOGIC;
  signal \r_Clk_Count[9]_i_1_n_0\ : STD_LOGIC;
  signal \r_Clk_Count[9]_i_2_n_0\ : STD_LOGIC;
  signal \r_Clk_Count[9]_i_3_n_0\ : STD_LOGIC;
  signal \r_Clk_Count[9]_i_4_n_0\ : STD_LOGIC;
  signal \r_Clk_Count_reg_n_0_[0]\ : STD_LOGIC;
  signal \r_Clk_Count_reg_n_0_[1]\ : STD_LOGIC;
  signal \r_Clk_Count_reg_n_0_[2]\ : STD_LOGIC;
  signal \r_Clk_Count_reg_n_0_[3]\ : STD_LOGIC;
  signal \r_Clk_Count_reg_n_0_[4]\ : STD_LOGIC;
  signal \r_Clk_Count_reg_n_0_[5]\ : STD_LOGIC;
  signal \r_Clk_Count_reg_n_0_[6]\ : STD_LOGIC;
  signal \r_Clk_Count_reg_n_0_[7]\ : STD_LOGIC;
  signal \r_Clk_Count_reg_n_0_[8]\ : STD_LOGIC;
  signal \r_Clk_Count_reg_n_0_[9]\ : STD_LOGIC;
  signal \r_RX_Byte[0]_i_1_n_0\ : STD_LOGIC;
  signal \r_RX_Byte[1]_i_1_n_0\ : STD_LOGIC;
  signal \r_RX_Byte[2]_i_1_n_0\ : STD_LOGIC;
  signal \r_RX_Byte[3]_i_1_n_0\ : STD_LOGIC;
  signal \r_RX_Byte[4]_i_1_n_0\ : STD_LOGIC;
  signal \r_RX_Byte[5]_i_1_n_0\ : STD_LOGIC;
  signal \r_RX_Byte[6]_i_1_n_0\ : STD_LOGIC;
  signal \r_RX_Byte[7]_i_1_n_0\ : STD_LOGIC;
  signal \r_RX_Byte[7]_i_2_n_0\ : STD_LOGIC;
  signal r_RX_DV_i_1_n_0 : STD_LOGIC;
  signal r_RX_DV_i_2_n_0 : STD_LOGIC;
  signal r_RX_DV_i_3_n_0 : STD_LOGIC;
  signal \r_SM_Main[0]_i_1_n_0\ : STD_LOGIC;
  signal \r_SM_Main[0]_i_2_n_0\ : STD_LOGIC;
  signal \r_SM_Main[0]_i_3_n_0\ : STD_LOGIC;
  signal \r_SM_Main[1]_i_1_n_0\ : STD_LOGIC;
  signal \r_SM_Main[1]_i_2_n_0\ : STD_LOGIC;
  signal \r_SM_Main[1]_i_3_n_0\ : STD_LOGIC;
  signal \r_SM_Main[2]_i_1_n_0\ : STD_LOGIC;
  signal \r_SM_Main_reg_n_0_[0]\ : STD_LOGIC;
  signal \r_SM_Main_reg_n_0_[1]\ : STD_LOGIC;
  signal \r_SM_Main_reg_n_0_[2]\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \r_Bit_Index[0]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \r_Bit_Index[2]_i_2\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \r_Clk_Count[3]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \r_Clk_Count[4]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \r_Clk_Count[6]_i_2\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \r_Clk_Count[7]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \r_Clk_Count[8]_i_4\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \r_Clk_Count[8]_i_5\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \r_Clk_Count[9]_i_2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \r_Clk_Count[9]_i_3\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \r_Clk_Count[9]_i_4\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of r_RX_DV_i_1 : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of r_RX_DV_i_3 : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \r_SM_Main[2]_i_1\ : label is "soft_lutpair3";
begin
  o_RX_Byte(7 downto 0) <= \^o_rx_byte\(7 downto 0);
  o_RX_DV <= \^o_rx_dv\;
\r_Bit_Index[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"99999990"
    )
        port map (
      I0 => \r_Bit_Index_reg_n_0_[0]\,
      I1 => \r_RX_Byte[7]_i_2_n_0\,
      I2 => \r_SM_Main_reg_n_0_[2]\,
      I3 => \r_SM_Main_reg_n_0_[1]\,
      I4 => \r_SM_Main_reg_n_0_[0]\,
      O => \r_Bit_Index[0]_i_1_n_0\
    );
\r_Bit_Index[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9A9A9A9A9A9A9A00"
    )
        port map (
      I0 => \r_Bit_Index_reg_n_0_[1]\,
      I1 => \r_RX_Byte[7]_i_2_n_0\,
      I2 => \r_Bit_Index_reg_n_0_[0]\,
      I3 => \r_SM_Main_reg_n_0_[2]\,
      I4 => \r_SM_Main_reg_n_0_[1]\,
      I5 => \r_SM_Main_reg_n_0_[0]\,
      O => \r_Bit_Index[1]_i_1_n_0\
    );
\r_Bit_Index[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9AAA00009AAA9AAA"
    )
        port map (
      I0 => \r_Bit_Index_reg_n_0_[2]\,
      I1 => \r_RX_Byte[7]_i_2_n_0\,
      I2 => \r_Bit_Index_reg_n_0_[0]\,
      I3 => \r_Bit_Index_reg_n_0_[1]\,
      I4 => \r_SM_Main_reg_n_0_[2]\,
      I5 => \r_Bit_Index[2]_i_2_n_0\,
      O => \r_Bit_Index[2]_i_1_n_0\
    );
\r_Bit_Index[2]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \r_SM_Main_reg_n_0_[1]\,
      I1 => \r_SM_Main_reg_n_0_[0]\,
      O => \r_Bit_Index[2]_i_2_n_0\
    );
\r_Bit_Index_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => '1',
      D => \r_Bit_Index[0]_i_1_n_0\,
      Q => \r_Bit_Index_reg_n_0_[0]\,
      R => '0'
    );
\r_Bit_Index_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => '1',
      D => \r_Bit_Index[1]_i_1_n_0\,
      Q => \r_Bit_Index_reg_n_0_[1]\,
      R => '0'
    );
\r_Bit_Index_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => '1',
      D => \r_Bit_Index[2]_i_1_n_0\,
      Q => \r_Bit_Index_reg_n_0_[2]\,
      R => '0'
    );
\r_Clk_Count[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CFCC1011"
    )
        port map (
      I0 => \r_Clk_Count[8]_i_4_n_0\,
      I1 => \r_SM_Main_reg_n_0_[2]\,
      I2 => \r_Clk_Count[6]_i_2_n_0\,
      I3 => \r_SM_Main_reg_n_0_[0]\,
      I4 => \r_Clk_Count_reg_n_0_[0]\,
      O => \r_Clk_Count[0]_i_1_n_0\
    );
\r_Clk_Count[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \r_Clk_Count_reg_n_0_[1]\,
      I1 => \r_Clk_Count_reg_n_0_[0]\,
      O => \r_Clk_Count[1]_i_1_n_0\
    );
\r_Clk_Count[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1555FFFF40550000"
    )
        port map (
      I0 => \r_Clk_Count[8]_i_4_n_0\,
      I1 => \r_Clk_Count_reg_n_0_[0]\,
      I2 => \r_Clk_Count_reg_n_0_[1]\,
      I3 => \r_Clk_Count[6]_i_2_n_0\,
      I4 => \r_Clk_Count[8]_i_2_n_0\,
      I5 => \r_Clk_Count_reg_n_0_[2]\,
      O => \r_Clk_Count[2]_i_1_n_0\
    );
\r_Clk_Count[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFFD555"
    )
        port map (
      I0 => \r_Clk_Count[6]_i_2_n_0\,
      I1 => \r_Clk_Count_reg_n_0_[2]\,
      I2 => \r_Clk_Count_reg_n_0_[0]\,
      I3 => \r_Clk_Count_reg_n_0_[1]\,
      I4 => \r_Clk_Count_reg_n_0_[3]\,
      O => \r_Clk_Count[3]_i_1_n_0\
    );
\r_Clk_Count[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => \r_Clk_Count_reg_n_0_[4]\,
      I1 => \r_Clk_Count_reg_n_0_[3]\,
      I2 => \r_Clk_Count_reg_n_0_[2]\,
      I3 => \r_Clk_Count_reg_n_0_[0]\,
      I4 => \r_Clk_Count_reg_n_0_[1]\,
      O => \r_Clk_Count[4]_i_1_n_0\
    );
\r_Clk_Count[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
        port map (
      I0 => \r_Clk_Count_reg_n_0_[5]\,
      I1 => \r_Clk_Count_reg_n_0_[4]\,
      I2 => \r_Clk_Count_reg_n_0_[1]\,
      I3 => \r_Clk_Count_reg_n_0_[0]\,
      I4 => \r_Clk_Count_reg_n_0_[2]\,
      I5 => \r_Clk_Count_reg_n_0_[3]\,
      O => \r_Clk_Count[5]_i_1_n_0\
    );
\r_Clk_Count[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F708FFFF"
    )
        port map (
      I0 => \r_Clk_Count_reg_n_0_[5]\,
      I1 => \r_Clk_Count_reg_n_0_[4]\,
      I2 => \r_Clk_Count[8]_i_5_n_0\,
      I3 => \r_Clk_Count_reg_n_0_[6]\,
      I4 => \r_Clk_Count[6]_i_2_n_0\,
      O => \r_Clk_Count[6]_i_1_n_0\
    );
\r_Clk_Count[6]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => \r_SM_Main[1]_i_2_n_0\,
      I1 => i_RX_Serial,
      O => \r_Clk_Count[6]_i_2_n_0\
    );
\r_Clk_Count[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"9AAAAAAA"
    )
        port map (
      I0 => \r_Clk_Count_reg_n_0_[7]\,
      I1 => \r_Clk_Count[8]_i_5_n_0\,
      I2 => \r_Clk_Count_reg_n_0_[4]\,
      I3 => \r_Clk_Count_reg_n_0_[5]\,
      I4 => \r_Clk_Count_reg_n_0_[6]\,
      O => \r_Clk_Count[7]_i_1_n_0\
    );
\r_Clk_Count[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30301033"
    )
        port map (
      I0 => \r_SM_Main_reg_n_0_[0]\,
      I1 => \r_SM_Main_reg_n_0_[2]\,
      I2 => \r_Clk_Count[8]_i_4_n_0\,
      I3 => i_RX_Serial,
      I4 => \r_SM_Main[1]_i_2_n_0\,
      O => \r_Clk_Count[8]_i_1_n_0\
    );
\r_Clk_Count[8]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4555"
    )
        port map (
      I0 => \r_SM_Main_reg_n_0_[2]\,
      I1 => \r_SM_Main[1]_i_2_n_0\,
      I2 => i_RX_Serial,
      I3 => \r_SM_Main_reg_n_0_[0]\,
      O => \r_Clk_Count[8]_i_2_n_0\
    );
\r_Clk_Count[8]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAA6AAAAAAA"
    )
        port map (
      I0 => \r_Clk_Count_reg_n_0_[8]\,
      I1 => \r_Clk_Count_reg_n_0_[7]\,
      I2 => \r_Clk_Count_reg_n_0_[6]\,
      I3 => \r_Clk_Count_reg_n_0_[5]\,
      I4 => \r_Clk_Count_reg_n_0_[4]\,
      I5 => \r_Clk_Count[8]_i_5_n_0\,
      O => \r_Clk_Count[8]_i_3_n_0\
    );
\r_Clk_Count[8]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"35"
    )
        port map (
      I0 => \r_SM_Main_reg_n_0_[0]\,
      I1 => r_RX_DV_i_2_n_0,
      I2 => \r_SM_Main_reg_n_0_[1]\,
      O => \r_Clk_Count[8]_i_4_n_0\
    );
\r_Clk_Count[8]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => \r_Clk_Count_reg_n_0_[1]\,
      I1 => \r_Clk_Count_reg_n_0_[0]\,
      I2 => \r_Clk_Count_reg_n_0_[2]\,
      I3 => \r_Clk_Count_reg_n_0_[3]\,
      O => \r_Clk_Count[8]_i_5_n_0\
    );
\r_Clk_Count[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFF0B00000004"
    )
        port map (
      I0 => \r_Clk_Count[9]_i_2_n_0\,
      I1 => \r_Clk_Count_reg_n_0_[8]\,
      I2 => \r_Clk_Count[9]_i_3_n_0\,
      I3 => \r_SM_Main_reg_n_0_[2]\,
      I4 => \r_Clk_Count[9]_i_4_n_0\,
      I5 => \r_Clk_Count_reg_n_0_[9]\,
      O => \r_Clk_Count[9]_i_1_n_0\
    );
\r_Clk_Count[9]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BFFFFFFF"
    )
        port map (
      I0 => \r_Clk_Count[8]_i_5_n_0\,
      I1 => \r_Clk_Count_reg_n_0_[4]\,
      I2 => \r_Clk_Count_reg_n_0_[5]\,
      I3 => \r_Clk_Count_reg_n_0_[6]\,
      I4 => \r_Clk_Count_reg_n_0_[7]\,
      O => \r_Clk_Count[9]_i_2_n_0\
    );
\r_Clk_Count[9]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"57F7"
    )
        port map (
      I0 => \r_SM_Main[1]_i_2_n_0\,
      I1 => \r_SM_Main_reg_n_0_[0]\,
      I2 => \r_SM_Main_reg_n_0_[1]\,
      I3 => r_RX_DV_i_2_n_0,
      O => \r_Clk_Count[9]_i_3_n_0\
    );
\r_Clk_Count[9]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => \r_SM_Main_reg_n_0_[0]\,
      I1 => i_RX_Serial,
      I2 => \r_SM_Main[1]_i_2_n_0\,
      O => \r_Clk_Count[9]_i_4_n_0\
    );
\r_Clk_Count_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => '1',
      D => \r_Clk_Count[0]_i_1_n_0\,
      Q => \r_Clk_Count_reg_n_0_[0]\,
      R => '0'
    );
\r_Clk_Count_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => \r_Clk_Count[8]_i_2_n_0\,
      D => \r_Clk_Count[1]_i_1_n_0\,
      Q => \r_Clk_Count_reg_n_0_[1]\,
      R => \r_Clk_Count[8]_i_1_n_0\
    );
\r_Clk_Count_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => '1',
      D => \r_Clk_Count[2]_i_1_n_0\,
      Q => \r_Clk_Count_reg_n_0_[2]\,
      R => '0'
    );
\r_Clk_Count_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => \r_Clk_Count[8]_i_2_n_0\,
      D => \r_Clk_Count[3]_i_1_n_0\,
      Q => \r_Clk_Count_reg_n_0_[3]\,
      R => \r_Clk_Count[8]_i_1_n_0\
    );
\r_Clk_Count_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => \r_Clk_Count[8]_i_2_n_0\,
      D => \r_Clk_Count[4]_i_1_n_0\,
      Q => \r_Clk_Count_reg_n_0_[4]\,
      R => \r_Clk_Count[8]_i_1_n_0\
    );
\r_Clk_Count_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => \r_Clk_Count[8]_i_2_n_0\,
      D => \r_Clk_Count[5]_i_1_n_0\,
      Q => \r_Clk_Count_reg_n_0_[5]\,
      R => \r_Clk_Count[8]_i_1_n_0\
    );
\r_Clk_Count_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => \r_Clk_Count[8]_i_2_n_0\,
      D => \r_Clk_Count[6]_i_1_n_0\,
      Q => \r_Clk_Count_reg_n_0_[6]\,
      R => \r_Clk_Count[8]_i_1_n_0\
    );
\r_Clk_Count_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => \r_Clk_Count[8]_i_2_n_0\,
      D => \r_Clk_Count[7]_i_1_n_0\,
      Q => \r_Clk_Count_reg_n_0_[7]\,
      R => \r_Clk_Count[8]_i_1_n_0\
    );
\r_Clk_Count_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => \r_Clk_Count[8]_i_2_n_0\,
      D => \r_Clk_Count[8]_i_3_n_0\,
      Q => \r_Clk_Count_reg_n_0_[8]\,
      R => \r_Clk_Count[8]_i_1_n_0\
    );
\r_Clk_Count_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => '1',
      D => \r_Clk_Count[9]_i_1_n_0\,
      Q => \r_Clk_Count_reg_n_0_[9]\,
      R => '0'
    );
\r_RX_Byte[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => i_RX_Serial,
      I1 => \r_Bit_Index_reg_n_0_[1]\,
      I2 => \r_Bit_Index_reg_n_0_[0]\,
      I3 => \r_RX_Byte[7]_i_2_n_0\,
      I4 => \r_Bit_Index_reg_n_0_[2]\,
      I5 => \^o_rx_byte\(0),
      O => \r_RX_Byte[0]_i_1_n_0\
    );
\r_RX_Byte[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFEF00000020"
    )
        port map (
      I0 => i_RX_Serial,
      I1 => \r_Bit_Index_reg_n_0_[1]\,
      I2 => \r_Bit_Index_reg_n_0_[0]\,
      I3 => \r_RX_Byte[7]_i_2_n_0\,
      I4 => \r_Bit_Index_reg_n_0_[2]\,
      I5 => \^o_rx_byte\(1),
      O => \r_RX_Byte[1]_i_1_n_0\
    );
\r_RX_Byte[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFEF00000020"
    )
        port map (
      I0 => i_RX_Serial,
      I1 => \r_Bit_Index_reg_n_0_[0]\,
      I2 => \r_Bit_Index_reg_n_0_[1]\,
      I3 => \r_RX_Byte[7]_i_2_n_0\,
      I4 => \r_Bit_Index_reg_n_0_[2]\,
      I5 => \^o_rx_byte\(2),
      O => \r_RX_Byte[2]_i_1_n_0\
    );
\r_RX_Byte[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFBF00000080"
    )
        port map (
      I0 => i_RX_Serial,
      I1 => \r_Bit_Index_reg_n_0_[1]\,
      I2 => \r_Bit_Index_reg_n_0_[0]\,
      I3 => \r_RX_Byte[7]_i_2_n_0\,
      I4 => \r_Bit_Index_reg_n_0_[2]\,
      I5 => \^o_rx_byte\(3),
      O => \r_RX_Byte[3]_i_1_n_0\
    );
\r_RX_Byte[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFEFF00000200"
    )
        port map (
      I0 => i_RX_Serial,
      I1 => \r_Bit_Index_reg_n_0_[1]\,
      I2 => \r_Bit_Index_reg_n_0_[0]\,
      I3 => \r_Bit_Index_reg_n_0_[2]\,
      I4 => \r_RX_Byte[7]_i_2_n_0\,
      I5 => \^o_rx_byte\(4),
      O => \r_RX_Byte[4]_i_1_n_0\
    );
\r_RX_Byte[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEFFF00002000"
    )
        port map (
      I0 => i_RX_Serial,
      I1 => \r_Bit_Index_reg_n_0_[1]\,
      I2 => \r_Bit_Index_reg_n_0_[0]\,
      I3 => \r_Bit_Index_reg_n_0_[2]\,
      I4 => \r_RX_Byte[7]_i_2_n_0\,
      I5 => \^o_rx_byte\(5),
      O => \r_RX_Byte[5]_i_1_n_0\
    );
\r_RX_Byte[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEFFF00002000"
    )
        port map (
      I0 => i_RX_Serial,
      I1 => \r_Bit_Index_reg_n_0_[0]\,
      I2 => \r_Bit_Index_reg_n_0_[1]\,
      I3 => \r_Bit_Index_reg_n_0_[2]\,
      I4 => \r_RX_Byte[7]_i_2_n_0\,
      I5 => \^o_rx_byte\(6),
      O => \r_RX_Byte[6]_i_1_n_0\
    );
\r_RX_Byte[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFFFFFFF20000000"
    )
        port map (
      I0 => i_RX_Serial,
      I1 => \r_RX_Byte[7]_i_2_n_0\,
      I2 => \r_Bit_Index_reg_n_0_[2]\,
      I3 => \r_Bit_Index_reg_n_0_[0]\,
      I4 => \r_Bit_Index_reg_n_0_[1]\,
      I5 => \^o_rx_byte\(7),
      O => \r_RX_Byte[7]_i_1_n_0\
    );
\r_RX_Byte[7]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FEFF"
    )
        port map (
      I0 => \r_SM_Main_reg_n_0_[2]\,
      I1 => \r_SM_Main_reg_n_0_[0]\,
      I2 => r_RX_DV_i_2_n_0,
      I3 => \r_SM_Main_reg_n_0_[1]\,
      O => \r_RX_Byte[7]_i_2_n_0\
    );
\r_RX_Byte_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => '1',
      D => \r_RX_Byte[0]_i_1_n_0\,
      Q => \^o_rx_byte\(0),
      R => '0'
    );
\r_RX_Byte_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => '1',
      D => \r_RX_Byte[1]_i_1_n_0\,
      Q => \^o_rx_byte\(1),
      R => '0'
    );
\r_RX_Byte_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => '1',
      D => \r_RX_Byte[2]_i_1_n_0\,
      Q => \^o_rx_byte\(2),
      R => '0'
    );
\r_RX_Byte_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => '1',
      D => \r_RX_Byte[3]_i_1_n_0\,
      Q => \^o_rx_byte\(3),
      R => '0'
    );
\r_RX_Byte_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => '1',
      D => \r_RX_Byte[4]_i_1_n_0\,
      Q => \^o_rx_byte\(4),
      R => '0'
    );
\r_RX_Byte_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => '1',
      D => \r_RX_Byte[5]_i_1_n_0\,
      Q => \^o_rx_byte\(5),
      R => '0'
    );
\r_RX_Byte_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => '1',
      D => \r_RX_Byte[6]_i_1_n_0\,
      Q => \^o_rx_byte\(6),
      R => '0'
    );
\r_RX_Byte_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => '1',
      D => \r_RX_Byte[7]_i_1_n_0\,
      Q => \^o_rx_byte\(7),
      R => '0'
    );
r_RX_DV_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FCFC0040"
    )
        port map (
      I0 => r_RX_DV_i_2_n_0,
      I1 => \r_SM_Main_reg_n_0_[1]\,
      I2 => \r_SM_Main_reg_n_0_[0]\,
      I3 => \r_SM_Main_reg_n_0_[2]\,
      I4 => \^o_rx_dv\,
      O => r_RX_DV_i_1_n_0
    );
r_RX_DV_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"777777777FFFFFFF"
    )
        port map (
      I0 => \r_Clk_Count_reg_n_0_[9]\,
      I1 => \r_Clk_Count_reg_n_0_[8]\,
      I2 => r_RX_DV_i_3_n_0,
      I3 => \r_Clk_Count_reg_n_0_[6]\,
      I4 => \r_Clk_Count_reg_n_0_[5]\,
      I5 => \r_Clk_Count_reg_n_0_[7]\,
      O => r_RX_DV_i_2_n_0
    );
r_RX_DV_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFF8"
    )
        port map (
      I0 => \r_Clk_Count_reg_n_0_[1]\,
      I1 => \r_Clk_Count_reg_n_0_[0]\,
      I2 => \r_Clk_Count_reg_n_0_[2]\,
      I3 => \r_Clk_Count_reg_n_0_[3]\,
      I4 => \r_Clk_Count_reg_n_0_[4]\,
      O => r_RX_DV_i_3_n_0
    );
r_RX_DV_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => '1',
      D => r_RX_DV_i_1_n_0,
      Q => \^o_rx_dv\,
      R => '0'
    );
\r_SM_Main[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000440555555555"
    )
        port map (
      I0 => \r_SM_Main_reg_n_0_[2]\,
      I1 => \r_SM_Main[0]_i_2_n_0\,
      I2 => i_RX_Serial,
      I3 => \r_SM_Main_reg_n_0_[0]\,
      I4 => \r_SM_Main_reg_n_0_[1]\,
      I5 => \r_SM_Main[0]_i_3_n_0\,
      O => \r_SM_Main[0]_i_1_n_0\
    );
\r_SM_Main[0]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFB"
    )
        port map (
      I0 => \r_Clk_Count_reg_n_0_[1]\,
      I1 => \r_Clk_Count_reg_n_0_[7]\,
      I2 => \r_Clk_Count_reg_n_0_[2]\,
      I3 => \r_Clk_Count_reg_n_0_[6]\,
      I4 => \r_SM_Main[1]_i_3_n_0\,
      O => \r_SM_Main[0]_i_2_n_0\
    );
\r_SM_Main[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"77777777DFFFFFFF"
    )
        port map (
      I0 => \r_SM_Main_reg_n_0_[1]\,
      I1 => r_RX_DV_i_2_n_0,
      I2 => \r_Bit_Index_reg_n_0_[2]\,
      I3 => \r_Bit_Index_reg_n_0_[0]\,
      I4 => \r_Bit_Index_reg_n_0_[1]\,
      I5 => \r_SM_Main_reg_n_0_[0]\,
      O => \r_SM_Main[0]_i_3_n_0\
    );
\r_SM_Main[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5555111500040004"
    )
        port map (
      I0 => \r_SM_Main_reg_n_0_[2]\,
      I1 => \r_SM_Main_reg_n_0_[0]\,
      I2 => \r_SM_Main[1]_i_2_n_0\,
      I3 => i_RX_Serial,
      I4 => r_RX_DV_i_2_n_0,
      I5 => \r_SM_Main_reg_n_0_[1]\,
      O => \r_SM_Main[1]_i_1_n_0\
    );
\r_SM_Main[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFEFFFF"
    )
        port map (
      I0 => \r_SM_Main_reg_n_0_[1]\,
      I1 => \r_SM_Main[1]_i_3_n_0\,
      I2 => \r_Clk_Count_reg_n_0_[6]\,
      I3 => \r_Clk_Count_reg_n_0_[2]\,
      I4 => \r_Clk_Count_reg_n_0_[7]\,
      I5 => \r_Clk_Count_reg_n_0_[1]\,
      O => \r_SM_Main[1]_i_2_n_0\
    );
\r_SM_Main[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF7FFFFFFFFFFFF"
    )
        port map (
      I0 => \r_Clk_Count_reg_n_0_[5]\,
      I1 => \r_Clk_Count_reg_n_0_[4]\,
      I2 => \r_Clk_Count_reg_n_0_[3]\,
      I3 => \r_Clk_Count_reg_n_0_[9]\,
      I4 => \r_Clk_Count_reg_n_0_[0]\,
      I5 => \r_Clk_Count_reg_n_0_[8]\,
      O => \r_SM_Main[1]_i_3_n_0\
    );
\r_SM_Main[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0400"
    )
        port map (
      I0 => r_RX_DV_i_2_n_0,
      I1 => \r_SM_Main_reg_n_0_[1]\,
      I2 => \r_SM_Main_reg_n_0_[2]\,
      I3 => \r_SM_Main_reg_n_0_[0]\,
      O => \r_SM_Main[2]_i_1_n_0\
    );
\r_SM_Main_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => '1',
      D => \r_SM_Main[0]_i_1_n_0\,
      Q => \r_SM_Main_reg_n_0_[0]\,
      R => '0'
    );
\r_SM_Main_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => '1',
      D => \r_SM_Main[1]_i_1_n_0\,
      Q => \r_SM_Main_reg_n_0_[1]\,
      R => '0'
    );
\r_SM_Main_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => '1',
      D => \r_SM_Main[2]_i_1_n_0\,
      Q => \r_SM_Main_reg_n_0_[2]\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_UART_RX_0_0 is
  port (
    i_Clk : in STD_LOGIC;
    i_RX_Serial : in STD_LOGIC;
    o_RX_DV : out STD_LOGIC;
    o_RX_Byte : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_UART_RX_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_UART_RX_0_0 : entity is "design_1_UART_RX_0_0,UART_RX,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of design_1_UART_RX_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of design_1_UART_RX_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of design_1_UART_RX_0_0 : entity is "UART_RX,Vivado 2020.1";
end design_1_UART_RX_0_0;

architecture STRUCTURE of design_1_UART_RX_0_0 is
  attribute x_interface_info : string;
  attribute x_interface_info of i_Clk : signal is "xilinx.com:signal:clock:1.0 i_Clk CLK";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of i_Clk : signal is "XIL_INTERFACENAME i_Clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_1_clk100_i, INSERT_VIP 0";
begin
U0: entity work.design_1_UART_RX_0_0_UART_RX
     port map (
      i_Clk => i_Clk,
      i_RX_Serial => i_RX_Serial,
      o_RX_Byte(7 downto 0) => o_RX_Byte(7 downto 0),
      o_RX_DV => o_RX_DV
    );
end STRUCTURE;
