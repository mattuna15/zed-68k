--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
--Date        : Wed Sep  2 16:21:22 2020
--Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
--Command     : generate_target serial.bd
--Design      : serial
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity serial is
  port (
    cts : out STD_LOGIC;
    reset_n : in STD_LOGIC;
    rts : out STD_LOGIC;
    sys_clk : in STD_LOGIC;
    tx_data : in STD_LOGIC_VECTOR ( 7 downto 0 );
    tx_send_active : out STD_LOGIC;
    tx_wr_en : in STD_LOGIC;
    txd : out STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of serial : entity is "serial,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=serial,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=3,numReposBlks=3,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=2,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of serial : entity is "serial.hwdef";
end serial;

architecture STRUCTURE of serial is
  component serial_UART_TX_0_0 is
  port (
    i_Clk : in STD_LOGIC;
    i_TX_DV : in STD_LOGIC;
    i_TX_Byte : in STD_LOGIC_VECTOR ( 7 downto 0 );
    o_TX_Active : out STD_LOGIC;
    o_TX_Serial : out STD_LOGIC;
    o_TX_Done : out STD_LOGIC
  );
  end component serial_UART_TX_0_0;
  component serial_fifo_generator_0_0 is
  port (
    clk : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 7 downto 0 );
    wr_en : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 7 downto 0 );
    full : out STD_LOGIC;
    wr_ack : out STD_LOGIC;
    empty : out STD_LOGIC;
    valid : out STD_LOGIC;
    data_count : out STD_LOGIC_VECTOR ( 4 downto 0 )
  );
  end component serial_fifo_generator_0_0;
  component serial_UART_FIFO_IO_cntl_pr_0_0 is
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
  end component serial_UART_FIFO_IO_cntl_pr_0_0;
  signal UART_FIFO_IO_cntl_pr_0_fifoM_rd_en : STD_LOGIC;
  signal UART_FIFO_IO_cntl_pr_0_uart_rx_rd_en : STD_LOGIC;
  signal UART_FIFO_IO_cntl_pr_0_uart_tx_wr_en : STD_LOGIC;
  signal UART_TX_0_o_TX_Active : STD_LOGIC;
  signal UART_TX_0_o_TX_Done : STD_LOGIC;
  signal UART_TX_0_o_TX_Serial : STD_LOGIC;
  signal clk_0_1 : STD_LOGIC;
  signal din_0_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal fifo_generator_0_dout : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal fifo_generator_0_full : STD_LOGIC;
  signal fifo_generator_0_valid : STD_LOGIC;
  signal fifo_generator_0_wr_ack : STD_LOGIC;
  signal rst_0_1 : STD_LOGIC;
  signal wr_en_0_1 : STD_LOGIC;
  signal NLW_UART_FIFO_IO_cntl_pr_0_fifoM_wr_en_UNCONNECTED : STD_LOGIC;
  signal NLW_fifo_generator_0_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_fifo_generator_0_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of reset_n : signal is "xilinx.com:signal:reset:1.0 RST.RESET_N RST";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of reset_n : signal is "XIL_INTERFACENAME RST.RESET_N, INSERT_VIP 0, POLARITY ACTIVE_LOW";
  attribute X_INTERFACE_INFO of sys_clk : signal is "xilinx.com:signal:clock:1.0 CLK.SYS_CLK CLK";
  attribute X_INTERFACE_PARAMETER of sys_clk : signal is "XIL_INTERFACENAME CLK.SYS_CLK, ASSOCIATED_RESET reset_n, CLK_DOMAIN serial_sys_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000";
begin
  clk_0_1 <= sys_clk;
  cts <= UART_FIFO_IO_cntl_pr_0_uart_rx_rd_en;
  din_0_1(7 downto 0) <= tx_data(7 downto 0);
  rst_0_1 <= reset_n;
  rts <= UART_FIFO_IO_cntl_pr_0_uart_tx_wr_en;
  tx_send_active <= UART_TX_0_o_TX_Active;
  txd <= UART_TX_0_o_TX_Serial;
  wr_en_0_1 <= tx_wr_en;
UART_FIFO_IO_cntl_pr_0: component serial_UART_FIFO_IO_cntl_pr_0_0
     port map (
      clk => clk_0_1,
      fifoM_empty => '0',
      fifoM_full => fifo_generator_0_full,
      fifoM_rd_en => UART_FIFO_IO_cntl_pr_0_fifoM_rd_en,
      fifoM_wr_ack => fifo_generator_0_wr_ack,
      fifoM_wr_en => NLW_UART_FIFO_IO_cntl_pr_0_fifoM_wr_en_UNCONNECTED,
      rst => rst_0_1,
      uart_rx_dv => '0',
      uart_rx_rd_en => UART_FIFO_IO_cntl_pr_0_uart_rx_rd_en,
      uart_tx_rfd => UART_TX_0_o_TX_Done,
      uart_tx_wr_en => UART_FIFO_IO_cntl_pr_0_uart_tx_wr_en
    );
UART_TX_0: component serial_UART_TX_0_0
     port map (
      i_Clk => clk_0_1,
      i_TX_Byte(7 downto 0) => fifo_generator_0_dout(7 downto 0),
      i_TX_DV => fifo_generator_0_valid,
      o_TX_Active => UART_TX_0_o_TX_Active,
      o_TX_Done => UART_TX_0_o_TX_Done,
      o_TX_Serial => UART_TX_0_o_TX_Serial
    );
fifo_generator_0: component serial_fifo_generator_0_0
     port map (
      clk => clk_0_1,
      data_count(4 downto 0) => NLW_fifo_generator_0_data_count_UNCONNECTED(4 downto 0),
      din(7 downto 0) => din_0_1(7 downto 0),
      dout(7 downto 0) => fifo_generator_0_dout(7 downto 0),
      empty => NLW_fifo_generator_0_empty_UNCONNECTED,
      full => fifo_generator_0_full,
      rd_en => UART_FIFO_IO_cntl_pr_0_fifoM_rd_en,
      valid => fifo_generator_0_valid,
      wr_ack => fifo_generator_0_wr_ack,
      wr_en => wr_en_0_1
    );
end STRUCTURE;
