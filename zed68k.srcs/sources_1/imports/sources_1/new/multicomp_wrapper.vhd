----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/16/2020 04:43:37 PM
-- Design Name: 
-- Module Name: multicomp_wrapper - Behavioral
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
library ieee;
use ieee.std_logic_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.numeric_std.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multicomp_wrapper is
port(
        sys_clock : in STD_LOGIC;
        resetn      : in STD_LOGIC;
		videoR0		: out std_logic;
		videoG0		: out std_logic;
		videoB0		: out std_logic;
		videoR1		: out std_logic;
		videoG1		: out std_logic;
		videoB1		: out std_logic;
		hSync			: buffer std_logic;
		vSync			: buffer std_logic;

		ps2Clk		: inout std_logic;
		ps2Data		: inout std_logic;

         SD_RESET: inout std_logic; -- #IO_L14P_T2_SRCC_35 Sch=sd_reset
         SD_CD : in std_logic;  --#IO_L9N_T1_DQS_AD7N_35 Sch=sd_cd
         SD_SCK : out std_logic; --
         SD_CMD : out std_logic; -- #IO_L16N_T2_35 Sch=sd_cmd
         SD_DAT0 : in std_logic; -- #IO_L16P_T2_35 Sch=sd_dat[0]
         SD_DAT1 : inout std_logic;-- #IO_L18N_T2_35 Sch=sd_dat[1]
         SD_DAT2: inout std_logic;-- #IO_L18P_T2_35 Sch=sd_dat[2]
         SD_DAT3 : inout std_logic;--
            
--                 input reset, // Resets controller on assertion.
--input clk, // 25Mhz clock.
-- output reg cs, // Connect to SD_DAT[3].
-- output mosi, // Connect to SD_CMD.
-- input miso, // Connect to SD_DAT[0].
-- output sclk, // Connect to SD_SCK.
-- // For SPI mode, SD_DAT[2] and SD_DAT[1] should be held
--// HIGH.
-- // SD_RESET should be held LOW.

    LED : out STD_LOGIC_VECTOR ( 15 downto 0 );
    rxd1 : in STD_LOGIC;
    txd1 : out STD_LOGIC
    
	);
end multicomp_wrapper;


architecture Behavioral of multicomp_wrapper is

    signal clk50 : std_logic := '0';
    signal clk25 : std_logic := '0';
    signal start_up  : std_logic := '0';
    
    signal serialStatus: std_logic_vector(7 downto 0) := x"00"; 
    signal rxSerialData: std_logic_vector(7 downto 0) := x"00";
    signal serialData: std_logic_vector(7 downto 0) := x"00";
    signal serialIdle: std_logic := '0';
    signal serialEOF: std_logic_vector(0 downto 0) := "0";
    signal serialRead_en: std_logic := '0';
    signal rxDataReady : std_logic := '0' ;
    
    signal reset: std_logic;
    
    signal count: std_logic_vector( 7 downto 0) := x"00";
    signal data_trigger: std_logic := '0';
    
begin

   --------------------------------------------------
   -- Generate Reset
   --------------------------------------------------

   main_rst_proc : process (clk50)
   begin
        if start_up = '0' then
            reset <= '1', '0' after 25 ns;
            start_up <= '1';
        end if;
   
      if rising_edge(clk50) and start_up = '1' then
         -- Hold reset asserted for a number of clock cycles.
            reset <= not resetn;
      end if;
   end process main_rst_proc;
   
   --------------------------------------------------
   -- Instantiate Clock generation
   --------------------------------------------------

   clk_inst : entity work.clk_wiz_0_clk_wiz
   port map (
      clk_in1  => sys_clock,
      eth_clk  => clk50, 
      vga_clk  => clk25,
      main_clk => open
   ); -- clk_inst

 computer: entity work.Microcomputer 
    port map (
        
        sys_clk => sys_clock,
        n_reset	=> not reset,
		clk	=> clk50,
		vgaClock => clk25,
		cpuClock => clk25,
		videoR0	 => videoR0,
		videoG0	=> videoG0,
		videoB0	=> videoB0,
		videoR1	=> videoR1,
		videoG1	=> videoG1,
		videoB1	=> videoB1,
		hSync	=> hSync,
		vSync	=> vSync,

		ps2Clk => ps2Clk,
		ps2Data	=> ps2Data,
		
		sdCD => SD_CD,
		sdCS => SD_DAT3,
		sdMOSI => SD_CMD,
		sdMISO => SD_DAT0,
		sdSCLK => SD_SCK,
		
		serialRead_en => serialRead_en,
		serialStatus => serialStatus,
		serialData => serialData 

    );

    --only using spi do drive dat1&2 high & reset is low.
    SD_RESET <= '0';
    SD_DAT1 <= '1';
    SD_DAT2 <= '1';
    
    io_serial: entity work.design_1_wrapper
    port map (
      LED => LED(7 downto 0),
      rd_en => serialRead_en,
      m68_rxd => serialData,
      rd_clk => clk50,
      reset_n => resetn,
      rxd1 => rxd1,
      rd_data_cnt(8 downto 1) => count,
      rd_data_cnt(0) => data_trigger,
      sys_clock => sys_clock,
      cts => open,
      rts => open
    );  
    
    LED(8) <= serialRead_en;
    LED(9) <= serialStatus(0);
    LED (15 downto 10) <= (others => '0');
    serialStatus(0) <= '1' when count > x"00" else '0';
    
end Behavioral;
