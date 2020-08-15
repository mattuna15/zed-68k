--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
--Date        : Sat Aug 15 12:47:18 2020
--Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
--Command     : generate_target design_1.bd
--Design      : design_1
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1 is
  port (
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
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of design_1 : entity is "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=3,numReposBlks=3,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=2,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of design_1 : entity is "design_1.hwdef";
end design_1;

architecture STRUCTURE of design_1 is
  component design_1_fifo_generator_0_0 is
  port (
    wr_clk : in STD_LOGIC;
    rd_clk : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 7 downto 0 );
    wr_en : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 7 downto 0 );
    full : out STD_LOGIC;
    wr_ack : out STD_LOGIC;
    empty : out STD_LOGIC;
    valid : out STD_LOGIC;
    rd_data_count : out STD_LOGIC_VECTOR ( 8 downto 0 );
    wr_data_count : out STD_LOGIC_VECTOR ( 8 downto 0 )
  );
  end component design_1_fifo_generator_0_0;
  component design_1_UART_RX_0_0 is
  port (
    i_Clk : in STD_LOGIC;
    i_RX_Serial : in STD_LOGIC;
    o_RX_DV : out STD_LOGIC;
    o_RX_Byte : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  end component design_1_UART_RX_0_0;
  component design_1_UART_FIFO_IO_cntl_pr_0_0 is
  port (
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    uart_rx_dv : in STD_LOGIC;
    uart_tx_rfd : in STD_LOGIC;
    fifoM_full : in STD_LOGIC;
    fifoM_empty : in STD_LOGIC;
    fifoM_wr_ack : in STD_LOGIC;
    uart_rx_rd_en : out STD_LOGIC;
    uart_tx_wr_en : out STD_LOGIC;
    fifoM_wr_en : out STD_LOGIC;
    fifoM_rd_en : out STD_LOGIC
  );
  end component design_1_UART_FIFO_IO_cntl_pr_0_0;
  signal UART_FIFO_IO_cntl_pr_0_fifoM_wr_en : STD_LOGIC;
  signal UART_FIFO_IO_cntl_pr_0_uart_rx_rd_en : STD_LOGIC;
  signal UART_FIFO_IO_cntl_pr_0_uart_tx_wr_en : STD_LOGIC;
  signal UART_RX_0_o_RX_Byte : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal UART_RX_0_o_RX_DV : STD_LOGIC;
  signal clk_wiz_0_clk_out1 : STD_LOGIC;
  signal fifo_generator_0_dout : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal fifo_generator_0_empty : STD_LOGIC;
  signal fifo_generator_0_full : STD_LOGIC;
  signal fifo_generator_0_rd_data_count : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal fifo_generator_0_wr_ack : STD_LOGIC;
  signal rd_clk_0_1 : STD_LOGIC;
  signal rd_en_0_1 : STD_LOGIC;
  signal reset_n_1 : STD_LOGIC;
  signal rxd1_1 : STD_LOGIC;
  signal NLW_UART_FIFO_IO_cntl_pr_0_fifoM_rd_en_UNCONNECTED : STD_LOGIC;
  signal NLW_fifo_generator_0_valid_UNCONNECTED : STD_LOGIC;
  signal NLW_fifo_generator_0_wr_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 8 downto 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk100_i : signal is "xilinx.com:signal:clock:1.0 CLK.CLK100_I CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk100_i : signal is "XIL_INTERFACENAME CLK.CLK100_I, ASSOCIATED_RESET reset_n, CLK_DOMAIN design_1_clk100_i, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000";
  attribute X_INTERFACE_INFO of rd_clk : signal is "xilinx.com:signal:clock:1.0 CLK.RD_CLK CLK";
  attribute X_INTERFACE_PARAMETER of rd_clk : signal is "XIL_INTERFACENAME CLK.RD_CLK, CLK_DOMAIN design_1_rd_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000";
  attribute X_INTERFACE_INFO of reset_n : signal is "xilinx.com:signal:reset:1.0 RST.RESET_N RST";
  attribute X_INTERFACE_PARAMETER of reset_n : signal is "XIL_INTERFACENAME RST.RESET_N, INSERT_VIP 0, POLARITY ACTIVE_LOW";
begin
  LED(7 downto 0) <= fifo_generator_0_dout(7 downto 0);
  clk_wiz_0_clk_out1 <= clk100_i;
  cts <= UART_FIFO_IO_cntl_pr_0_uart_rx_rd_en;
  m68_rxd(7 downto 0) <= fifo_generator_0_dout(7 downto 0);
  rd_clk_0_1 <= rd_clk;
  rd_data_cnt(8 downto 0) <= fifo_generator_0_rd_data_count(8 downto 0);
  rd_en_0_1 <= rd_en;
  reset_n_1 <= reset_n;
  rts <= UART_FIFO_IO_cntl_pr_0_uart_tx_wr_en;
  rxd1_1 <= rxd1;
UART_FIFO_IO_cntl_pr_0: component design_1_UART_FIFO_IO_cntl_pr_0_0
     port map (
      clk => clk_wiz_0_clk_out1,
      fifoM_empty => fifo_generator_0_empty,
      fifoM_full => fifo_generator_0_full,
      fifoM_rd_en => NLW_UART_FIFO_IO_cntl_pr_0_fifoM_rd_en_UNCONNECTED,
      fifoM_wr_ack => fifo_generator_0_wr_ack,
      fifoM_wr_en => UART_FIFO_IO_cntl_pr_0_fifoM_wr_en,
      rst => reset_n_1,
      uart_rx_dv => UART_RX_0_o_RX_DV,
      uart_rx_rd_en => UART_FIFO_IO_cntl_pr_0_uart_rx_rd_en,
      uart_tx_rfd => '0',
      uart_tx_wr_en => UART_FIFO_IO_cntl_pr_0_uart_tx_wr_en
    );
UART_RX_0: component design_1_UART_RX_0_0
     port map (
      i_Clk => clk_wiz_0_clk_out1,
      i_RX_Serial => rxd1_1,
      o_RX_Byte(7 downto 0) => UART_RX_0_o_RX_Byte(7 downto 0),
      o_RX_DV => UART_RX_0_o_RX_DV
    );
fifo_generator_0: component design_1_fifo_generator_0_0
     port map (
      din(7 downto 0) => UART_RX_0_o_RX_Byte(7 downto 0),
      dout(7 downto 0) => fifo_generator_0_dout(7 downto 0),
      empty => fifo_generator_0_empty,
      full => fifo_generator_0_full,
      rd_clk => rd_clk_0_1,
      rd_data_count(8 downto 0) => fifo_generator_0_rd_data_count(8 downto 0),
      rd_en => rd_en_0_1,
      valid => NLW_fifo_generator_0_valid_UNCONNECTED,
      wr_ack => fifo_generator_0_wr_ack,
      wr_clk => clk_wiz_0_clk_out1,
      wr_data_count(8 downto 0) => NLW_fifo_generator_0_wr_data_count_UNCONNECTED(8 downto 0),
      wr_en => UART_FIFO_IO_cntl_pr_0_fifoM_wr_en
    );
end STRUCTURE;
