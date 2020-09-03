----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.09.2020 21:24:29
-- Design Name: 
-- Module Name: audio_tb - Behavioral
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

entity audio_tb is
--  Port ( );
end audio_tb;

architecture Behavioral of audio_tb is

 -- Clock
   signal main_clk  : std_logic;
   signal resetn : std_logic := '0' ;

   signal LED : STD_LOGIC_VECTOR ( 15 downto 0 );

   signal qspi_flash_io0_io :  STD_LOGIC;
   signal qspi_flash_io1_io :  STD_LOGIC;
   signal qspi_flash_io2_io :  STD_LOGIC;
   signal qspi_flash_io3_io :  STD_LOGIC;
    signal qspi_flash_ss_io :  STD_LOGIC;
    signal usb_uart_rxd :  STD_LOGIC := '0';
    signal usb_uart_txd :  STD_LOGIC;
    signal ddr2_addr            :    std_logic_vector(12 downto 0);
    signal  ddr2_ba              :    std_logic_vector(2 downto 0);
    signal  ddr2_ras_n           :    std_logic;
    signal  ddr2_cas_n           :    std_logic;
    signal  ddr2_we_n            :    std_logic;
    signal  ddr2_ck_p            :    std_logic_vector(0 downto 0);
    signal  ddr2_ck_n            :    std_logic_vector(0 downto 0);
    signal  ddr2_cke             :    std_logic_vector(0 downto 0);
    signal  ddr2_cs_n            :    std_logic_vector(0 downto 0);
    signal  ddr2_dm              :    std_logic_vector(1 downto 0);
    signal  ddr2_odt             :    std_logic_vector(0 downto 0);
    signal  ddr2_dq              :  std_logic_vector(15 downto 0);
    signal  ddr2_dqs_p           :  std_logic_vector(1 downto 0);
    signal  ddr2_dqs_n           :  std_logic_vector(1 downto 0);
    signal ddr2_rdqs_n           :  std_logic_vector(1 downto 0);
    
      signal clk50 : std_logic := '0';
    signal clk25 : std_logic := '0';
    signal start_up  : std_logic := '0';
    
    signal serialStatus: std_logic_vector(7 downto 0) := x"00"; 
    signal rxSerialData: std_logic_vector(7 downto 0) := x"00";
    signal serialData: std_logic_vector(7 downto 0) := x"00";
    signal serialRead_en: std_logic := '0';
    signal rxDataReady : std_logic := '0' ;
    
    signal reset: std_logic := '1' ;
    
    signal count: std_logic_vector( 7 downto 0) := x"00";
    signal data_trigger: std_logic := '0';
    signal clk_locked: std_logic := '0';
    signal serialClkCount			: std_logic_vector(15 downto 0) := (others => '0');
    signal serialClock   			: std_logic;

    
          -- RAM interface

        signal mem_clock: std_logic := '0';
        signal ram_access_delay: integer := 0;
        signal ram_ack: std_logic := '1';
        
      signal cpuAddress                :    std_logic_vector(26 downto 0) := (others => '0');
      signal oldAddress                :    std_logic_vector(26 downto 0) := (others => '0');
      signal cpuDataOut             :     std_logic_vector(15 downto 0) := (others => '0');
      signal cpuDataIn             :    std_logic_vector(15 downto 0) := (others => '0');
      signal cpuCS              :    std_logic;
      signal cpuAS      : std_logic; -- address steobe
      signal cpuReadEn              :     std_logic;
      signal cpuWriteEn              :     std_logic;
      signal cpuUpper               :     std_logic;
      signal cpuLower               :     std_logic;
      signal mem_ready              :     std_logic := '0';
      
      signal sys_resetn : std_logic;
      signal sys_clock100 : STD_LOGIC;
      
      signal data_width : std_logic_vector(1 downto 0) := "10";
      
            --audio 
      signal audio_data_wr         : std_logic_vector(15 downto 0);
      signal audio_wr_ack          : std_logic;
      signal AUD_PWM              : std_logic;
      signal AUD_SD               : std_logic;
    
    signal start : std_logic := '0';
    
        component pll
    port ( 
        resetn  : in std_logic;
        clk_in : in std_logic;
        locked : out std_logic;
        clk100  : out std_logic;
        clk200  : out std_logic;
        clk50  : out std_logic;
        clk25  : out std_logic
    );
    end component;
    

begin

   --------------------------------------------------
   -- Generate clock
   --------------------------------------------------

   -- Generate clock
   main_clk_proc : process
   begin
      main_clk <= '1', '0' after 5 ns; -- 100 MHz
      
      if start = '0' then
        resetn <= '0', '1' after 25ns;
        start <= '1';
      end if;
      
      wait for 10 ns;
   end process main_clk_proc;
   
    pll1:  pll
    port map (
        clk_in => main_clk,
        resetn  => resetn,
        locked => clk_locked,
        clk100 => sys_clock100,
        clk200 => mem_clock,
        clk50 =>  clk50,
        clk25 => clk25
    );

  audio : entity work.ym2151_top 
   port map (
      sys_clk_i  => sys_clock100,    -- 100 MHz
      sys_rstn_i => sys_resetn,
      m68k_data_i => audio_data_wr,  -- register - data
      audio_wr_ack => audio_wr_ack,
      aud_pwm_o  => AUD_PWM,
      aud_sd_o   => AUD_SD
   );
   
   



end Behavioral;
