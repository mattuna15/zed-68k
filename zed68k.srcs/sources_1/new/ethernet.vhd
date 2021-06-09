----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.06.2021 13:30:26
-- Design Name: 
-- Module Name: ethernet - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ethernet is
Port (
    eth_clk : in std_logic;
    sys_resetn : in std_logic;
    
    --cpu data
    eth_data_in : in std_logic_vector(7 downto 0);
    eth_data_out : out std_logic_vector(7 downto 0);
    eth_ctl : inout std_logic_vector(7 downto 0);
    eth_ack_rx: out std_logic;
    
    --phy
    eth_mdc : out STD_LOGIC;
    eth_mdio : inout STD_LOGIC;
    eth_col : in STD_LOGIC;
    eth_crs : in STD_LOGIC;
    eth_rstn : out STD_LOGIC;
    eth_rx_clk : in STD_LOGIC;
    eth_rx_dv : in STD_LOGIC;
    eth_rxerr : in STD_LOGIC;
    eth_rxd : in STD_LOGIC_VECTOR ( 3 downto 0 );
    eth_tx_clk : in STD_LOGIC;
    eth_tx_en : out STD_LOGIC;
    eth_txd : out STD_LOGIC_VECTOR ( 3 downto 0 );
    eth_ref_clk : out STD_LOGIC

 );
end ethernet;

architecture Behavioral of ethernet is
    
component FC1002_MII is
    port (
        --Sys/Common
        Clk             : in  std_logic; --100 MHz
        Reset           : in  std_logic; --Active high
        UseDHCP         : in  std_logic; --'1' to use DHCP
        IP_Addr         : in  std_logic_vector(31 downto 0); --IP address if not using DHCP
        IP_Ok           : out std_logic; --DHCP ready

        --MAC/MII
        MII_REF_CLK_25M : out std_logic; --MII continous 25 MHz reference clock
        MII_RST_N       : out std_logic; --Phy reset, active low
        MII_COL         : in  std_logic; --Collision detect
        MII_CRS         : in  std_logic; --Carrier sense
        MII_RX_CLK      : in  std_logic; --Receive clock
        MII_CRS_DV      : in  std_logic; --Receive data valid
        MII_RXD         : in  std_logic_vector(3 downto 0); --Receive data
        MII_RXERR       : in  std_logic; --Receive error
        MII_TX_CLK      : in  std_logic; --Transmit clock
        MII_TXEN        : out std_logic; --Transmit enable
        MII_TXD         : out std_logic_vector(3 downto 0); --Transmit data
        MII_MDC         : out std_logic; --Management clock
        MII_MDIO        : inout std_logic; --Management data

        --SPI/Boot Control
        SPI_CSn         : out std_logic; --Chip select
        SPI_SCK         : out std_logic; --Serial clock
        SPI_MOSI        : out std_logic; --Master out slave in
        SPI_MISO        : in  std_logic; --Master in slave out

        --Logic Analyzer
        LA0_TrigIn      : in  std_logic; --Trigger input
        LA0_Clk         : in  std_logic; --Clock
        LA0_TrigOut     : out std_logic; --Trigger out
        LA0_Signals     : in  std_logic_vector(31 downto 0); --Signals
        LA0_SampleEn    : in  std_logic; --Sample enable

        --TCP Basic Server
        TCP0_Service    : in  std_logic_vector(15 downto 0); --Service
        TCP0_ServerPort : in  std_logic_vector(15 downto 0); --TCP local server port
        TCP0_Connected  : out std_logic; --Client connected
        TCP0_AllAcked   : out std_logic; --All outgoing data acked
        TCP0_nTxFree    : out std_logic_vector(15 downto 0); --Number of free bytes in outgoing buffer
        TCP0_nRxData    : out std_logic_vector(15 downto 0); --Number of bytes in receiving buffer
        TCP0_TxData     : in  std_logic_vector(7 downto 0); --Transmit data
        TCP0_TxValid    : in  std_logic; --Transmit data valid
        TCP0_TxReady    : out std_logic; --Transmit data ready
        TCP0_RxData     : out std_logic_vector(7 downto 0); --Receive data
        TCP0_RxValid    : out std_logic; --Receive data valid
        TCP0_RxReady    : in  std_logic  --Receive data ready
    );
end component;

component axis_register is
generic ( WIDTH : integer := 8);
port (
	clock  : in std_logic; 
	resetn : in std_logic; 
	size : out std_logic_vector(1 downto 0);
	idata : in std_logic_vector(WIDTH-1 downto 0);
	ivalid : in std_logic; 
	iready : out std_logic; 
	odata : out std_logic_vector(WIDTH-1 downto 0);
	ovalid : out std_logic;
	oready : in std_logic);
end component;

component axis_rx_fifo is
port (
  s_axis_aresetn : in std_logic;
  s_axis_aclk : in std_logic;
  s_axis_tvalid : in std_logic;
  s_axis_tready : out std_logic;
  s_axis_tdata : in std_logic_vector(7 downto 0);
  m_axis_tvalid : out std_logic;
  m_axis_tready : in std_logic;
  m_axis_tdata : out std_logic_vector(7 downto 0)
);
end component;

   signal  axis_tx_data : std_logic_vector(7 downto 0); --Transmit data
   signal  axis_tx_valid : std_logic; --Transmit data valid
   signal  axis_tx_ready : std_logic; --Transmit data ready
   signal   axis_rx_data : std_logic_vector(7 downto 0); --Receive data
   signal  axis_rx_valid : std_logic; --Receive data valid
   signal  axis_rx_ready : std_logic; --Receive data ready
   signal  eth_state: std_logic_vector(2 downto 0);
   
   signal  fifo_rx_data : std_logic_vector(7 downto 0); --Receive data
   signal  fifo_rx_valid : std_logic; --Receive data valid
   signal  fifo_rx_ready : std_logic; --Receive data ready
   
    signal reg_rx_ready: std_logic;
    signal reg_rx_valid: std_logic;
    signal reg_rx_data: std_logic_vector(7 downto 0);
    
    signal reg_tx_ready: std_logic;
    signal reg_tx_valid: std_logic;
    signal reg_tx_data: std_logic_vector(7 downto 0);

    signal eth_tx_free : std_logic_vector(15 downto 0);
    signal eth_rx_count : std_logic_vector(15 downto 0);
    signal eth_tx_sts: std_logic_vector(1 downto 0);
    signal eth_rx_sts: std_logic_vector(1 downto 0);

   signal cpu_eth_rx_ready : std_logic;
   signal eth_rx_first : std_logic :='1';
   signal eth_tx_first : std_logic :='1';
   
   
   attribute dont_touch : string;

   attribute dont_touch of rx_proc : label is "true";
   attribute dont_touch of rx_register : label is "true";
   attribute dont_touch of tx_proc : label is "true";
   attribute dont_touch of tx_register : label is "true";

begin

rx_fifo: axis_rx_fifo
port map (

  s_axis_aresetn => sys_resetn,
  s_axis_aclk => eth_clk,
  s_axis_tvalid => axis_rx_valid,
  s_axis_tready => axis_rx_ready,
  s_axis_tdata => axis_rx_data,
  m_axis_tvalid => fifo_rx_valid,
  m_axis_tready => fifo_rx_ready,
  m_axis_tdata => fifo_rx_data
);


rx_register: axis_register
port map (
	clock => eth_clk, 
	resetn =>  sys_resetn,
	size => eth_rx_sts,
	idata => fifo_rx_data,
	ivalid => fifo_rx_valid,
	iready => fifo_rx_ready,
	odata => reg_rx_data,
	ovalid => reg_rx_valid,
	oready => reg_rx_ready
	);
	
	cpu_eth_rx_ready <= eth_ctl(5);
    eth_ctl(2) <= reg_rx_valid;


rx_proc: process(eth_clk)
    
begin

    if rising_edge(eth_clk) then
    
    case eth_state is
    when "000" => -- idle
        eth_ack_rx <= '0';
        if reg_rx_valid = '1' then 
            eth_state <= "001";
        else
            eth_rx_first <= '1';
        end if;
    when "001" => --valid rx on dataout
        if eth_rx_first <= '1' then
            eth_rx_first <= '0';
            eth_state <= "010"; -- valid first
        else
            eth_state <= "100"; -- not first so get next valid char.
        end if;
    when "010" => -- valid first char - it is first and valid so wait until cpu wants it
        if cpu_eth_rx_ready = '1' then
            eth_data_out <= reg_rx_data; -- data out
            eth_ack_rx <= '1'; --ack data to cpu
            eth_state <= "011";
        end if;
    when "011" => -- either need new char or next char
            if cpu_eth_rx_ready = '0' then -- wait until cpu finished with data
                eth_ack_rx <= '0'; --don't ack data to cpu
                eth_state <= "100";
            end if;
    when "100" => -- next char
            if reg_rx_valid = '1' then
                reg_rx_ready <= '1';
            end if;
            eth_state <= "110";
    when others => --next char should be ready (if valid)
            reg_rx_ready <= '0';
            eth_rx_first <= '1';
            eth_state <= "000";
    end case;     
                
    end if;

end process;
	
tx_register: axis_register
port map (
	clock => eth_clk, 
	resetn =>  sys_resetn,
	size => eth_tx_sts,
	idata => reg_tx_data,--eth_data_in,
	ivalid => reg_tx_valid,--eth_ctl(6),
	iready => reg_tx_ready,--eth_ctl(3),
	odata => axis_tx_data,
	ovalid => axis_tx_valid,
	oready => axis_tx_ready
	);
   
eth_ctl(3) <= reg_tx_ready;
    
tx_proc: process(eth_clk)
begin

    if rising_edge(eth_clk) then
    
        if eth_ctl(6) = '1' and reg_tx_valid = '0' and eth_tx_first = '1' then
            reg_tx_data <= eth_data_in;
            reg_tx_valid <= '1';
            eth_tx_first <= '0';
        else
            reg_tx_valid <= '0';
            
            if eth_ctl(6) = '0' then 
                eth_tx_first <= '1';
            end if;
                
        end if;

    end if;
    
end process;
    
    ethernet : FC1002_MII 
    port map (
        --Sys/Common
        Clk             => eth_clk, --100 MHz
        Reset           => not sys_resetn,--Active high
        UseDHCP         => '1', --'1' to use DHCP
        IP_Addr         => (others => '0'), --IP address if not using DHCP
        IP_Ok           => open, --DHCP ready

        --MAC/MII
        MII_REF_CLK_25M => eth_ref_clk, --MII continous 25 MHz reference clock
        MII_RST_N      => eth_rstn, --Phy reset, active low
        MII_COL        => eth_col, --Collision detect
        MII_CRS        => eth_crs, --Carrier sense
        MII_RX_CLK     => eth_rx_clk, --Receive clock
        MII_CRS_DV     => eth_rx_dv, --Receive data valid
        MII_RXD        => eth_rxd, --Receive data
        MII_RXERR      => eth_rxerr, --Receive error
        MII_TX_CLK     => eth_tx_clk, --Transmit clock
        MII_TXEN       => eth_tx_en, --Transmit enable
        MII_TXD        => eth_txd,--Transmit data
        MII_MDC        => eth_mdc, --Management clock
        MII_MDIO       => eth_mdio, --Management data

        --SPI/Boot Control
        SPI_CSn         => open,
        SPI_SCK         => open, --qspi_sck, --??qspi_sck,
        SPI_MOSI        => open, --qspi_dq(0),
        SPI_MISO        => '0', --qspi_dq(1),
       
        --Logic Analyzer
        LA0_TrigIn     => '0',
        LA0_Clk        => '0',
        LA0_TrigOut     => open,
        LA0_Signals    => (others => '0'), --Signals
        LA0_SampleEn   => '0', --Sample enable

        --TCP Basic Server
        TCP0_Service    => x"0112",
        TCP0_ServerPort => x"E001",
        TCP0_Connected => eth_ctl(0), --Client connected
        TCP0_AllAcked  => eth_ctl(1),--All outgoing data acked
        TCP0_nTxFree  => eth_tx_free, --Number of free bytes in outgoing buffer
        TCP0_nRxData   => eth_rx_count, --Number of bytes in receiving buffer
        TCP0_TxData     => axis_tx_data, --Transmit data
        TCP0_TxValid    => axis_tx_valid, --Transmit data valid
        TCP0_TxReady    => axis_tx_ready, --Transmit data ready
        TCP0_RxData     => axis_rx_data, --Receive data
        TCP0_RxValid    => axis_rx_valid, --Receive data valid
        TCP0_RxReady    => axis_rx_ready  --Receive data ready
    );
   


end Behavioral;
