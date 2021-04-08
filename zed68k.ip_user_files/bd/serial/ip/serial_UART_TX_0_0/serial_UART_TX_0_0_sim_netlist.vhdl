-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Mon Apr  5 21:25:22 2021
-- Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               d:/code/zed-68k/zed68k.srcs/sources_1/bd/serial/ip/serial_UART_TX_0_0/serial_UART_TX_0_0_sim_netlist.vhdl
-- Design      : serial_UART_TX_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35ticsg324-1L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity serial_UART_TX_0_0_UART_TX is
  port (
    o_TX_Active : out STD_LOGIC;
    o_TX_Serial : out STD_LOGIC;
    o_TX_Done : out STD_LOGIC;
    i_TX_DV : in STD_LOGIC;
    i_Clk : in STD_LOGIC;
    i_TX_Byte : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of serial_UART_TX_0_0_UART_TX : entity is "UART_TX";
end serial_UART_TX_0_0_UART_TX;

architecture STRUCTURE of serial_UART_TX_0_0_UART_TX is
  signal \FSM_sequential_r_SM_Main[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_r_SM_Main[0]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_r_SM_Main[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_r_SM_Main[2]_i_1_n_0\ : STD_LOGIC;
  signal \^o_tx_active\ : STD_LOGIC;
  signal o_TX_Active_i_1_n_0 : STD_LOGIC;
  signal \^o_tx_done\ : STD_LOGIC;
  signal \^o_tx_serial\ : STD_LOGIC;
  signal o_TX_Serial_i_1_n_0 : STD_LOGIC;
  signal o_TX_Serial_i_3_n_0 : STD_LOGIC;
  signal o_TX_Serial_i_4_n_0 : STD_LOGIC;
  signal o_TX_Serial_reg_i_2_n_0 : STD_LOGIC;
  signal \r_Bit_Index[0]_i_1_n_0\ : STD_LOGIC;
  signal \r_Bit_Index[1]_i_1_n_0\ : STD_LOGIC;
  signal \r_Bit_Index[2]_i_1_n_0\ : STD_LOGIC;
  signal \r_Bit_Index[2]_i_2_n_0\ : STD_LOGIC;
  signal \r_Bit_Index_reg_n_0_[0]\ : STD_LOGIC;
  signal \r_Bit_Index_reg_n_0_[1]\ : STD_LOGIC;
  signal \r_Bit_Index_reg_n_0_[2]\ : STD_LOGIC;
  signal r_Clk_Count : STD_LOGIC_VECTOR ( 9 downto 1 );
  signal r_Clk_Count0 : STD_LOGIC;
  signal \r_Clk_Count[0]_i_1_n_0\ : STD_LOGIC;
  signal \r_Clk_Count[5]_i_2_n_0\ : STD_LOGIC;
  signal \r_Clk_Count[9]_i_4_n_0\ : STD_LOGIC;
  signal r_Clk_Count_0 : STD_LOGIC;
  signal r_Clk_Count_reg : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal r_SM_Main : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal r_TX_Data : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal r_TX_Data_1 : STD_LOGIC;
  signal r_TX_Done_i_1_n_0 : STD_LOGIC;
  signal r_TX_Done_i_2_n_0 : STD_LOGIC;
  signal r_TX_Done_i_3_n_0 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_r_SM_Main[1]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \FSM_sequential_r_SM_Main[2]_i_1\ : label is "soft_lutpair4";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_r_SM_Main_reg[0]\ : label is "s_idle:000,s_tx_start_bit:001,s_tx_data_bits:010,s_cleanup:100,s_tx_stop_bit:011";
  attribute FSM_ENCODED_STATES of \FSM_sequential_r_SM_Main_reg[1]\ : label is "s_idle:000,s_tx_start_bit:001,s_tx_data_bits:010,s_cleanup:100,s_tx_stop_bit:011";
  attribute FSM_ENCODED_STATES of \FSM_sequential_r_SM_Main_reg[2]\ : label is "s_idle:000,s_tx_start_bit:001,s_tx_data_bits:010,s_cleanup:100,s_tx_stop_bit:011";
  attribute SOFT_HLUTNM of o_TX_Active_i_1 : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of o_TX_Serial_i_1 : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \r_Bit_Index[2]_i_2\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \r_Clk_Count[0]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \r_Clk_Count[1]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \r_Clk_Count[2]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \r_Clk_Count[3]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \r_Clk_Count[5]_i_2\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \r_Clk_Count[7]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \r_Clk_Count[8]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of r_TX_Done_i_1 : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of r_TX_Done_i_3 : label is "soft_lutpair2";
begin
  o_TX_Active <= \^o_tx_active\;
  o_TX_Done <= \^o_tx_done\;
  o_TX_Serial <= \^o_tx_serial\;
\FSM_sequential_r_SM_Main[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000C0E2C3E2"
    )
        port map (
      I0 => i_TX_DV,
      I1 => r_SM_Main(0),
      I2 => r_TX_Done_i_2_n_0,
      I3 => r_SM_Main(1),
      I4 => \FSM_sequential_r_SM_Main[0]_i_2_n_0\,
      I5 => r_SM_Main(2),
      O => \FSM_sequential_r_SM_Main[0]_i_1_n_0\
    );
\FSM_sequential_r_SM_Main[0]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
        port map (
      I0 => \r_Bit_Index_reg_n_0_[2]\,
      I1 => \r_Bit_Index_reg_n_0_[1]\,
      I2 => \r_Bit_Index_reg_n_0_[0]\,
      O => \FSM_sequential_r_SM_Main[0]_i_2_n_0\
    );
\FSM_sequential_r_SM_Main[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00D2"
    )
        port map (
      I0 => r_SM_Main(0),
      I1 => r_TX_Done_i_2_n_0,
      I2 => r_SM_Main(1),
      I3 => r_SM_Main(2),
      O => \FSM_sequential_r_SM_Main[1]_i_1_n_0\
    );
\FSM_sequential_r_SM_Main[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0020"
    )
        port map (
      I0 => r_SM_Main(0),
      I1 => r_TX_Done_i_2_n_0,
      I2 => r_SM_Main(1),
      I3 => r_SM_Main(2),
      O => \FSM_sequential_r_SM_Main[2]_i_1_n_0\
    );
\FSM_sequential_r_SM_Main_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => '1',
      D => \FSM_sequential_r_SM_Main[0]_i_1_n_0\,
      Q => r_SM_Main(0),
      R => '0'
    );
\FSM_sequential_r_SM_Main_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => '1',
      D => \FSM_sequential_r_SM_Main[1]_i_1_n_0\,
      Q => r_SM_Main(1),
      R => '0'
    );
\FSM_sequential_r_SM_Main_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => '1',
      D => \FSM_sequential_r_SM_Main[2]_i_1_n_0\,
      Q => r_SM_Main(2),
      R => '0'
    );
o_TX_Active_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FA10"
    )
        port map (
      I0 => r_SM_Main(1),
      I1 => r_SM_Main(2),
      I2 => r_SM_Main(0),
      I3 => \^o_tx_active\,
      O => o_TX_Active_i_1_n_0
    );
o_TX_Active_reg: unisim.vcomponents.FDRE
     port map (
      C => i_Clk,
      CE => '1',
      D => o_TX_Active_i_1_n_0,
      Q => \^o_tx_active\,
      R => '0'
    );
o_TX_Serial_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BB8BB88B"
    )
        port map (
      I0 => \^o_tx_serial\,
      I1 => r_SM_Main(2),
      I2 => r_SM_Main(0),
      I3 => r_SM_Main(1),
      I4 => o_TX_Serial_reg_i_2_n_0,
      O => o_TX_Serial_i_1_n_0
    );
o_TX_Serial_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r_TX_Data(3),
      I1 => r_TX_Data(2),
      I2 => \r_Bit_Index_reg_n_0_[1]\,
      I3 => r_TX_Data(1),
      I4 => \r_Bit_Index_reg_n_0_[0]\,
      I5 => r_TX_Data(0),
      O => o_TX_Serial_i_3_n_0
    );
o_TX_Serial_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r_TX_Data(7),
      I1 => r_TX_Data(6),
      I2 => \r_Bit_Index_reg_n_0_[1]\,
      I3 => r_TX_Data(5),
      I4 => \r_Bit_Index_reg_n_0_[0]\,
      I5 => r_TX_Data(4),
      O => o_TX_Serial_i_4_n_0
    );
o_TX_Serial_reg: unisim.vcomponents.FDRE
     port map (
      C => i_Clk,
      CE => '1',
      D => o_TX_Serial_i_1_n_0,
      Q => \^o_tx_serial\,
      R => '0'
    );
o_TX_Serial_reg_i_2: unisim.vcomponents.MUXF7
     port map (
      I0 => o_TX_Serial_i_3_n_0,
      I1 => o_TX_Serial_i_4_n_0,
      O => o_TX_Serial_reg_i_2_n_0,
      S => \r_Bit_Index_reg_n_0_[2]\
    );
\r_Bit_Index[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAA98AAAAAA00"
    )
        port map (
      I0 => \r_Bit_Index_reg_n_0_[0]\,
      I1 => r_TX_Done_i_2_n_0,
      I2 => \FSM_sequential_r_SM_Main[0]_i_2_n_0\,
      I3 => r_SM_Main(2),
      I4 => r_SM_Main(0),
      I5 => r_SM_Main(1),
      O => \r_Bit_Index[0]_i_1_n_0\
    );
\r_Bit_Index[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AA9AAA00"
    )
        port map (
      I0 => \r_Bit_Index_reg_n_0_[1]\,
      I1 => r_TX_Done_i_2_n_0,
      I2 => \r_Bit_Index_reg_n_0_[0]\,
      I3 => \r_Bit_Index[2]_i_2_n_0\,
      I4 => r_SM_Main(1),
      O => \r_Bit_Index[1]_i_1_n_0\
    );
\r_Bit_Index[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAA9AAAAAAA0000"
    )
        port map (
      I0 => \r_Bit_Index_reg_n_0_[2]\,
      I1 => r_TX_Done_i_2_n_0,
      I2 => \r_Bit_Index_reg_n_0_[0]\,
      I3 => \r_Bit_Index_reg_n_0_[1]\,
      I4 => \r_Bit_Index[2]_i_2_n_0\,
      I5 => r_SM_Main(1),
      O => \r_Bit_Index[2]_i_1_n_0\
    );
\r_Bit_Index[2]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => r_SM_Main(2),
      I1 => r_SM_Main(0),
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
\r_Clk_Count[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => r_TX_Done_i_2_n_0,
      I1 => r_Clk_Count_reg(0),
      O => \r_Clk_Count[0]_i_1_n_0\
    );
\r_Clk_Count[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"60"
    )
        port map (
      I0 => r_Clk_Count_reg(1),
      I1 => r_Clk_Count_reg(0),
      I2 => r_TX_Done_i_2_n_0,
      O => r_Clk_Count(1)
    );
\r_Clk_Count[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6A00"
    )
        port map (
      I0 => r_Clk_Count_reg(2),
      I1 => r_Clk_Count_reg(1),
      I2 => r_Clk_Count_reg(0),
      I3 => r_TX_Done_i_2_n_0,
      O => r_Clk_Count(2)
    );
\r_Clk_Count[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAA0000"
    )
        port map (
      I0 => r_Clk_Count_reg(3),
      I1 => r_Clk_Count_reg(2),
      I2 => r_Clk_Count_reg(0),
      I3 => r_Clk_Count_reg(1),
      I4 => r_TX_Done_i_2_n_0,
      O => r_Clk_Count(3)
    );
\r_Clk_Count[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAA00000000"
    )
        port map (
      I0 => r_Clk_Count_reg(4),
      I1 => r_Clk_Count_reg(3),
      I2 => r_Clk_Count_reg(1),
      I3 => r_Clk_Count_reg(0),
      I4 => r_Clk_Count_reg(2),
      I5 => r_TX_Done_i_2_n_0,
      O => r_Clk_Count(4)
    );
\r_Clk_Count[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AA6AAAAA00000000"
    )
        port map (
      I0 => r_Clk_Count_reg(5),
      I1 => r_Clk_Count_reg(4),
      I2 => r_Clk_Count_reg(2),
      I3 => \r_Clk_Count[5]_i_2_n_0\,
      I4 => r_Clk_Count_reg(3),
      I5 => r_TX_Done_i_2_n_0,
      O => r_Clk_Count(5)
    );
\r_Clk_Count[5]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => r_Clk_Count_reg(1),
      I1 => r_Clk_Count_reg(0),
      O => \r_Clk_Count[5]_i_2_n_0\
    );
\r_Clk_Count[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"60"
    )
        port map (
      I0 => r_Clk_Count_reg(6),
      I1 => \r_Clk_Count[9]_i_4_n_0\,
      I2 => r_TX_Done_i_2_n_0,
      O => r_Clk_Count(6)
    );
\r_Clk_Count[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6A00"
    )
        port map (
      I0 => r_Clk_Count_reg(7),
      I1 => r_Clk_Count_reg(6),
      I2 => \r_Clk_Count[9]_i_4_n_0\,
      I3 => r_TX_Done_i_2_n_0,
      O => r_Clk_Count(7)
    );
\r_Clk_Count[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAA0000"
    )
        port map (
      I0 => r_Clk_Count_reg(8),
      I1 => r_Clk_Count_reg(7),
      I2 => \r_Clk_Count[9]_i_4_n_0\,
      I3 => r_Clk_Count_reg(6),
      I4 => r_TX_Done_i_2_n_0,
      O => r_Clk_Count(8)
    );
\r_Clk_Count[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => r_SM_Main(1),
      I1 => r_SM_Main(0),
      I2 => r_SM_Main(2),
      O => r_Clk_Count0
    );
\r_Clk_Count[9]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"54"
    )
        port map (
      I0 => r_SM_Main(2),
      I1 => r_SM_Main(1),
      I2 => r_SM_Main(0),
      O => r_Clk_Count_0
    );
\r_Clk_Count[9]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAA00000000"
    )
        port map (
      I0 => r_Clk_Count_reg(9),
      I1 => r_Clk_Count_reg(8),
      I2 => r_Clk_Count_reg(6),
      I3 => \r_Clk_Count[9]_i_4_n_0\,
      I4 => r_Clk_Count_reg(7),
      I5 => r_TX_Done_i_2_n_0,
      O => r_Clk_Count(9)
    );
\r_Clk_Count[9]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => r_Clk_Count_reg(5),
      I1 => r_Clk_Count_reg(3),
      I2 => r_Clk_Count_reg(1),
      I3 => r_Clk_Count_reg(0),
      I4 => r_Clk_Count_reg(2),
      I5 => r_Clk_Count_reg(4),
      O => \r_Clk_Count[9]_i_4_n_0\
    );
\r_Clk_Count_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => r_Clk_Count_0,
      D => \r_Clk_Count[0]_i_1_n_0\,
      Q => r_Clk_Count_reg(0),
      R => r_Clk_Count0
    );
\r_Clk_Count_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => r_Clk_Count_0,
      D => r_Clk_Count(1),
      Q => r_Clk_Count_reg(1),
      R => r_Clk_Count0
    );
\r_Clk_Count_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => r_Clk_Count_0,
      D => r_Clk_Count(2),
      Q => r_Clk_Count_reg(2),
      R => r_Clk_Count0
    );
\r_Clk_Count_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => r_Clk_Count_0,
      D => r_Clk_Count(3),
      Q => r_Clk_Count_reg(3),
      R => r_Clk_Count0
    );
\r_Clk_Count_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => r_Clk_Count_0,
      D => r_Clk_Count(4),
      Q => r_Clk_Count_reg(4),
      R => r_Clk_Count0
    );
\r_Clk_Count_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => r_Clk_Count_0,
      D => r_Clk_Count(5),
      Q => r_Clk_Count_reg(5),
      R => r_Clk_Count0
    );
\r_Clk_Count_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => r_Clk_Count_0,
      D => r_Clk_Count(6),
      Q => r_Clk_Count_reg(6),
      R => r_Clk_Count0
    );
\r_Clk_Count_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => r_Clk_Count_0,
      D => r_Clk_Count(7),
      Q => r_Clk_Count_reg(7),
      R => r_Clk_Count0
    );
\r_Clk_Count_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => r_Clk_Count_0,
      D => r_Clk_Count(8),
      Q => r_Clk_Count_reg(8),
      R => r_Clk_Count0
    );
\r_Clk_Count_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => r_Clk_Count_0,
      D => r_Clk_Count(9),
      Q => r_Clk_Count_reg(9),
      R => r_Clk_Count0
    );
\r_TX_Data[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0010"
    )
        port map (
      I0 => r_SM_Main(0),
      I1 => r_SM_Main(2),
      I2 => i_TX_DV,
      I3 => r_SM_Main(1),
      O => r_TX_Data_1
    );
\r_TX_Data_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => r_TX_Data_1,
      D => i_TX_Byte(0),
      Q => r_TX_Data(0),
      R => '0'
    );
\r_TX_Data_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => r_TX_Data_1,
      D => i_TX_Byte(1),
      Q => r_TX_Data(1),
      R => '0'
    );
\r_TX_Data_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => r_TX_Data_1,
      D => i_TX_Byte(2),
      Q => r_TX_Data(2),
      R => '0'
    );
\r_TX_Data_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => r_TX_Data_1,
      D => i_TX_Byte(3),
      Q => r_TX_Data(3),
      R => '0'
    );
\r_TX_Data_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => r_TX_Data_1,
      D => i_TX_Byte(4),
      Q => r_TX_Data(4),
      R => '0'
    );
\r_TX_Data_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => r_TX_Data_1,
      D => i_TX_Byte(5),
      Q => r_TX_Data(5),
      R => '0'
    );
\r_TX_Data_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => r_TX_Data_1,
      D => i_TX_Byte(6),
      Q => r_TX_Data(6),
      R => '0'
    );
\r_TX_Data_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => r_TX_Data_1,
      D => i_TX_Byte(7),
      Q => r_TX_Data(7),
      R => '0'
    );
r_TX_Done_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFA100A"
    )
        port map (
      I0 => r_SM_Main(2),
      I1 => r_TX_Done_i_2_n_0,
      I2 => r_SM_Main(0),
      I3 => r_SM_Main(1),
      I4 => \^o_tx_done\,
      O => r_TX_Done_i_1_n_0
    );
r_TX_Done_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4555FFFFFFFFFFFF"
    )
        port map (
      I0 => r_Clk_Count_reg(7),
      I1 => r_TX_Done_i_3_n_0,
      I2 => r_Clk_Count_reg(6),
      I3 => r_Clk_Count_reg(5),
      I4 => r_Clk_Count_reg(9),
      I5 => r_Clk_Count_reg(8),
      O => r_TX_Done_i_2_n_0
    );
r_TX_Done_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000007"
    )
        port map (
      I0 => r_Clk_Count_reg(0),
      I1 => r_Clk_Count_reg(1),
      I2 => r_Clk_Count_reg(3),
      I3 => r_Clk_Count_reg(4),
      I4 => r_Clk_Count_reg(2),
      O => r_TX_Done_i_3_n_0
    );
r_TX_Done_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => i_Clk,
      CE => '1',
      D => r_TX_Done_i_1_n_0,
      Q => \^o_tx_done\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity serial_UART_TX_0_0 is
  port (
    i_Clk : in STD_LOGIC;
    i_TX_DV : in STD_LOGIC;
    i_TX_Byte : in STD_LOGIC_VECTOR ( 7 downto 0 );
    o_TX_Active : out STD_LOGIC;
    o_TX_Serial : out STD_LOGIC;
    o_TX_Done : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of serial_UART_TX_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of serial_UART_TX_0_0 : entity is "serial_UART_TX_0_0,UART_TX,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of serial_UART_TX_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of serial_UART_TX_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of serial_UART_TX_0_0 : entity is "UART_TX,Vivado 2020.1";
end serial_UART_TX_0_0;

architecture STRUCTURE of serial_UART_TX_0_0 is
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of i_Clk : signal is "xilinx.com:signal:clock:1.0 i_Clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of i_Clk : signal is "XIL_INTERFACENAME i_Clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN serial_sys_clk, INSERT_VIP 0";
begin
inst: entity work.serial_UART_TX_0_0_UART_TX
     port map (
      i_Clk => i_Clk,
      i_TX_Byte(7 downto 0) => i_TX_Byte(7 downto 0),
      i_TX_DV => i_TX_DV,
      o_TX_Active => o_TX_Active,
      o_TX_Done => o_TX_Done,
      o_TX_Serial => o_TX_Serial
    );
end STRUCTURE;
