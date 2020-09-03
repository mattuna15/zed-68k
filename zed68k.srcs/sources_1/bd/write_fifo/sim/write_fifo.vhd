--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
--Date        : Sat Aug 29 11:10:27 2020
--Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
--Command     : generate_target write_fifo.bd
--Design      : write_fifo
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity write_fifo is
  port (
    clk : in STD_LOGIC;
    data_count : out STD_LOGIC_VECTOR ( 8 downto 0 );
    din : in STD_LOGIC_VECTOR ( 44 downto 0 );
    dout : out STD_LOGIC_VECTOR ( 44 downto 0 );
    rd_en : in STD_LOGIC;
    rst : in STD_LOGIC;
    wr_ack : out STD_LOGIC;
    wr_en : in STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of write_fifo : entity is "write_fifo,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=write_fifo,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of write_fifo : entity is "write_fifo.hwdef";
end write_fifo;

architecture STRUCTURE of write_fifo is
  component write_fifo_fifo_generator_0_0 is
  port (
    clk : in STD_LOGIC;
    srst : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 44 downto 0 );
    wr_en : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 44 downto 0 );
    full : out STD_LOGIC;
    wr_ack : out STD_LOGIC;
    empty : out STD_LOGIC;
    data_count : out STD_LOGIC_VECTOR ( 8 downto 0 )
  );
  end component write_fifo_fifo_generator_0_0;
  signal clk_0_1 : STD_LOGIC;
  signal din_0_1 : STD_LOGIC_VECTOR ( 44 downto 0 );
  signal fifo_generator_0_data_count : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal fifo_generator_0_dout : STD_LOGIC_VECTOR ( 44 downto 0 );
  signal fifo_generator_0_wr_ack : STD_LOGIC;
  signal rd_en_0_1 : STD_LOGIC;
  signal srst_0_1 : STD_LOGIC;
  signal wr_en_0_1 : STD_LOGIC;
  signal NLW_fifo_generator_0_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_fifo_generator_0_full_UNCONNECTED : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 CLK.CLK CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME CLK.CLK, CLK_DOMAIN write_fifo_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000";
begin
  clk_0_1 <= clk;
  data_count(8 downto 0) <= fifo_generator_0_data_count(8 downto 0);
  din_0_1(44 downto 0) <= din(44 downto 0);
  dout(44 downto 0) <= fifo_generator_0_dout(44 downto 0);
  rd_en_0_1 <= rd_en;
  srst_0_1 <= rst;
  wr_ack <= fifo_generator_0_wr_ack;
  wr_en_0_1 <= wr_en;
fifo_generator_0: component write_fifo_fifo_generator_0_0
     port map (
      clk => clk_0_1,
      data_count(8 downto 0) => fifo_generator_0_data_count(8 downto 0),
      din(44 downto 0) => din_0_1(44 downto 0),
      dout(44 downto 0) => fifo_generator_0_dout(44 downto 0),
      empty => NLW_fifo_generator_0_empty_UNCONNECTED,
      full => NLW_fifo_generator_0_full_UNCONNECTED,
      rd_en => rd_en_0_1,
      srst => srst_0_1,
      wr_ack => fifo_generator_0_wr_ack,
      wr_en => wr_en_0_1
    );
end STRUCTURE;
