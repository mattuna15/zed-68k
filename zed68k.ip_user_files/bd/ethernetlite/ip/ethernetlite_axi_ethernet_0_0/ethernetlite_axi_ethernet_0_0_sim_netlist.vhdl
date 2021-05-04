-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Mon May  3 17:00:32 2021
-- Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               d:/code/zed-68k/zed68k.srcs/sources_1/bd/ethernetlite/ip/ethernetlite_axi_ethernet_0_0/ethernetlite_axi_ethernet_0_0_sim_netlist.vhdl
-- Design      : ethernetlite_axi_ethernet_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35ticsg324-1L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ethernetlite_axi_ethernet_0_0_Signal_CrossDomain is
  port (
    o_ready_p : out STD_LOGIC;
    o_ready : in STD_LOGIC;
    sys_clock : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ethernetlite_axi_ethernet_0_0_Signal_CrossDomain : entity is "Signal_CrossDomain";
end ethernetlite_axi_ethernet_0_0_Signal_CrossDomain;

architecture STRUCTURE of ethernetlite_axi_ethernet_0_0_Signal_CrossDomain is
  signal \SyncA_clkB_reg_n_0_[0]\ : STD_LOGIC;
begin
\SyncA_clkB_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => o_ready,
      Q => \SyncA_clkB_reg_n_0_[0]\,
      R => '0'
    );
\SyncA_clkB_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \SyncA_clkB_reg_n_0_[0]\,
      Q => o_ready_p,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ethernetlite_axi_ethernet_0_0_Signal_CrossDomain_0 is
  port (
    o_valid_p : out STD_LOGIC;
    o_valid : in STD_LOGIC;
    sys_clock : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ethernetlite_axi_ethernet_0_0_Signal_CrossDomain_0 : entity is "Signal_CrossDomain";
end ethernetlite_axi_ethernet_0_0_Signal_CrossDomain_0;

architecture STRUCTURE of ethernetlite_axi_ethernet_0_0_Signal_CrossDomain_0 is
  signal \SyncA_clkB_reg_n_0_[0]\ : STD_LOGIC;
begin
\SyncA_clkB_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => o_valid,
      Q => \SyncA_clkB_reg_n_0_[0]\,
      R => '0'
    );
\SyncA_clkB_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \SyncA_clkB_reg_n_0_[0]\,
      Q => o_valid_p,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ethernetlite_axi_ethernet_0_0_Signal_CrossDomain_1 is
  port (
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    i_cen_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    D : out STD_LOGIC_VECTOR ( 7 downto 0 );
    \state_reg[6]\ : out STD_LOGIC;
    i_valid_p : in STD_LOGIC;
    ui_clk : in STD_LOGIC;
    i_cen : in STD_LOGIC;
    i_wren : in STD_LOGIC;
    \s_axi_araddr_reg[0]\ : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_rvalid : in STD_LOGIC;
    \state_reg[1]\ : in STD_LOGIC;
    \state_reg[1]_0\ : in STD_LOGIC;
    \state_reg[1]_1\ : in STD_LOGIC;
    s_axi_awready : in STD_LOGIC;
    \state_reg[5]\ : in STD_LOGIC;
    \state_reg[1]_2\ : in STD_LOGIC;
    \state_reg[1]_3\ : in STD_LOGIC;
    \state_reg[2]\ : in STD_LOGIC;
    \state_reg[0]\ : in STD_LOGIC;
    \state_reg[0]_0\ : in STD_LOGIC;
    \state_reg[0]_1\ : in STD_LOGIC;
    s_axi_wready : in STD_LOGIC;
    \state_reg[0]_2\ : in STD_LOGIC;
    s_axi_bvalid : in STD_LOGIC;
    \state_reg[3]\ : in STD_LOGIC;
    \state_reg[4]\ : in STD_LOGIC;
    \state_reg[7]\ : in STD_LOGIC;
    \state_reg[5]_0\ : in STD_LOGIC;
    \state_reg[5]_1\ : in STD_LOGIC;
    \state_reg[5]_2\ : in STD_LOGIC;
    \state_reg[5]_3\ : in STD_LOGIC;
    \state_reg[5]_4\ : in STD_LOGIC;
    \state_reg[6]_0\ : in STD_LOGIC;
    \state_reg[6]_1\ : in STD_LOGIC;
    \out\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    o_ready_reg : in STD_LOGIC;
    o_ready : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ethernetlite_axi_ethernet_0_0_Signal_CrossDomain_1 : entity is "Signal_CrossDomain";
end ethernetlite_axi_ethernet_0_0_Signal_CrossDomain_1;

architecture STRUCTURE of ethernetlite_axi_ethernet_0_0_Signal_CrossDomain_1 is
  signal SyncA_clkB : STD_LOGIC;
  signal i_valid : STD_LOGIC;
  signal \state[0]_i_4_n_0\ : STD_LOGIC;
  signal \state[1]_i_2_n_0\ : STD_LOGIC;
  signal \state[1]_i_5_n_0\ : STD_LOGIC;
  signal \state[2]_i_2_n_0\ : STD_LOGIC;
  signal \state[5]_i_4_n_0\ : STD_LOGIC;
  signal \state[5]_i_5_n_0\ : STD_LOGIC;
  signal \state[6]_i_10_n_0\ : STD_LOGIC;
  signal \state[6]_i_5_n_0\ : STD_LOGIC;
  signal \state[7]_i_4_n_0\ : STD_LOGIC;
  signal \state[7]_i_9_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of o_ready_i_1 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \s_axi_araddr[31]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \s_axi_awaddr[31]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \state[1]_i_5\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \state[5]_i_5\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \state[7]_i_9\ : label is "soft_lutpair0";
begin
\SyncA_clkB_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => '1',
      D => i_valid_p,
      Q => SyncA_clkB,
      R => '0'
    );
\SyncA_clkB_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => '1',
      D => SyncA_clkB,
      Q => i_valid,
      R => '0'
    );
o_ready_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FBFFFB00"
    )
        port map (
      I0 => \out\(0),
      I1 => i_valid,
      I2 => i_cen,
      I3 => o_ready_reg,
      I4 => o_ready,
      O => \state_reg[6]\
    );
\s_axi_araddr[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0040"
    )
        port map (
      I0 => i_cen,
      I1 => i_valid,
      I2 => i_wren,
      I3 => \s_axi_araddr_reg[0]\,
      O => E(0)
    );
\s_axi_awaddr[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
        port map (
      I0 => i_cen,
      I1 => i_valid,
      I2 => i_wren,
      I3 => \s_axi_araddr_reg[0]\,
      O => i_cen_0(0)
    );
\state[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF00F8F8"
    )
        port map (
      I0 => \state_reg[0]\,
      I1 => \state_reg[0]_0\,
      I2 => \state[0]_i_4_n_0\,
      I3 => \state_reg[0]_1\,
      I4 => \state_reg[1]\,
      O => D(0)
    );
\state[0]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CC11CC11003000FC"
    )
        port map (
      I0 => \state[7]_i_9_n_0\,
      I1 => Q(0),
      I2 => s_axi_wready,
      I3 => \state_reg[0]_2\,
      I4 => s_axi_bvalid,
      I5 => \state_reg[0]_0\,
      O => \state[0]_i_4_n_0\
    );
\state[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FCAA00AA0CAA00AA"
    )
        port map (
      I0 => \state[1]_i_2_n_0\,
      I1 => Q(1),
      I2 => s_axi_rvalid,
      I3 => \state_reg[1]\,
      I4 => \state_reg[1]_0\,
      I5 => \state_reg[1]_1\,
      O => D(1)
    );
\state[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE0FFFFEFE0F0F0"
    )
        port map (
      I0 => s_axi_awready,
      I1 => Q(1),
      I2 => \state_reg[5]\,
      I3 => \state_reg[1]_2\,
      I4 => \state_reg[1]_3\,
      I5 => \state[1]_i_5_n_0\,
      O => \state[1]_i_2_n_0\
    );
\state[1]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => Q(1),
      I1 => i_cen,
      I2 => i_valid,
      I3 => i_wren,
      O => \state[1]_i_5_n_0\
    );
\state[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000F000FEF4FEF4"
    )
        port map (
      I0 => \state[7]_i_9_n_0\,
      I1 => i_wren,
      I2 => \state_reg[1]_3\,
      I3 => Q(2),
      I4 => s_axi_awready,
      I5 => \state_reg[5]\,
      O => \state[2]_i_2_n_0\
    );
\state[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2000FFFF20002000"
    )
        port map (
      I0 => Q(1),
      I1 => Q(0),
      I2 => Q(3),
      I3 => \state[7]_i_4_n_0\,
      I4 => \state_reg[3]\,
      I5 => \state_reg[1]\,
      O => D(3)
    );
\state[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"08C80808C8C8C8C8"
    )
        port map (
      I0 => \state[7]_i_4_n_0\,
      I1 => Q(4),
      I2 => \state_reg[1]\,
      I3 => s_axi_rvalid,
      I4 => \state_reg[1]_0\,
      I5 => \state_reg[4]\,
      O => D(4)
    );
\state[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => \state_reg[5]_0\,
      I1 => \state_reg[1]\,
      I2 => \state_reg[5]_1\,
      I3 => \state_reg[5]\,
      I4 => \state[5]_i_4_n_0\,
      O => D(5)
    );
\state[5]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B888FFFFB8880000"
    )
        port map (
      I0 => \state_reg[5]_2\,
      I1 => \state_reg[5]_3\,
      I2 => \state_reg[5]_4\,
      I3 => Q(5),
      I4 => \state_reg[1]_3\,
      I5 => \state[5]_i_5_n_0\,
      O => \state[5]_i_4_n_0\
    );
\state[5]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A2"
    )
        port map (
      I0 => Q(5),
      I1 => i_valid,
      I2 => i_cen,
      O => \state[5]_i_5_n_0\
    );
\state[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => \state_reg[6]_0\,
      I1 => \state_reg[1]\,
      I2 => \state_reg[6]_1\,
      I3 => \state_reg[5]\,
      I4 => \state[6]_i_5_n_0\,
      O => D(6)
    );
\state[6]_i_10\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A2"
    )
        port map (
      I0 => Q(6),
      I1 => i_valid,
      I2 => i_cen,
      O => \state[6]_i_10_n_0\
    );
\state[6]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B888FFFFB8880000"
    )
        port map (
      I0 => \state_reg[5]_2\,
      I1 => \state_reg[5]_3\,
      I2 => \state_reg[5]_4\,
      I3 => Q(5),
      I4 => \state_reg[1]_3\,
      I5 => \state[6]_i_10_n_0\,
      O => \state[6]_i_5_n_0\
    );
\state[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"08C80808C8C8C8C8"
    )
        port map (
      I0 => \state[7]_i_4_n_0\,
      I1 => Q(7),
      I2 => \state_reg[1]\,
      I3 => s_axi_rvalid,
      I4 => \state_reg[1]_0\,
      I5 => \state_reg[4]\,
      O => D(7)
    );
\state[7]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C00CCF0CAAAAAAAA"
    )
        port map (
      I0 => \state_reg[7]\,
      I1 => \state[7]_i_9_n_0\,
      I2 => Q(0),
      I3 => \state_reg[0]_2\,
      I4 => s_axi_awready,
      I5 => \state_reg[0]_0\,
      O => \state[7]_i_4_n_0\
    );
\state[7]_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => i_cen,
      I1 => i_valid,
      O => \state[7]_i_9_n_0\
    );
\state_reg[2]_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \state[2]_i_2_n_0\,
      I1 => \state_reg[2]\,
      O => D(2),
      S => \state_reg[1]\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ethernetlite_axi_ethernet_0_0_Signal_CrossDomain_2 is
  port (
    wr_ack_p : out STD_LOGIC;
    wr_ack : in STD_LOGIC;
    sys_clock : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ethernetlite_axi_ethernet_0_0_Signal_CrossDomain_2 : entity is "Signal_CrossDomain";
end ethernetlite_axi_ethernet_0_0_Signal_CrossDomain_2;

architecture STRUCTURE of ethernetlite_axi_ethernet_0_0_Signal_CrossDomain_2 is
  signal \SyncA_clkB_reg_n_0_[0]\ : STD_LOGIC;
begin
\SyncA_clkB_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => wr_ack,
      Q => \SyncA_clkB_reg_n_0_[0]\,
      R => '0'
    );
\SyncA_clkB_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => sys_clock,
      CE => '1',
      D => \SyncA_clkB_reg_n_0_[0]\,
      Q => wr_ack_p,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ethernetlite_axi_ethernet_0_0_axi_ethernet is
  port (
    rd_data : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    wr_ack_p : out STD_LOGIC;
    o_ready_p : out STD_LOGIC;
    o_valid_p : out STD_LOGIC;
    s_axi_awvalid : out STD_LOGIC;
    s_axi_wvalid : out STD_LOGIC;
    s_axi_bready : out STD_LOGIC;
    s_axi_arvalid : out STD_LOGIC;
    s_axi_rready : out STD_LOGIC;
    s_axi_wlast : out STD_LOGIC;
    s_axi_rvalid : in STD_LOGIC;
    s_axi_arready : in STD_LOGIC;
    ui_clk : in STD_LOGIC;
    s_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    address : in STD_LOGIC_VECTOR ( 31 downto 0 );
    wr_data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    wr_byte_mask : in STD_LOGIC_VECTOR ( 3 downto 0 );
    i_valid_p : in STD_LOGIC;
    sys_clock : in STD_LOGIC;
    i_cen : in STD_LOGIC;
    i_wren : in STD_LOGIC;
    ui_clk_sync_rst : in STD_LOGIC;
    init_calib_complete : in STD_LOGIC;
    s_axi_awready : in STD_LOGIC;
    s_axi_wready : in STD_LOGIC;
    s_axi_bvalid : in STD_LOGIC;
    s_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ethernetlite_axi_ethernet_0_0_axi_ethernet : entity is "axi_ethernet";
end ethernetlite_axi_ethernet_0_0_axi_ethernet;

architecture STRUCTURE of ethernetlite_axi_ethernet_0_0_axi_ethernet is
  signal o_ready : STD_LOGIC;
  signal o_ready_i_2_n_0 : STD_LOGIC;
  signal o_valid : STD_LOGIC;
  signal o_valid_i_1_n_0 : STD_LOGIC;
  signal o_valid_i_2_n_0 : STD_LOGIC;
  signal \p_0_in__0\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \rd_data[31]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data[31]_i_3_n_0\ : STD_LOGIC;
  signal \^s_axi_arvalid\ : STD_LOGIC;
  signal s_axi_arvalid_i_1_n_0 : STD_LOGIC;
  signal s_axi_arvalid_i_2_n_0 : STD_LOGIC;
  signal \s_axi_awaddr[31]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_awaddr[31]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_awaddr[31]_i_4_n_0\ : STD_LOGIC;
  signal \^s_axi_awvalid\ : STD_LOGIC;
  signal s_axi_awvalid0 : STD_LOGIC;
  signal s_axi_awvalid_i_1_n_0 : STD_LOGIC;
  signal s_axi_awvalid_i_2_n_0 : STD_LOGIC;
  signal \^s_axi_bready\ : STD_LOGIC;
  signal s_axi_bready_i_1_n_0 : STD_LOGIC;
  signal s_axi_bready_i_2_n_0 : STD_LOGIC;
  signal \^s_axi_rready\ : STD_LOGIC;
  signal s_axi_rready_i_1_n_0 : STD_LOGIC;
  signal s_axi_rready_i_2_n_0 : STD_LOGIC;
  signal s_axi_rready_i_3_n_0 : STD_LOGIC;
  signal \^s_axi_wlast\ : STD_LOGIC;
  signal s_axi_wlast_i_1_n_0 : STD_LOGIC;
  signal \^s_axi_wvalid\ : STD_LOGIC;
  signal s_axi_wvalid_i_1_n_0 : STD_LOGIC;
  signal state : STD_LOGIC_VECTOR ( 7 downto 0 );
  attribute DONT_TOUCH : boolean;
  attribute DONT_TOUCH of state : signal is std.standard.true;
  signal \state[0]_i_2_n_0\ : STD_LOGIC;
  signal \state[0]_i_3_n_0\ : STD_LOGIC;
  signal \state[0]_i_5_n_0\ : STD_LOGIC;
  signal \state[1]_i_3_n_0\ : STD_LOGIC;
  signal \state[1]_i_4_n_0\ : STD_LOGIC;
  signal \state[2]_i_3_n_0\ : STD_LOGIC;
  signal \state[3]_i_2_n_0\ : STD_LOGIC;
  signal \state[5]_i_2_n_0\ : STD_LOGIC;
  signal \state[5]_i_3_n_0\ : STD_LOGIC;
  signal \state[6]_i_2_n_0\ : STD_LOGIC;
  signal \state[6]_i_3_n_0\ : STD_LOGIC;
  signal \state[6]_i_4_n_0\ : STD_LOGIC;
  signal \state[6]_i_6_n_0\ : STD_LOGIC;
  signal \state[6]_i_7_n_0\ : STD_LOGIC;
  signal \state[6]_i_8_n_0\ : STD_LOGIC;
  signal \state[6]_i_9_n_0\ : STD_LOGIC;
  signal \state[7]_i_10_n_0\ : STD_LOGIC;
  signal \state[7]_i_1_n_0\ : STD_LOGIC;
  signal \state[7]_i_3_n_0\ : STD_LOGIC;
  signal \state[7]_i_5_n_0\ : STD_LOGIC;
  signal \state[7]_i_6_n_0\ : STD_LOGIC;
  signal \state[7]_i_7_n_0\ : STD_LOGIC;
  signal \state[7]_i_8_n_0\ : STD_LOGIC;
  signal valid_inp_n_0 : STD_LOGIC;
  signal valid_inp_n_1 : STD_LOGIC;
  signal valid_inp_n_10 : STD_LOGIC;
  signal wr_ack : STD_LOGIC;
  signal wr_ack_i_1_n_0 : STD_LOGIC;
  signal wr_ack_i_2_n_0 : STD_LOGIC;
  signal wr_ack_i_3_n_0 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \state[0]_i_2\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \state[0]_i_5\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \state[6]_i_3\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \state[6]_i_6\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \state[6]_i_8\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \state[7]_i_6\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \state[7]_i_7\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \state[7]_i_8\ : label is "soft_lutpair4";
  attribute DONT_TOUCH of \state_reg[0]\ : label is std.standard.true;
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \state_reg[0]\ : label is "iSTATE:00000000,iSTATE0:00000001,iSTATE1:00000010,iSTATE2:00000011,iSTATE3:00000100,iSTATE4:00000101,iSTATE5:00000110,iSTATE6:00000111,iSTATE7:00001000,iSTATE8:00001001,iSTATE9:00001010,iSTATE10:01100100";
  attribute KEEP : string;
  attribute KEEP of \state_reg[0]\ : label is "yes";
  attribute DONT_TOUCH of \state_reg[1]\ : label is std.standard.true;
  attribute FSM_ENCODED_STATES of \state_reg[1]\ : label is "iSTATE:00000000,iSTATE0:00000001,iSTATE1:00000010,iSTATE2:00000011,iSTATE3:00000100,iSTATE4:00000101,iSTATE5:00000110,iSTATE6:00000111,iSTATE7:00001000,iSTATE8:00001001,iSTATE9:00001010,iSTATE10:01100100";
  attribute KEEP of \state_reg[1]\ : label is "yes";
  attribute DONT_TOUCH of \state_reg[2]\ : label is std.standard.true;
  attribute FSM_ENCODED_STATES of \state_reg[2]\ : label is "iSTATE:00000000,iSTATE0:00000001,iSTATE1:00000010,iSTATE2:00000011,iSTATE3:00000100,iSTATE4:00000101,iSTATE5:00000110,iSTATE6:00000111,iSTATE7:00001000,iSTATE8:00001001,iSTATE9:00001010,iSTATE10:01100100";
  attribute KEEP of \state_reg[2]\ : label is "yes";
  attribute DONT_TOUCH of \state_reg[3]\ : label is std.standard.true;
  attribute FSM_ENCODED_STATES of \state_reg[3]\ : label is "iSTATE:00000000,iSTATE0:00000001,iSTATE1:00000010,iSTATE2:00000011,iSTATE3:00000100,iSTATE4:00000101,iSTATE5:00000110,iSTATE6:00000111,iSTATE7:00001000,iSTATE8:00001001,iSTATE9:00001010,iSTATE10:01100100";
  attribute KEEP of \state_reg[3]\ : label is "yes";
  attribute DONT_TOUCH of \state_reg[4]\ : label is std.standard.true;
  attribute FSM_ENCODED_STATES of \state_reg[4]\ : label is "iSTATE:00000000,iSTATE0:00000001,iSTATE1:00000010,iSTATE2:00000011,iSTATE3:00000100,iSTATE4:00000101,iSTATE5:00000110,iSTATE6:00000111,iSTATE7:00001000,iSTATE8:00001001,iSTATE9:00001010,iSTATE10:01100100";
  attribute KEEP of \state_reg[4]\ : label is "yes";
  attribute DONT_TOUCH of \state_reg[5]\ : label is std.standard.true;
  attribute FSM_ENCODED_STATES of \state_reg[5]\ : label is "iSTATE:00000000,iSTATE0:00000001,iSTATE1:00000010,iSTATE2:00000011,iSTATE3:00000100,iSTATE4:00000101,iSTATE5:00000110,iSTATE6:00000111,iSTATE7:00001000,iSTATE8:00001001,iSTATE9:00001010,iSTATE10:01100100";
  attribute KEEP of \state_reg[5]\ : label is "yes";
  attribute DONT_TOUCH of \state_reg[6]\ : label is std.standard.true;
  attribute FSM_ENCODED_STATES of \state_reg[6]\ : label is "iSTATE:00000000,iSTATE0:00000001,iSTATE1:00000010,iSTATE2:00000011,iSTATE3:00000100,iSTATE4:00000101,iSTATE5:00000110,iSTATE6:00000111,iSTATE7:00001000,iSTATE8:00001001,iSTATE9:00001010,iSTATE10:01100100";
  attribute KEEP of \state_reg[6]\ : label is "yes";
  attribute DONT_TOUCH of \state_reg[7]\ : label is std.standard.true;
  attribute FSM_ENCODED_STATES of \state_reg[7]\ : label is "iSTATE:00000000,iSTATE0:00000001,iSTATE1:00000010,iSTATE2:00000011,iSTATE3:00000100,iSTATE4:00000101,iSTATE5:00000110,iSTATE6:00000111,iSTATE7:00001000,iSTATE8:00001001,iSTATE9:00001010,iSTATE10:01100100";
  attribute KEEP of \state_reg[7]\ : label is "yes";
begin
  s_axi_arvalid <= \^s_axi_arvalid\;
  s_axi_awvalid <= \^s_axi_awvalid\;
  s_axi_bready <= \^s_axi_bready\;
  s_axi_rready <= \^s_axi_rready\;
  s_axi_wlast <= \^s_axi_wlast\;
  s_axi_wvalid <= \^s_axi_wvalid\;
o_ready_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000010000001"
    )
        port map (
      I0 => state(1),
      I1 => state(3),
      I2 => state(2),
      I3 => state(5),
      I4 => state(6),
      I5 => wr_ack_i_3_n_0,
      O => o_ready_i_2_n_0
    );
o_ready_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => '1',
      D => valid_inp_n_10,
      Q => o_ready,
      R => s_axi_awvalid0
    );
o_valid_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => state(3),
      I1 => state(6),
      I2 => o_valid_i_2_n_0,
      I3 => o_valid,
      O => o_valid_i_1_n_0
    );
o_valid_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000001000081"
    )
        port map (
      I0 => state(6),
      I1 => state(2),
      I2 => state(5),
      I3 => state(1),
      I4 => state(3),
      I5 => wr_ack_i_3_n_0,
      O => o_valid_i_2_n_0
    );
o_valid_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => '1',
      D => o_valid_i_1_n_0,
      Q => o_valid,
      R => s_axi_awvalid0
    );
oready: entity work.ethernetlite_axi_ethernet_0_0_Signal_CrossDomain
     port map (
      o_ready => o_ready,
      o_ready_p => o_ready_p,
      sys_clock => sys_clock
    );
ovalid: entity work.ethernetlite_axi_ethernet_0_0_Signal_CrossDomain_0
     port map (
      o_valid => o_valid,
      o_valid_p => o_valid_p,
      sys_clock => sys_clock
    );
\rd_data[31]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => ui_clk_sync_rst,
      I1 => init_calib_complete,
      O => s_axi_awvalid0
    );
\rd_data[31]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000020"
    )
        port map (
      I0 => state(3),
      I1 => state(2),
      I2 => state(1),
      I3 => state(0),
      I4 => \rd_data[31]_i_3_n_0\,
      O => \rd_data[31]_i_2_n_0\
    );
\rd_data[31]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => state(7),
      I1 => state(6),
      I2 => state(5),
      I3 => state(4),
      O => \rd_data[31]_i_3_n_0\
    );
\rd_data_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(0),
      Q => rd_data(0),
      R => s_axi_awvalid0
    );
\rd_data_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(10),
      Q => rd_data(10),
      R => s_axi_awvalid0
    );
\rd_data_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(11),
      Q => rd_data(11),
      R => s_axi_awvalid0
    );
\rd_data_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(12),
      Q => rd_data(12),
      R => s_axi_awvalid0
    );
\rd_data_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(13),
      Q => rd_data(13),
      R => s_axi_awvalid0
    );
\rd_data_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(14),
      Q => rd_data(14),
      R => s_axi_awvalid0
    );
\rd_data_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(15),
      Q => rd_data(15),
      R => s_axi_awvalid0
    );
\rd_data_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(16),
      Q => rd_data(16),
      R => s_axi_awvalid0
    );
\rd_data_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(17),
      Q => rd_data(17),
      R => s_axi_awvalid0
    );
\rd_data_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(18),
      Q => rd_data(18),
      R => s_axi_awvalid0
    );
\rd_data_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(19),
      Q => rd_data(19),
      R => s_axi_awvalid0
    );
\rd_data_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(1),
      Q => rd_data(1),
      R => s_axi_awvalid0
    );
\rd_data_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(20),
      Q => rd_data(20),
      R => s_axi_awvalid0
    );
\rd_data_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(21),
      Q => rd_data(21),
      R => s_axi_awvalid0
    );
\rd_data_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(22),
      Q => rd_data(22),
      R => s_axi_awvalid0
    );
\rd_data_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(23),
      Q => rd_data(23),
      R => s_axi_awvalid0
    );
\rd_data_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(24),
      Q => rd_data(24),
      R => s_axi_awvalid0
    );
\rd_data_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(25),
      Q => rd_data(25),
      R => s_axi_awvalid0
    );
\rd_data_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(26),
      Q => rd_data(26),
      R => s_axi_awvalid0
    );
\rd_data_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(27),
      Q => rd_data(27),
      R => s_axi_awvalid0
    );
\rd_data_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(28),
      Q => rd_data(28),
      R => s_axi_awvalid0
    );
\rd_data_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(29),
      Q => rd_data(29),
      R => s_axi_awvalid0
    );
\rd_data_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(2),
      Q => rd_data(2),
      R => s_axi_awvalid0
    );
\rd_data_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(30),
      Q => rd_data(30),
      R => s_axi_awvalid0
    );
\rd_data_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(31),
      Q => rd_data(31),
      R => s_axi_awvalid0
    );
\rd_data_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(3),
      Q => rd_data(3),
      R => s_axi_awvalid0
    );
\rd_data_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(4),
      Q => rd_data(4),
      R => s_axi_awvalid0
    );
\rd_data_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(5),
      Q => rd_data(5),
      R => s_axi_awvalid0
    );
\rd_data_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(6),
      Q => rd_data(6),
      R => s_axi_awvalid0
    );
\rd_data_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(7),
      Q => rd_data(7),
      R => s_axi_awvalid0
    );
\rd_data_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(8),
      Q => rd_data(8),
      R => s_axi_awvalid0
    );
\rd_data_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \rd_data[31]_i_2_n_0\,
      D => s_axi_rdata(9),
      Q => rd_data(9),
      R => s_axi_awvalid0
    );
\s_axi_araddr_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(0),
      Q => s_axi_araddr(0),
      R => '0'
    );
\s_axi_araddr_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(10),
      Q => s_axi_araddr(10),
      R => '0'
    );
\s_axi_araddr_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(11),
      Q => s_axi_araddr(11),
      R => '0'
    );
\s_axi_araddr_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(12),
      Q => s_axi_araddr(12),
      R => '0'
    );
\s_axi_araddr_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(13),
      Q => s_axi_araddr(13),
      R => '0'
    );
\s_axi_araddr_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(14),
      Q => s_axi_araddr(14),
      R => '0'
    );
\s_axi_araddr_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(15),
      Q => s_axi_araddr(15),
      R => '0'
    );
\s_axi_araddr_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(16),
      Q => s_axi_araddr(16),
      R => '0'
    );
\s_axi_araddr_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(17),
      Q => s_axi_araddr(17),
      R => '0'
    );
\s_axi_araddr_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(18),
      Q => s_axi_araddr(18),
      R => '0'
    );
\s_axi_araddr_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(19),
      Q => s_axi_araddr(19),
      R => '0'
    );
\s_axi_araddr_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(1),
      Q => s_axi_araddr(1),
      R => '0'
    );
\s_axi_araddr_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(20),
      Q => s_axi_araddr(20),
      R => '0'
    );
\s_axi_araddr_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(21),
      Q => s_axi_araddr(21),
      R => '0'
    );
\s_axi_araddr_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(22),
      Q => s_axi_araddr(22),
      R => '0'
    );
\s_axi_araddr_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(23),
      Q => s_axi_araddr(23),
      R => '0'
    );
\s_axi_araddr_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(24),
      Q => s_axi_araddr(24),
      R => '0'
    );
\s_axi_araddr_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(25),
      Q => s_axi_araddr(25),
      R => '0'
    );
\s_axi_araddr_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(26),
      Q => s_axi_araddr(26),
      R => '0'
    );
\s_axi_araddr_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(27),
      Q => s_axi_araddr(27),
      R => '0'
    );
\s_axi_araddr_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(28),
      Q => s_axi_araddr(28),
      R => '0'
    );
\s_axi_araddr_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(29),
      Q => s_axi_araddr(29),
      R => '0'
    );
\s_axi_araddr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(2),
      Q => s_axi_araddr(2),
      R => '0'
    );
\s_axi_araddr_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(30),
      Q => s_axi_araddr(30),
      R => '0'
    );
\s_axi_araddr_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(31),
      Q => s_axi_araddr(31),
      R => '0'
    );
\s_axi_araddr_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(3),
      Q => s_axi_araddr(3),
      R => '0'
    );
\s_axi_araddr_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(4),
      Q => s_axi_araddr(4),
      R => '0'
    );
\s_axi_araddr_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(5),
      Q => s_axi_araddr(5),
      R => '0'
    );
\s_axi_araddr_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(6),
      Q => s_axi_araddr(6),
      R => '0'
    );
\s_axi_araddr_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(7),
      Q => s_axi_araddr(7),
      R => '0'
    );
\s_axi_araddr_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(8),
      Q => s_axi_araddr(8),
      R => '0'
    );
\s_axi_araddr_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_0,
      D => address(9),
      Q => s_axi_araddr(9),
      R => '0'
    );
s_axi_arvalid_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"74"
    )
        port map (
      I0 => state(3),
      I1 => s_axi_arvalid_i_2_n_0,
      I2 => \^s_axi_arvalid\,
      O => s_axi_arvalid_i_1_n_0
    );
s_axi_arvalid_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000050000008"
    )
        port map (
      I0 => state(3),
      I1 => s_axi_arready,
      I2 => state(2),
      I3 => state(0),
      I4 => state(1),
      I5 => \rd_data[31]_i_3_n_0\,
      O => s_axi_arvalid_i_2_n_0
    );
s_axi_arvalid_reg: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => '1',
      D => s_axi_arvalid_i_1_n_0,
      Q => \^s_axi_arvalid\,
      R => s_axi_awvalid0
    );
\s_axi_awaddr[31]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \s_axi_awaddr[31]_i_3_n_0\,
      I1 => s_axi_awvalid0,
      I2 => \s_axi_awaddr[31]_i_4_n_0\,
      I3 => state(3),
      I4 => state(2),
      I5 => state(7),
      O => \s_axi_awaddr[31]_i_2_n_0\
    );
\s_axi_awaddr[31]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => state(4),
      I1 => state(5),
      I2 => state(6),
      O => \s_axi_awaddr[31]_i_3_n_0\
    );
\s_axi_awaddr[31]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => state(1),
      I1 => state(0),
      O => \s_axi_awaddr[31]_i_4_n_0\
    );
\s_axi_awaddr_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(0),
      Q => s_axi_awaddr(0),
      R => '0'
    );
\s_axi_awaddr_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(10),
      Q => s_axi_awaddr(10),
      R => '0'
    );
\s_axi_awaddr_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(11),
      Q => s_axi_awaddr(11),
      R => '0'
    );
\s_axi_awaddr_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(12),
      Q => s_axi_awaddr(12),
      R => '0'
    );
\s_axi_awaddr_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(13),
      Q => s_axi_awaddr(13),
      R => '0'
    );
\s_axi_awaddr_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(14),
      Q => s_axi_awaddr(14),
      R => '0'
    );
\s_axi_awaddr_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(15),
      Q => s_axi_awaddr(15),
      R => '0'
    );
\s_axi_awaddr_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(16),
      Q => s_axi_awaddr(16),
      R => '0'
    );
\s_axi_awaddr_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(17),
      Q => s_axi_awaddr(17),
      R => '0'
    );
\s_axi_awaddr_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(18),
      Q => s_axi_awaddr(18),
      R => '0'
    );
\s_axi_awaddr_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(19),
      Q => s_axi_awaddr(19),
      R => '0'
    );
\s_axi_awaddr_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(1),
      Q => s_axi_awaddr(1),
      R => '0'
    );
\s_axi_awaddr_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(20),
      Q => s_axi_awaddr(20),
      R => '0'
    );
\s_axi_awaddr_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(21),
      Q => s_axi_awaddr(21),
      R => '0'
    );
\s_axi_awaddr_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(22),
      Q => s_axi_awaddr(22),
      R => '0'
    );
\s_axi_awaddr_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(23),
      Q => s_axi_awaddr(23),
      R => '0'
    );
\s_axi_awaddr_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(24),
      Q => s_axi_awaddr(24),
      R => '0'
    );
\s_axi_awaddr_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(25),
      Q => s_axi_awaddr(25),
      R => '0'
    );
\s_axi_awaddr_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(26),
      Q => s_axi_awaddr(26),
      R => '0'
    );
\s_axi_awaddr_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(27),
      Q => s_axi_awaddr(27),
      R => '0'
    );
\s_axi_awaddr_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(28),
      Q => s_axi_awaddr(28),
      R => '0'
    );
\s_axi_awaddr_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(29),
      Q => s_axi_awaddr(29),
      R => '0'
    );
\s_axi_awaddr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(2),
      Q => s_axi_awaddr(2),
      R => '0'
    );
\s_axi_awaddr_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(30),
      Q => s_axi_awaddr(30),
      R => '0'
    );
\s_axi_awaddr_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(31),
      Q => s_axi_awaddr(31),
      R => '0'
    );
\s_axi_awaddr_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(3),
      Q => s_axi_awaddr(3),
      R => '0'
    );
\s_axi_awaddr_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(4),
      Q => s_axi_awaddr(4),
      R => '0'
    );
\s_axi_awaddr_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(5),
      Q => s_axi_awaddr(5),
      R => '0'
    );
\s_axi_awaddr_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(6),
      Q => s_axi_awaddr(6),
      R => '0'
    );
\s_axi_awaddr_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(7),
      Q => s_axi_awaddr(7),
      R => '0'
    );
\s_axi_awaddr_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(8),
      Q => s_axi_awaddr(8),
      R => '0'
    );
\s_axi_awaddr_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => address(9),
      Q => s_axi_awaddr(9),
      R => '0'
    );
s_axi_awvalid_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFDFFF00000088"
    )
        port map (
      I0 => s_axi_awvalid_i_2_n_0,
      I1 => state(0),
      I2 => s_axi_awready,
      I3 => state(1),
      I4 => state(2),
      I5 => \^s_axi_awvalid\,
      O => s_axi_awvalid_i_1_n_0
    );
s_axi_awvalid_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => state(3),
      I1 => state(4),
      I2 => state(5),
      I3 => state(6),
      I4 => state(7),
      O => s_axi_awvalid_i_2_n_0
    );
s_axi_awvalid_reg: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => '1',
      D => s_axi_awvalid_i_1_n_0,
      Q => \^s_axi_awvalid\,
      R => s_axi_awvalid0
    );
s_axi_bready_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEFEF00000400"
    )
        port map (
      I0 => s_axi_bready_i_2_n_0,
      I1 => state(0),
      I2 => state(1),
      I3 => s_axi_bvalid,
      I4 => \rd_data[31]_i_3_n_0\,
      I5 => \^s_axi_bready\,
      O => s_axi_bready_i_1_n_0
    );
s_axi_bready_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => state(3),
      I1 => state(2),
      O => s_axi_bready_i_2_n_0
    );
s_axi_bready_reg: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => '1',
      D => s_axi_bready_i_1_n_0,
      Q => \^s_axi_bready\,
      R => s_axi_awvalid0
    );
s_axi_rready_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"04FF0400"
    )
        port map (
      I0 => state(6),
      I1 => s_axi_rvalid,
      I2 => state(1),
      I3 => s_axi_rready_i_2_n_0,
      I4 => \^s_axi_rready\,
      O => s_axi_rready_i_1_n_0
    );
s_axi_rready_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000641100"
    )
        port map (
      I0 => state(0),
      I1 => state(1),
      I2 => s_axi_rvalid,
      I3 => state(2),
      I4 => state(3),
      I5 => s_axi_rready_i_3_n_0,
      O => s_axi_rready_i_2_n_0
    );
s_axi_rready_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFBD"
    )
        port map (
      I0 => state(3),
      I1 => state(5),
      I2 => state(6),
      I3 => state(7),
      I4 => state(4),
      O => s_axi_rready_i_3_n_0
    );
s_axi_rready_reg: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => '1',
      D => s_axi_rready_i_1_n_0,
      Q => \^s_axi_rready\,
      R => s_axi_awvalid0
    );
\s_axi_wdata_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(0),
      Q => s_axi_wdata(0),
      R => '0'
    );
\s_axi_wdata_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(10),
      Q => s_axi_wdata(10),
      R => '0'
    );
\s_axi_wdata_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(11),
      Q => s_axi_wdata(11),
      R => '0'
    );
\s_axi_wdata_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(12),
      Q => s_axi_wdata(12),
      R => '0'
    );
\s_axi_wdata_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(13),
      Q => s_axi_wdata(13),
      R => '0'
    );
\s_axi_wdata_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(14),
      Q => s_axi_wdata(14),
      R => '0'
    );
\s_axi_wdata_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(15),
      Q => s_axi_wdata(15),
      R => '0'
    );
\s_axi_wdata_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(16),
      Q => s_axi_wdata(16),
      R => '0'
    );
\s_axi_wdata_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(17),
      Q => s_axi_wdata(17),
      R => '0'
    );
\s_axi_wdata_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(18),
      Q => s_axi_wdata(18),
      R => '0'
    );
\s_axi_wdata_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(19),
      Q => s_axi_wdata(19),
      R => '0'
    );
\s_axi_wdata_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(1),
      Q => s_axi_wdata(1),
      R => '0'
    );
\s_axi_wdata_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(20),
      Q => s_axi_wdata(20),
      R => '0'
    );
\s_axi_wdata_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(21),
      Q => s_axi_wdata(21),
      R => '0'
    );
\s_axi_wdata_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(22),
      Q => s_axi_wdata(22),
      R => '0'
    );
\s_axi_wdata_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(23),
      Q => s_axi_wdata(23),
      R => '0'
    );
\s_axi_wdata_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(24),
      Q => s_axi_wdata(24),
      R => '0'
    );
\s_axi_wdata_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(25),
      Q => s_axi_wdata(25),
      R => '0'
    );
\s_axi_wdata_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(26),
      Q => s_axi_wdata(26),
      R => '0'
    );
\s_axi_wdata_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(27),
      Q => s_axi_wdata(27),
      R => '0'
    );
\s_axi_wdata_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(28),
      Q => s_axi_wdata(28),
      R => '0'
    );
\s_axi_wdata_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(29),
      Q => s_axi_wdata(29),
      R => '0'
    );
\s_axi_wdata_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(2),
      Q => s_axi_wdata(2),
      R => '0'
    );
\s_axi_wdata_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(30),
      Q => s_axi_wdata(30),
      R => '0'
    );
\s_axi_wdata_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(31),
      Q => s_axi_wdata(31),
      R => '0'
    );
\s_axi_wdata_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(3),
      Q => s_axi_wdata(3),
      R => '0'
    );
\s_axi_wdata_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(4),
      Q => s_axi_wdata(4),
      R => '0'
    );
\s_axi_wdata_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(5),
      Q => s_axi_wdata(5),
      R => '0'
    );
\s_axi_wdata_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(6),
      Q => s_axi_wdata(6),
      R => '0'
    );
\s_axi_wdata_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(7),
      Q => s_axi_wdata(7),
      R => '0'
    );
\s_axi_wdata_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(8),
      Q => s_axi_wdata(8),
      R => '0'
    );
\s_axi_wdata_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_data(9),
      Q => s_axi_wdata(9),
      R => '0'
    );
s_axi_wlast_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00000040"
    )
        port map (
      I0 => state(2),
      I1 => state(0),
      I2 => state(1),
      I3 => state(3),
      I4 => \rd_data[31]_i_3_n_0\,
      I5 => \^s_axi_wlast\,
      O => s_axi_wlast_i_1_n_0
    );
s_axi_wlast_reg: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => '1',
      D => s_axi_wlast_i_1_n_0,
      Q => \^s_axi_wlast\,
      R => s_axi_awvalid0
    );
\s_axi_wstrb_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_byte_mask(0),
      Q => s_axi_wstrb(0),
      R => '0'
    );
\s_axi_wstrb_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_byte_mask(1),
      Q => s_axi_wstrb(1),
      R => '0'
    );
\s_axi_wstrb_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_byte_mask(2),
      Q => s_axi_wstrb(2),
      R => '0'
    );
\s_axi_wstrb_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => valid_inp_n_1,
      D => wr_byte_mask(3),
      Q => s_axi_wstrb(3),
      R => '0'
    );
s_axi_wvalid_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF7FFFF0000A000"
    )
        port map (
      I0 => s_axi_awvalid_i_2_n_0,
      I1 => s_axi_wready,
      I2 => state(1),
      I3 => state(0),
      I4 => state(2),
      I5 => \^s_axi_wvalid\,
      O => s_axi_wvalid_i_1_n_0
    );
s_axi_wvalid_reg: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => '1',
      D => s_axi_wvalid_i_1_n_0,
      Q => \^s_axi_wvalid\,
      R => s_axi_awvalid0
    );
\state[0]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00A8"
    )
        port map (
      I0 => s_axi_awready,
      I1 => state(1),
      I2 => state(6),
      I3 => state(0),
      O => \state[0]_i_2_n_0\
    );
\state[0]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0C5CFCF"
    )
        port map (
      I0 => state(3),
      I1 => state(5),
      I2 => state(2),
      I3 => state(0),
      I4 => state(1),
      O => \state[0]_i_3_n_0\
    );
\state[0]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"01110010"
    )
        port map (
      I0 => state(6),
      I1 => state(1),
      I2 => state(0),
      I3 => s_axi_rvalid,
      I4 => s_axi_arready,
      O => \state[0]_i_5_n_0\
    );
\state[1]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => s_axi_rresp(1),
      I1 => s_axi_rresp(0),
      O => \state[1]_i_3_n_0\
    );
\state[1]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000040"
    )
        port map (
      I0 => state(6),
      I1 => state(0),
      I2 => s_axi_bvalid,
      I3 => state(1),
      I4 => s_axi_bresp(0),
      I5 => s_axi_bresp(1),
      O => \state[1]_i_4_n_0\
    );
\state[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FDFF5555FC000000"
    )
        port map (
      I0 => \state[7]_i_7_n_0\,
      I1 => s_axi_rresp(0),
      I2 => s_axi_rresp(1),
      I3 => s_axi_rvalid,
      I4 => \state[7]_i_6_n_0\,
      I5 => state(2),
      O => \state[2]_i_3_n_0\
    );
\state[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0030FF00003FFF55"
    )
        port map (
      I0 => s_axi_arready,
      I1 => \state[1]_i_3_n_0\,
      I2 => s_axi_rvalid,
      I3 => \state[7]_i_10_n_0\,
      I4 => state(0),
      I5 => state(3),
      O => \state[3]_i_2_n_0\
    );
\state[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"01000D000D0C0D00"
    )
        port map (
      I0 => s_axi_arready,
      I1 => state(0),
      I2 => \state[7]_i_10_n_0\,
      I3 => state(5),
      I4 => s_axi_rvalid,
      I5 => \state[1]_i_3_n_0\,
      O => \state[5]_i_2_n_0\
    );
\state[5]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => \state[6]_i_6_n_0\,
      I1 => state(5),
      I2 => s_axi_awready,
      O => \state[5]_i_3_n_0\
    );
\state[6]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1010100000000000"
    )
        port map (
      I0 => state(1),
      I1 => state(6),
      I2 => state(0),
      I3 => s_axi_rresp(1),
      I4 => s_axi_rresp(0),
      I5 => s_axi_rvalid,
      O => \state[6]_i_2_n_0\
    );
\state[6]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => \state[6]_i_6_n_0\,
      I1 => state(6),
      I2 => s_axi_awready,
      O => \state[6]_i_3_n_0\
    );
\state[6]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000DD8DDD8D00"
    )
        port map (
      I0 => state(2),
      I1 => state(5),
      I2 => state(3),
      I3 => state(1),
      I4 => state(6),
      I5 => state(0),
      O => \state[6]_i_4_n_0\
    );
\state[6]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0ECE3FCE"
    )
        port map (
      I0 => state(6),
      I1 => state(1),
      I2 => state(0),
      I3 => state(2),
      I4 => state(5),
      O => \state[6]_i_6_n_0\
    );
\state[6]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EFEFFF0F"
    )
        port map (
      I0 => s_axi_bresp(1),
      I1 => s_axi_bresp(0),
      I2 => state(0),
      I3 => state(5),
      I4 => s_axi_bvalid,
      O => \state[6]_i_7_n_0\
    );
\state[6]_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"56"
    )
        port map (
      I0 => state(0),
      I1 => state(6),
      I2 => state(1),
      O => \state[6]_i_8_n_0\
    );
\state[6]_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => state(0),
      I1 => s_axi_wready,
      O => \state[6]_i_9_n_0\
    );
\state[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => \state[7]_i_3_n_0\,
      I1 => state(4),
      I2 => state(7),
      O => \state[7]_i_1_n_0\
    );
\state[7]_i_10\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => state(1),
      I1 => state(6),
      O => \state[7]_i_10_n_0\
    );
\state[7]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00100000000007FF"
    )
        port map (
      I0 => state(0),
      I1 => state(1),
      I2 => state(2),
      I3 => state(3),
      I4 => state(6),
      I5 => state(5),
      O => \state[7]_i_3_n_0\
    );
\state[7]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCA8FC"
    )
        port map (
      I0 => state(0),
      I1 => state(5),
      I2 => state(3),
      I3 => state(1),
      I4 => state(2),
      O => \state[7]_i_5_n_0\
    );
\state[7]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => state(0),
      I1 => state(6),
      I2 => state(1),
      O => \state[7]_i_6_n_0\
    );
\state[7]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => state(6),
      I1 => state(1),
      I2 => s_axi_arready,
      I3 => state(0),
      O => \state[7]_i_7_n_0\
    );
\state[7]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000035"
    )
        port map (
      I0 => s_axi_wready,
      I1 => s_axi_bvalid,
      I2 => state(0),
      I3 => state(1),
      I4 => state(6),
      O => \state[7]_i_8_n_0\
    );
\state_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \state[7]_i_1_n_0\,
      D => \p_0_in__0\(0),
      Q => state(0),
      R => s_axi_awvalid0
    );
\state_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \state[7]_i_1_n_0\,
      D => \p_0_in__0\(1),
      Q => state(1),
      R => s_axi_awvalid0
    );
\state_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \state[7]_i_1_n_0\,
      D => \p_0_in__0\(2),
      Q => state(2),
      R => s_axi_awvalid0
    );
\state_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \state[7]_i_1_n_0\,
      D => \p_0_in__0\(3),
      Q => state(3),
      R => s_axi_awvalid0
    );
\state_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \state[7]_i_1_n_0\,
      D => \p_0_in__0\(4),
      Q => state(4),
      R => s_axi_awvalid0
    );
\state_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \state[7]_i_1_n_0\,
      D => \p_0_in__0\(5),
      Q => state(5),
      R => s_axi_awvalid0
    );
\state_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \state[7]_i_1_n_0\,
      D => \p_0_in__0\(6),
      Q => state(6),
      R => s_axi_awvalid0
    );
\state_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ui_clk,
      CE => \state[7]_i_1_n_0\,
      D => \p_0_in__0\(7),
      Q => state(7),
      R => s_axi_awvalid0
    );
valid_inp: entity work.ethernetlite_axi_ethernet_0_0_Signal_CrossDomain_1
     port map (
      D(7 downto 0) => \p_0_in__0\(7 downto 0),
      E(0) => valid_inp_n_0,
      Q(7 downto 0) => state(7 downto 0),
      i_cen => i_cen,
      i_cen_0(0) => valid_inp_n_1,
      i_valid_p => i_valid_p,
      i_wren => i_wren,
      o_ready => o_ready,
      o_ready_reg => o_ready_i_2_n_0,
      \out\(0) => state(6),
      \s_axi_araddr_reg[0]\ => \s_axi_awaddr[31]_i_2_n_0\,
      s_axi_awready => s_axi_awready,
      s_axi_bvalid => s_axi_bvalid,
      s_axi_rvalid => s_axi_rvalid,
      s_axi_wready => s_axi_wready,
      \state_reg[0]\ => \state[0]_i_2_n_0\,
      \state_reg[0]_0\ => \state[0]_i_3_n_0\,
      \state_reg[0]_1\ => \state[0]_i_5_n_0\,
      \state_reg[0]_2\ => \state[7]_i_10_n_0\,
      \state_reg[1]\ => \state[7]_i_5_n_0\,
      \state_reg[1]_0\ => \state[7]_i_6_n_0\,
      \state_reg[1]_1\ => \state[1]_i_3_n_0\,
      \state_reg[1]_2\ => \state[1]_i_4_n_0\,
      \state_reg[1]_3\ => \state[6]_i_6_n_0\,
      \state_reg[2]\ => \state[2]_i_3_n_0\,
      \state_reg[3]\ => \state[3]_i_2_n_0\,
      \state_reg[4]\ => \state[7]_i_7_n_0\,
      \state_reg[5]\ => \state[6]_i_4_n_0\,
      \state_reg[5]_0\ => \state[5]_i_2_n_0\,
      \state_reg[5]_1\ => \state[5]_i_3_n_0\,
      \state_reg[5]_2\ => \state[6]_i_7_n_0\,
      \state_reg[5]_3\ => \state[6]_i_8_n_0\,
      \state_reg[5]_4\ => \state[6]_i_9_n_0\,
      \state_reg[6]\ => valid_inp_n_10,
      \state_reg[6]_0\ => \state[6]_i_2_n_0\,
      \state_reg[6]_1\ => \state[6]_i_3_n_0\,
      \state_reg[7]\ => \state[7]_i_8_n_0\,
      ui_clk => ui_clk
    );
wr_ack_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => state(2),
      I1 => state(6),
      I2 => wr_ack_i_2_n_0,
      I3 => wr_ack,
      O => wr_ack_i_1_n_0
    );
wr_ack_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000010040001"
    )
        port map (
      I0 => wr_ack_i_3_n_0,
      I1 => state(1),
      I2 => state(6),
      I3 => state(5),
      I4 => state(2),
      I5 => state(3),
      O => wr_ack_i_2_n_0
    );
wr_ack_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => state(0),
      I1 => state(4),
      I2 => state(7),
      O => wr_ack_i_3_n_0
    );
wr_ack_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ui_clk,
      CE => '1',
      D => wr_ack_i_1_n_0,
      Q => wr_ack,
      R => s_axi_awvalid0
    );
wrack: entity work.ethernetlite_axi_ethernet_0_0_Signal_CrossDomain_2
     port map (
      sys_clock => sys_clock,
      wr_ack => wr_ack,
      wr_ack_p => wr_ack_p
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ethernetlite_axi_ethernet_0_0 is
  port (
    address : in STD_LOGIC_VECTOR ( 31 downto 0 );
    wr_data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    wr_byte_mask : in STD_LOGIC_VECTOR ( 3 downto 0 );
    i_cen : in STD_LOGIC;
    i_wren : in STD_LOGIC;
    i_valid_p : in STD_LOGIC;
    rd_data : out STD_LOGIC_VECTOR ( 31 downto 0 );
    o_ready_p : out STD_LOGIC;
    wr_ack_p : out STD_LOGIC;
    o_valid_p : out STD_LOGIC;
    sys_resetn : in STD_LOGIC;
    sys_clock : in STD_LOGIC;
    ui_clk : in STD_LOGIC;
    ui_clk_sync_rst : in STD_LOGIC;
    s_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awvalid : out STD_LOGIC;
    s_axi_awready : in STD_LOGIC;
    s_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wlast : out STD_LOGIC;
    s_axi_wvalid : out STD_LOGIC;
    s_axi_wready : in STD_LOGIC;
    s_axi_bready : out STD_LOGIC;
    s_axi_bid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : in STD_LOGIC;
    s_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arvalid : out STD_LOGIC;
    s_axi_arready : in STD_LOGIC;
    s_axi_rready : out STD_LOGIC;
    s_axi_rid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : in STD_LOGIC;
    s_axi_rvalid : in STD_LOGIC;
    init_calib_complete : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of ethernetlite_axi_ethernet_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of ethernetlite_axi_ethernet_0_0 : entity is "ethernetlite_axi_ethernet_0_0,axi_ethernet,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of ethernetlite_axi_ethernet_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of ethernetlite_axi_ethernet_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of ethernetlite_axi_ethernet_0_0 : entity is "axi_ethernet,Vivado 2020.1";
end ethernetlite_axi_ethernet_0_0;

architecture STRUCTURE of ethernetlite_axi_ethernet_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of s_axi_arready : signal is "xilinx.com:interface:aximm:1.0 s_axi ARREADY";
  attribute X_INTERFACE_INFO of s_axi_arvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi ARVALID";
  attribute X_INTERFACE_INFO of s_axi_awready : signal is "xilinx.com:interface:aximm:1.0 s_axi AWREADY";
  attribute X_INTERFACE_INFO of s_axi_awvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi AWVALID";
  attribute X_INTERFACE_INFO of s_axi_bready : signal is "xilinx.com:interface:aximm:1.0 s_axi BREADY";
  attribute X_INTERFACE_INFO of s_axi_bvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi BVALID";
  attribute X_INTERFACE_INFO of s_axi_rlast : signal is "xilinx.com:interface:aximm:1.0 s_axi RLAST";
  attribute X_INTERFACE_INFO of s_axi_rready : signal is "xilinx.com:interface:aximm:1.0 s_axi RREADY";
  attribute X_INTERFACE_INFO of s_axi_rvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi RVALID";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of s_axi_rvalid : signal is "XIL_INTERFACENAME s_axi, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 100000000, ID_WIDTH 4, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.000, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axi_wlast : signal is "xilinx.com:interface:aximm:1.0 s_axi WLAST";
  attribute X_INTERFACE_INFO of s_axi_wready : signal is "xilinx.com:interface:aximm:1.0 s_axi WREADY";
  attribute X_INTERFACE_INFO of s_axi_wvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi WVALID";
  attribute X_INTERFACE_INFO of sys_clock : signal is "xilinx.com:signal:clock:1.0 sys_clock CLK";
  attribute X_INTERFACE_PARAMETER of sys_clock : signal is "XIL_INTERFACENAME sys_clock, ASSOCIATED_RESET sys_resetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN ethernetlite_sys_clock_0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of sys_resetn : signal is "xilinx.com:signal:reset:1.0 sys_resetn RST";
  attribute X_INTERFACE_PARAMETER of sys_resetn : signal is "XIL_INTERFACENAME sys_resetn, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of ui_clk : signal is "xilinx.com:signal:clock:1.0 ui_clk CLK";
  attribute X_INTERFACE_PARAMETER of ui_clk : signal is "XIL_INTERFACENAME ui_clk, ASSOCIATED_RESET ui_clk_sync_rst, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN ethernetlite_sys_clock_0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of ui_clk_sync_rst : signal is "xilinx.com:signal:reset:1.0 ui_clk_sync_rst RST";
  attribute X_INTERFACE_PARAMETER of ui_clk_sync_rst : signal is "XIL_INTERFACENAME ui_clk_sync_rst, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axi_araddr : signal is "xilinx.com:interface:aximm:1.0 s_axi ARADDR";
  attribute X_INTERFACE_INFO of s_axi_arburst : signal is "xilinx.com:interface:aximm:1.0 s_axi ARBURST";
  attribute X_INTERFACE_INFO of s_axi_arlen : signal is "xilinx.com:interface:aximm:1.0 s_axi ARLEN";
  attribute X_INTERFACE_INFO of s_axi_arsize : signal is "xilinx.com:interface:aximm:1.0 s_axi ARSIZE";
  attribute X_INTERFACE_INFO of s_axi_awaddr : signal is "xilinx.com:interface:aximm:1.0 s_axi AWADDR";
  attribute X_INTERFACE_INFO of s_axi_awburst : signal is "xilinx.com:interface:aximm:1.0 s_axi AWBURST";
  attribute X_INTERFACE_INFO of s_axi_awlen : signal is "xilinx.com:interface:aximm:1.0 s_axi AWLEN";
  attribute X_INTERFACE_INFO of s_axi_awsize : signal is "xilinx.com:interface:aximm:1.0 s_axi AWSIZE";
  attribute X_INTERFACE_INFO of s_axi_bid : signal is "xilinx.com:interface:aximm:1.0 s_axi BID";
  attribute X_INTERFACE_INFO of s_axi_bresp : signal is "xilinx.com:interface:aximm:1.0 s_axi BRESP";
  attribute X_INTERFACE_INFO of s_axi_rdata : signal is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of s_axi_rid : signal is "xilinx.com:interface:aximm:1.0 s_axi RID";
  attribute X_INTERFACE_INFO of s_axi_rresp : signal is "xilinx.com:interface:aximm:1.0 s_axi RRESP";
  attribute X_INTERFACE_INFO of s_axi_wdata : signal is "xilinx.com:interface:aximm:1.0 s_axi WDATA";
  attribute X_INTERFACE_INFO of s_axi_wstrb : signal is "xilinx.com:interface:aximm:1.0 s_axi WSTRB";
begin
  s_axi_arburst(1) <= \<const0>\;
  s_axi_arburst(0) <= \<const0>\;
  s_axi_arlen(7) <= \<const0>\;
  s_axi_arlen(6) <= \<const0>\;
  s_axi_arlen(5) <= \<const0>\;
  s_axi_arlen(4) <= \<const0>\;
  s_axi_arlen(3) <= \<const0>\;
  s_axi_arlen(2) <= \<const0>\;
  s_axi_arlen(1) <= \<const0>\;
  s_axi_arlen(0) <= \<const0>\;
  s_axi_arsize(2) <= \<const0>\;
  s_axi_arsize(1) <= \<const0>\;
  s_axi_arsize(0) <= \<const1>\;
  s_axi_awburst(1) <= \<const0>\;
  s_axi_awburst(0) <= \<const0>\;
  s_axi_awlen(7) <= \<const0>\;
  s_axi_awlen(6) <= \<const0>\;
  s_axi_awlen(5) <= \<const0>\;
  s_axi_awlen(4) <= \<const0>\;
  s_axi_awlen(3) <= \<const0>\;
  s_axi_awlen(2) <= \<const0>\;
  s_axi_awlen(1) <= \<const0>\;
  s_axi_awlen(0) <= \<const0>\;
  s_axi_awsize(2) <= \<const0>\;
  s_axi_awsize(1) <= \<const1>\;
  s_axi_awsize(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
     port map (
      P => \<const1>\
    );
inst: entity work.ethernetlite_axi_ethernet_0_0_axi_ethernet
     port map (
      address(31 downto 0) => address(31 downto 0),
      i_cen => i_cen,
      i_valid_p => i_valid_p,
      i_wren => i_wren,
      init_calib_complete => init_calib_complete,
      o_ready_p => o_ready_p,
      o_valid_p => o_valid_p,
      rd_data(31 downto 0) => rd_data(31 downto 0),
      s_axi_araddr(31 downto 0) => s_axi_araddr(31 downto 0),
      s_axi_arready => s_axi_arready,
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(31 downto 0) => s_axi_awaddr(31 downto 0),
      s_axi_awready => s_axi_awready,
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bready => s_axi_bready,
      s_axi_bresp(1 downto 0) => s_axi_bresp(1 downto 0),
      s_axi_bvalid => s_axi_bvalid,
      s_axi_rdata(31 downto 0) => s_axi_rdata(31 downto 0),
      s_axi_rready => s_axi_rready,
      s_axi_rresp(1 downto 0) => s_axi_rresp(1 downto 0),
      s_axi_rvalid => s_axi_rvalid,
      s_axi_wdata(31 downto 0) => s_axi_wdata(31 downto 0),
      s_axi_wlast => s_axi_wlast,
      s_axi_wready => s_axi_wready,
      s_axi_wstrb(3 downto 0) => s_axi_wstrb(3 downto 0),
      s_axi_wvalid => s_axi_wvalid,
      sys_clock => sys_clock,
      ui_clk => ui_clk,
      ui_clk_sync_rst => ui_clk_sync_rst,
      wr_ack_p => wr_ack_p,
      wr_byte_mask(3 downto 0) => wr_byte_mask(3 downto 0),
      wr_data(31 downto 0) => wr_data(31 downto 0)
    );
end STRUCTURE;
