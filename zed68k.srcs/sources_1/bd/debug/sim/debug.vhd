--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
--Date        : Mon Aug  3 13:58:33 2020
--Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
--Command     : generate_target debug.bd
--Design      : debug
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity debug is
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
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of debug : entity is "debug,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=debug,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of debug : entity is "debug.hwdef";
end debug;

architecture STRUCTURE of debug is
  component debug_ila_0_0 is
  port (
    clk : in STD_LOGIC;
    probe0 : in STD_LOGIC_VECTOR ( 26 downto 0 );
    probe1 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    probe2 : in STD_LOGIC_VECTOR ( 63 downto 0 );
    probe3 : in STD_LOGIC_VECTOR ( 63 downto 0 );
    probe4 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe5 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe6 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component debug_ila_0_0;
  signal clk_0_1 : STD_LOGIC;
  signal probe0_0_1 : STD_LOGIC_VECTOR ( 26 downto 0 );
  signal probe1_0_1 : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal probe2_0_1 : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal probe3_0_1 : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal probe4_0_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal probe5_0_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal probe6_0_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 CLK.CLK CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME CLK.CLK, CLK_DOMAIN debug_clk_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000";
begin
  clk_0_1 <= clk;
  probe0_0_1(26 downto 0) <= address(26 downto 0);
  probe1_0_1(2 downto 0) <= state(2 downto 0);
  probe2_0_1(63 downto 0) <= readdata(63 downto 0);
  probe3_0_1(63 downto 0) <= writedata(63 downto 0);
  probe4_0_1(0) <= wdf_rdy(0);
  probe5_0_1(0) <= rdf_rdy(0);
  probe6_0_1(0) <= tmp(0);
ila_0: component debug_ila_0_0
     port map (
      clk => clk_0_1,
      probe0(26 downto 0) => probe0_0_1(26 downto 0),
      probe1(2 downto 0) => probe1_0_1(2 downto 0),
      probe2(63 downto 0) => probe2_0_1(63 downto 0),
      probe3(63 downto 0) => probe3_0_1(63 downto 0),
      probe4(0) => probe4_0_1(0),
      probe5(0) => probe5_0_1(0),
      probe6(0) => probe6_0_1(0)
    );
end STRUCTURE;
