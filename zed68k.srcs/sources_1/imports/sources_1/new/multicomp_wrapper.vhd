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
use work.fun_pkg.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multicomp_wrapper is
port(
        sys_clock   : in std_logic;
        resetn      : in STD_LOGIC;

        VGA_R       : out std_logic_vector(3 downto 0);
        VGA_G       : out std_logic_vector(3 downto 0);
        VGA_B       : out std_logic_vector(3 downto 0);
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
    txd1 : out STD_LOGIC;
    cts1 : in STD_LOGIC;
    rts1 : out STD_LOGIC;
    
        rxd2 : in STD_LOGIC;
    
      ddr2_addr            : out   std_logic_vector(12 downto 0);
      ddr2_ba              : out   std_logic_vector(2 downto 0);
      ddr2_ras_n           : out   std_logic;
      ddr2_cas_n           : out   std_logic;
      ddr2_we_n            : out   std_logic;
      ddr2_ck_p            : out   std_logic_vector(0 downto 0);
      ddr2_ck_n            : out   std_logic_vector(0 downto 0);
      ddr2_cke             : out   std_logic_vector(0 downto 0);
      ddr2_cs_n            : out   std_logic_vector(0 downto 0);
      ddr2_dm              : out   std_logic_vector(1 downto 0);
      ddr2_odt             : out   std_logic_vector(0 downto 0);
      ddr2_dq              : inout std_logic_vector(15 downto 0);
      ddr2_dqs_p           : inout std_logic_vector(1 downto 0);
      ddr2_dqs_n           : inout std_logic_vector(1 downto 0)
    
	);
end multicomp_wrapper;


architecture Behavioral of multicomp_wrapper is

function reverse_any_vector (a: in std_logic_vector)
return std_logic_vector is
  variable result: std_logic_vector(a'RANGE);
  alias aa: std_logic_vector(a'REVERSE_RANGE) is a;
begin
  for i in aa'RANGE loop
    result(i) := aa(i);
  end loop;
  return result;
end; -- function reverse_any_vector

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
      
          
            -- vga
      signal vga_irq               :    std_logic;
      signal vga_addr              :    std_logic_vector(15 downto 0);
      signal vga_wr_en             :    std_logic;
      signal vga_rd_en             :    std_logic;
      signal vga_wr_data           :    std_logic_vector(7 downto 0);
      signal vga_rd_data           :    std_logic_vector(7 downto 0);

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
   -- Instantiate Clock generation
   --------------------------------------------------
       
    pll1:  pll
    port map (
        clk_in => sys_clock,
        resetn  => resetn,
        locked => clk_locked,
        clk100 => sys_clock100,
        clk200 => mem_clock,
        clk50 =>  clk50,
        clk25 => clk25
    );

        memory_control: entity work.mem_control 
        Port map (

        mem_clock => mem_clock, 
        resetn => resetn,
        clk_locked => clk_locked, 
        sys_clock => sys_clock100,
    
    -- ram
    cpuAddress => cpuAddress,
    cpuDataOut   => cpuDataOut,
    ramDataOut => cpuDataIn,
    mem_cen => cpuCS ,
    mem_oen => cpuReadEn,
    mem_wen => cpuWriteEn, -- chip enables
    mem_ubs => cpuUpper,
    mem_lbs => cpuLower,
    mem_data_valid => ram_ack,
    mem_ready => mem_ready,
    
    -- DDR2 interface

      ddr2_addr            => ddr2_addr,
      ddr2_ba              => ddr2_ba,
      ddr2_ras_n           => ddr2_ras_n,
      ddr2_cas_n           => ddr2_cas_n,
      ddr2_we_n            => ddr2_we_n,
      ddr2_ck_p            => ddr2_ck_p,
      ddr2_ck_n            => ddr2_ck_n,
      ddr2_cke             => ddr2_cke,
      ddr2_cs_n            => ddr2_cs_n,
      ddr2_dm              => ddr2_dm,
      ddr2_dq             => ddr2_dq,
      ddr2_odt             => ddr2_odt,
      ddr2_dqs_p           => ddr2_dqs_p,
      ddr2_dqs_n           => ddr2_dqs_n

 );

    reset_proc : process
    begin
    
        if resetn = '1' and mem_ready = '1' and clk_locked = '1' then 
            sys_resetn <= '1'; 
        else 
            sys_resetn <= '0';
        end if;
        
        wait for 3us;
        
    end process;
 
 computer: entity work.Microcomputer 
    port map (
        
        sys_clk => sys_clock100,
        n_reset	=> sys_resetn,
        clk50 => clk50,
		
		sdCD => SD_CD,
		sdCS => SD_DAT3,
		sdMOSI => SD_CMD,
		sdMISO => SD_DAT0,
		sdSCLK => SD_SCK,
		
		serialRead_en => serialRead_en,
		serialStatus => serialStatus,
		serialData => serialData,
		
		                  -- RAM interface
      ram_a                => cpuAddress,
      ram_dq_i             => cpuDataOut(15 downto 0),
      ram_dq_o             => cpuDataIn(15 downto 0),
      ram_cen              => cpuCS,
      ram_oen              => cpuReadEn,
      ram_wen              => cpuWriteEn,
      ram_ub               => cpuUpper,
      ram_lb               => cpuLower,
      ram_ack              => ram_ack,
      
      cpu_as                => cpuAS,
      
      rxd1 => rxd1,
      txd1 => txd1,
      cts1 => cts1,
      rts1 => rts1,
      serialClock => serialClock,
      
        vga_addr => vga_addr,
        vga_wr_en =>  vga_wr_en,
        vga_rd_en => vga_rd_en,
        vga_wr_data => vga_wr_data,
        vga_rd_data => vga_rd_data
       -- vga_irq => vga_irq

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
      rd_clk => sys_clock100,
      reset_n => resetn and mem_ready and clk_locked,
      rxd1 => rxd2,
      rd_data_cnt(8 downto 1) => count,
      rd_data_cnt(0) => data_trigger,
      clk100_i => sys_clock100,
      cts => open,
      rts => open
    );  

vga: entity work.gameduino_main
    port map (
      vga_clk => clk50, -- Twice the frequency of the original clka board clock
      vga_red => VGA_R(3 downto 1),
      vga_green => VGA_G(3 downto 1),
      vga_blue => VGA_B(3 downto 1),
      vga_hsync => hSync,
      vga_vsync => vSync,
      vga_active => open,
      --coll_rd => vga_irq,
    
      mem_clk => sys_clock100, -- Should probably be same as vga_clk
      host_mem_wr => vga_wr_en,             -- set to zero if not used
      host_mem_w_addr => vga_addr(14 downto 0),  -- set to zero if not used
      host_mem_data_wr => vga_wr_data,  -- set to zero if not used
      host_mem_rd => vga_rd_en,            -- set to zero if not used
      host_mem_r_addr => vga_addr(14 downto 0),  -- set to zero if not used
      host_mem_data_rd => vga_rd_data,
    
      AUX_in => std_logic_vector(to_unsigned(0, 1)), -- set to zero if not used
      AUX_out => open,
      AUX_tristate => open,
    
      AUDIOL => open,
      AUDIOR => open,
    
      pin2f => open,
      pin2j => open,
      j1_flashMOSI  => open,
      j1_flashSCK  => open,
      j1_flashSSEL  => open,
      flashMISO => std_logic_vector(to_unsigned(0, 1))
  );
    
    LED(10) <= mem_ready;
    serialStatus(0) <= '1' when count > x"00" else '0';

    -- SUB-CIRCUIT CLOCK SIGNALS
    serialClock <= serialClkCount(15);
    process (clk50)
    begin
        if rising_edge(clk50) then
        
        
        -- Serial clock DDS
        -- 50MHz master input clock:
        -- Baud Increment
        -- 115200 2416
        -- 38400 805
        -- 19200 403
        -- 9600 201
        -- 4800 101
        -- 2400 50
            serialClkCount <= serialClkCount + 201;
        end if;
    end process;
    
end Behavioral;