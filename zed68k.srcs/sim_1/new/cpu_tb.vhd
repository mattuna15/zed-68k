----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.11.2021 19:07:24
-- Design Name: 
-- Module Name: cpu_tb - Behavioral
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

entity cpu_tb is
--  Port ( );
end cpu_tb;

architecture Behavioral of cpu_tb is


component multicomp_wrapper is
port(
        sys_clock   : in std_logic;
        resetn      : in STD_LOGIC;

    led : out STD_LOGIC_VECTOR ( 3 downto 0 );
      
      --ram
    
      ddr3_addr            : out   std_logic_vector(13 downto 0);
      ddr3_ba              : out   std_logic_vector(2 downto 0);
      ddr3_ras_n           : out   std_logic;
      ddr3_cas_n           : out   std_logic;
      ddr3_we_n            : out   std_logic;
      ddr3_ck_p            : out   std_logic_vector(0 downto 0);
      ddr3_ck_n            : out   std_logic_vector(0 downto 0);
      ddr3_cke             : out   std_logic_vector(0 downto 0);
      ddr3_cs_n             : out   std_logic;
      ddr3_dm              : out   std_logic_vector(1 downto 0);
      ddr3_odt             : out   std_logic_vector(0 downto 0);
      ddr3_dq              : inout std_logic_vector(15 downto 0);
      ddr3_dqs_p           : inout std_logic_vector(1 downto 0);
      ddr3_dqs_n           : inout std_logic_vector(1 downto 0);
      
      ddr3_reset_n :out std_logic;
      
      --dazzler
      
        gd_uart_txd_out : out   std_logic;                  -- gd uart out
        gd_gpu_sel : out std_logic;
        gd_sd_sel : out std_logic;
        gd_daz_sel : out std_logic;
        gd_mosi : out std_logic;
        gd_miso : in std_logic;
        gd_sclk  : out std_logic;
        
         SD_CSn: inout std_logic; -- #IO_L14P_T2_SRCC_35 Sch=sd_reset or DAT3
         SD_CD : in std_logic;  --#IO_L9N_T1_DQS_AD7N_35 Sch=sd_cd
         SD_SCK : out std_logic; --
         SD_CMD : out std_logic; -- #IO_L16N_T2_35 Sch=sd_cmd
         SD_DAT0 : in std_logic; -- #IO_L16P_T2_35 Sch=sd_dat[0]
         SD_DAT1 : inout std_logic;-- #IO_L18N_T2_35 Sch=sd_dat[1]
         SD_DAT2: inout std_logic;-- #IO_L18P_T2_35 Sch=sd_dat[2]
         SD_WP : inout std_logic;--
        
        sw : in std_logic_vector(3 downto 0);
        

    scl_pup : out STD_LOGIC;
    sda_pup : out STD_LOGIC;
    ck_scl : inout STD_LOGIC;
    ck_sda : inout STD_LOGIC;
    
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
    eth_ref_clk : out STD_LOGIC;
    
    op_a0 : out std_logic;
    op_a1 : out std_logic;
    op_a2 : out std_logic;
    op_wr : out std_logic;
    op_ic : out std_logic;
    op_mosi : out std_logic;
    op_sck :out std_logic;
    
    ps2_data : inout std_logic;
    ps2_clock : inout std_logic;
    
    esp_cts : in std_logic;
    esp_txd : out std_logic;
    esp_rxd : in std_logic;
    esp_rts : out std_logic
      
	);
end component;

    signal r_Clock : std_logic := '0';
    signal reset_n : std_logic := '1';

begin

  r_CLOCK <= not r_CLOCK after 5 ns; --100mhz

cpu: multicomp_wrapper 
port map (
        sys_clock   => r_clock,
        resetn     => reset_n,

    led => open,
      
      --ram
    
      ddr3_addr  => open,
      ddr3_ba   => open,
      ddr3_ras_n  => open,
      ddr3_cas_n  => open,
      ddr3_we_n   => open,
      ddr3_ck_p   => open,
      ddr3_ck_n  => open,
      ddr3_cke   => open,
      ddr3_cs_n   => open,
      ddr3_dm    => open,
      ddr3_odt   => open,
      ddr3_dq    => open,
      ddr3_dqs_p    => open,
      ddr3_dqs_n    => open,
      
      ddr3_reset_n => open,
      
      --dazzler
      
        gd_uart_txd_out => open,         -- gd uart out
        gd_gpu_sel=> open,
        gd_sd_sel => open,
        gd_daz_sel => open,
        gd_mosi => open,
        gd_miso => '0',
        gd_sclk => open,
        
         SD_CSn => open,-- #IO_L14P_T2_SRCC_35 Sch=sd_reset or DAT3
         SD_CD => '0',  --#IO_L9N_T1_DQS_AD7N_35 Sch=sd_cd
         SD_SCK => open, --
         SD_CMD => open,-- #IO_L16N_T2_35 Sch=sd_cmd
         SD_DAT0 => '0', -- #IO_L16P_T2_35 Sch=sd_dat[0]
         SD_DAT1 => open,-- #IO_L18N_T2_35 Sch=sd_dat[1]
         SD_DAT2 => open,-- #IO_L18P_T2_35 Sch=sd_dat[2]
         SD_WP => open,
        
        sw => "0000",
        

    scl_pup => open,
    sda_pup => open,
    ck_scl => open,
    ck_sda => open,
    
    eth_mdc => open,
    eth_mdio => open,
    eth_col => '0',
    eth_crs => '0',
    eth_rstn => open,
    eth_rx_clk  => '0',
    eth_rx_dv  => '0',
    eth_rxerr  => '0',
    eth_rxd => "0000",
    eth_tx_clk  => '0',
    eth_tx_en => open,
    eth_txd => open,
    eth_ref_clk => open,
    
    op_a0 => open,
    op_a1 => open,
    op_a2 => open,
    op_wr => open,
    op_ic => open,
    op_mosi => open,
    op_sck => open,
    
    ps2_data => open,
    ps2_clock => open,
    
    esp_cts  => '0',
    esp_txd => open,
    esp_rxd  => '0',
    esp_rts => open
      
	);


end Behavioral;
