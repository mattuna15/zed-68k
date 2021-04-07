-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Tue Apr  6 16:52:10 2021
-- Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim d:/code/zed-68k/zed68k.srcs/sources_1/ip/pll/pll_sim_netlist.vhdl
-- Design      : pll
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35ticsg324-1L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity pll_pll_clk_wiz is
  port (
    clk200 : out STD_LOGIC;
    clk166 : out STD_LOGIC;
    resetn : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of pll_pll_clk_wiz : entity is "pll_clk_wiz";
end pll_pll_clk_wiz;

architecture STRUCTURE of pll_pll_clk_wiz is
  signal clk166_pll : STD_LOGIC;
  signal clk166_pll_en_clk : STD_LOGIC;
  signal clk200_pll : STD_LOGIC;
  signal clk200_pll_en_clk : STD_LOGIC;
  signal clk_in_pll : STD_LOGIC;
  signal clkfbout_buf_pll : STD_LOGIC;
  signal clkfbout_pll : STD_LOGIC;
  signal \^locked\ : STD_LOGIC;
  signal reset_high : STD_LOGIC;
  signal seq_reg1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of seq_reg1 : signal is "true";
  attribute async_reg : string;
  attribute async_reg of seq_reg1 : signal is "true";
  signal seq_reg2 : STD_LOGIC_VECTOR ( 7 downto 0 );
  attribute RTL_KEEP of seq_reg2 : signal is "true";
  attribute async_reg of seq_reg2 : signal is "true";
  signal NLW_plle2_adv_inst_CLKOUT2_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_CLKOUT3_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_CLKOUT4_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_CLKOUT5_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_DRDY_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_DO_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of clkf_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkin1_ibufg : label is "PRIMITIVE";
  attribute CAPACITANCE : string;
  attribute CAPACITANCE of clkin1_ibufg : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE : string;
  attribute IBUF_DELAY_VALUE of clkin1_ibufg : label is "0";
  attribute IFD_DELAY_VALUE : string;
  attribute IFD_DELAY_VALUE of clkin1_ibufg : label is "AUTO";
  attribute BOX_TYPE of clkout1_buf : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of clkout1_buf : label is "BUFGCE";
  attribute XILINX_TRANSFORM_PINMAP : string;
  attribute XILINX_TRANSFORM_PINMAP of clkout1_buf : label is "CE:CE0 I:I0";
  attribute BOX_TYPE of clkout1_buf_en : label is "PRIMITIVE";
  attribute BOX_TYPE of clkout2_buf : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of clkout2_buf : label is "BUFGCE";
  attribute XILINX_TRANSFORM_PINMAP of clkout2_buf : label is "CE:CE0 I:I0";
  attribute BOX_TYPE of clkout2_buf_en : label is "PRIMITIVE";
  attribute BOX_TYPE of plle2_adv_inst : label is "PRIMITIVE";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of \seq_reg1_reg[0]\ : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of \seq_reg1_reg[0]\ : label is "yes";
  attribute ASYNC_REG_boolean of \seq_reg1_reg[1]\ : label is std.standard.true;
  attribute KEEP of \seq_reg1_reg[1]\ : label is "yes";
  attribute ASYNC_REG_boolean of \seq_reg1_reg[2]\ : label is std.standard.true;
  attribute KEEP of \seq_reg1_reg[2]\ : label is "yes";
  attribute ASYNC_REG_boolean of \seq_reg1_reg[3]\ : label is std.standard.true;
  attribute KEEP of \seq_reg1_reg[3]\ : label is "yes";
  attribute ASYNC_REG_boolean of \seq_reg1_reg[4]\ : label is std.standard.true;
  attribute KEEP of \seq_reg1_reg[4]\ : label is "yes";
  attribute ASYNC_REG_boolean of \seq_reg1_reg[5]\ : label is std.standard.true;
  attribute KEEP of \seq_reg1_reg[5]\ : label is "yes";
  attribute ASYNC_REG_boolean of \seq_reg1_reg[6]\ : label is std.standard.true;
  attribute KEEP of \seq_reg1_reg[6]\ : label is "yes";
  attribute ASYNC_REG_boolean of \seq_reg1_reg[7]\ : label is std.standard.true;
  attribute KEEP of \seq_reg1_reg[7]\ : label is "yes";
  attribute ASYNC_REG_boolean of \seq_reg2_reg[0]\ : label is std.standard.true;
  attribute KEEP of \seq_reg2_reg[0]\ : label is "yes";
  attribute ASYNC_REG_boolean of \seq_reg2_reg[1]\ : label is std.standard.true;
  attribute KEEP of \seq_reg2_reg[1]\ : label is "yes";
  attribute ASYNC_REG_boolean of \seq_reg2_reg[2]\ : label is std.standard.true;
  attribute KEEP of \seq_reg2_reg[2]\ : label is "yes";
  attribute ASYNC_REG_boolean of \seq_reg2_reg[3]\ : label is std.standard.true;
  attribute KEEP of \seq_reg2_reg[3]\ : label is "yes";
  attribute ASYNC_REG_boolean of \seq_reg2_reg[4]\ : label is std.standard.true;
  attribute KEEP of \seq_reg2_reg[4]\ : label is "yes";
  attribute ASYNC_REG_boolean of \seq_reg2_reg[5]\ : label is std.standard.true;
  attribute KEEP of \seq_reg2_reg[5]\ : label is "yes";
  attribute ASYNC_REG_boolean of \seq_reg2_reg[6]\ : label is std.standard.true;
  attribute KEEP of \seq_reg2_reg[6]\ : label is "yes";
  attribute ASYNC_REG_boolean of \seq_reg2_reg[7]\ : label is std.standard.true;
  attribute KEEP of \seq_reg2_reg[7]\ : label is "yes";
begin
  locked <= \^locked\;
clkf_buf: unisim.vcomponents.BUFG
     port map (
      I => clkfbout_pll,
      O => clkfbout_buf_pll
    );
clkin1_ibufg: unisim.vcomponents.IBUF
    generic map(
      IOSTANDARD => "DEFAULT"
    )
        port map (
      I => clk_in,
      O => clk_in_pll
    );
clkout1_buf: unisim.vcomponents.BUFGCTRL
    generic map(
      INIT_OUT => 0,
      PRESELECT_I0 => true,
      PRESELECT_I1 => false,
      SIM_DEVICE => "7SERIES"
    )
        port map (
      CE0 => seq_reg1(7),
      CE1 => '0',
      I0 => clk200_pll,
      I1 => '1',
      IGNORE0 => '0',
      IGNORE1 => '1',
      O => clk200,
      S0 => '1',
      S1 => '0'
    );
clkout1_buf_en: unisim.vcomponents.BUFH
     port map (
      I => clk200_pll,
      O => clk200_pll_en_clk
    );
clkout2_buf: unisim.vcomponents.BUFGCTRL
    generic map(
      INIT_OUT => 0,
      PRESELECT_I0 => true,
      PRESELECT_I1 => false,
      SIM_DEVICE => "7SERIES"
    )
        port map (
      CE0 => seq_reg2(7),
      CE1 => '0',
      I0 => clk166_pll,
      I1 => '1',
      IGNORE0 => '0',
      IGNORE1 => '1',
      O => clk166,
      S0 => '1',
      S1 => '0'
    );
clkout2_buf_en: unisim.vcomponents.BUFH
     port map (
      I => clk166_pll,
      O => clk166_pll_en_clk
    );
plle2_adv_inst: unisim.vcomponents.PLLE2_ADV
    generic map(
      BANDWIDTH => "OPTIMIZED",
      CLKFBOUT_MULT => 10,
      CLKFBOUT_PHASE => 0.000000,
      CLKIN1_PERIOD => 10.000000,
      CLKIN2_PERIOD => 0.000000,
      CLKOUT0_DIVIDE => 5,
      CLKOUT0_DUTY_CYCLE => 0.500000,
      CLKOUT0_PHASE => 0.000000,
      CLKOUT1_DIVIDE => 6,
      CLKOUT1_DUTY_CYCLE => 0.500000,
      CLKOUT1_PHASE => 0.000000,
      CLKOUT2_DIVIDE => 1,
      CLKOUT2_DUTY_CYCLE => 0.500000,
      CLKOUT2_PHASE => 0.000000,
      CLKOUT3_DIVIDE => 1,
      CLKOUT3_DUTY_CYCLE => 0.500000,
      CLKOUT3_PHASE => 0.000000,
      CLKOUT4_DIVIDE => 1,
      CLKOUT4_DUTY_CYCLE => 0.500000,
      CLKOUT4_PHASE => 0.000000,
      CLKOUT5_DIVIDE => 1,
      CLKOUT5_DUTY_CYCLE => 0.500000,
      CLKOUT5_PHASE => 0.000000,
      COMPENSATION => "ZHOLD",
      DIVCLK_DIVIDE => 1,
      IS_CLKINSEL_INVERTED => '0',
      IS_PWRDWN_INVERTED => '0',
      IS_RST_INVERTED => '0',
      REF_JITTER1 => 0.010000,
      REF_JITTER2 => 0.010000,
      STARTUP_WAIT => "FALSE"
    )
        port map (
      CLKFBIN => clkfbout_buf_pll,
      CLKFBOUT => clkfbout_pll,
      CLKIN1 => clk_in_pll,
      CLKIN2 => '0',
      CLKINSEL => '1',
      CLKOUT0 => clk200_pll,
      CLKOUT1 => clk166_pll,
      CLKOUT2 => NLW_plle2_adv_inst_CLKOUT2_UNCONNECTED,
      CLKOUT3 => NLW_plle2_adv_inst_CLKOUT3_UNCONNECTED,
      CLKOUT4 => NLW_plle2_adv_inst_CLKOUT4_UNCONNECTED,
      CLKOUT5 => NLW_plle2_adv_inst_CLKOUT5_UNCONNECTED,
      DADDR(6 downto 0) => B"0000000",
      DCLK => '0',
      DEN => '0',
      DI(15 downto 0) => B"0000000000000000",
      DO(15 downto 0) => NLW_plle2_adv_inst_DO_UNCONNECTED(15 downto 0),
      DRDY => NLW_plle2_adv_inst_DRDY_UNCONNECTED,
      DWE => '0',
      LOCKED => \^locked\,
      PWRDWN => '0',
      RST => reset_high
    );
plle2_adv_inst_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => resetn,
      O => reset_high
    );
\seq_reg1_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk200_pll_en_clk,
      CE => '1',
      CLR => reset_high,
      D => \^locked\,
      Q => seq_reg1(0)
    );
\seq_reg1_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk200_pll_en_clk,
      CE => '1',
      CLR => reset_high,
      D => seq_reg1(0),
      Q => seq_reg1(1)
    );
\seq_reg1_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk200_pll_en_clk,
      CE => '1',
      CLR => reset_high,
      D => seq_reg1(1),
      Q => seq_reg1(2)
    );
\seq_reg1_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk200_pll_en_clk,
      CE => '1',
      CLR => reset_high,
      D => seq_reg1(2),
      Q => seq_reg1(3)
    );
\seq_reg1_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk200_pll_en_clk,
      CE => '1',
      CLR => reset_high,
      D => seq_reg1(3),
      Q => seq_reg1(4)
    );
\seq_reg1_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk200_pll_en_clk,
      CE => '1',
      CLR => reset_high,
      D => seq_reg1(4),
      Q => seq_reg1(5)
    );
\seq_reg1_reg[6]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk200_pll_en_clk,
      CE => '1',
      CLR => reset_high,
      D => seq_reg1(5),
      Q => seq_reg1(6)
    );
\seq_reg1_reg[7]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk200_pll_en_clk,
      CE => '1',
      CLR => reset_high,
      D => seq_reg1(6),
      Q => seq_reg1(7)
    );
\seq_reg2_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk166_pll_en_clk,
      CE => '1',
      CLR => reset_high,
      D => \^locked\,
      Q => seq_reg2(0)
    );
\seq_reg2_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk166_pll_en_clk,
      CE => '1',
      CLR => reset_high,
      D => seq_reg2(0),
      Q => seq_reg2(1)
    );
\seq_reg2_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk166_pll_en_clk,
      CE => '1',
      CLR => reset_high,
      D => seq_reg2(1),
      Q => seq_reg2(2)
    );
\seq_reg2_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk166_pll_en_clk,
      CE => '1',
      CLR => reset_high,
      D => seq_reg2(2),
      Q => seq_reg2(3)
    );
\seq_reg2_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk166_pll_en_clk,
      CE => '1',
      CLR => reset_high,
      D => seq_reg2(3),
      Q => seq_reg2(4)
    );
\seq_reg2_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk166_pll_en_clk,
      CE => '1',
      CLR => reset_high,
      D => seq_reg2(4),
      Q => seq_reg2(5)
    );
\seq_reg2_reg[6]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk166_pll_en_clk,
      CE => '1',
      CLR => reset_high,
      D => seq_reg2(5),
      Q => seq_reg2(6)
    );
\seq_reg2_reg[7]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk166_pll_en_clk,
      CE => '1',
      CLR => reset_high,
      D => seq_reg2(6),
      Q => seq_reg2(7)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity pll is
  port (
    clk200 : out STD_LOGIC;
    clk166 : out STD_LOGIC;
    resetn : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of pll : entity is true;
end pll;

architecture STRUCTURE of pll is
begin
inst: entity work.pll_pll_clk_wiz
     port map (
      clk166 => clk166,
      clk200 => clk200,
      clk_in => clk_in,
      locked => locked,
      resetn => resetn
    );
end STRUCTURE;
