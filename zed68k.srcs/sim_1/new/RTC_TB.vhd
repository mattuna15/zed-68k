----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.04.2021 16:47:10
-- Design Name: 
-- Module Name: RTC_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std_unsigned.all;
use std.env.finish;

entity RTC_TB is
end RTC_TB;

architecture structural of RTC_TB is

   -- Clock
   signal main_clk  : std_logic;
   signal resetn : std_logic := '0' ;
   signal start : std_logic := '0';
       
       
   signal scl : std_logic;
   signal sda : std_logic;
   
   signal osc32k : std_logic := '0';
   
    component MCP79410 
    port  (
    X1 : in std_logic;
    X2 : out std_logic; 
    MFP : out std_logic; 
    SDA : inout std_logic;
    SCL : inout std_logic; 
    VCC : in std_logic; 
    VBAT : in std_logic;
    RESET : in std_logic
    );
    end component;
    
    signal wr_ack : std_logic;
    signal valid_o : std_logic; 
    signal set_clock : std_logic := '1';
    signal read_en : std_logic := '0';
       
 BEGIN  
 
    sda <= 'H';
    scl <= 'H';
    
    
      -- Generate clock
   main_clk_proc : process
   begin
      main_clk <= '1', '0' after 5 ns; -- 100 MHz
      
      if start = '0' then
        resetn <= '0', '1' after 10us;
        start <= '1';
      end if;
      
      wait for 10 ns;
   end process main_clk_proc;
   
   osc: process
   begin
        osc32k <= '1', '0' after 15258800 ps;
      
        wait for 30517600 ps;
   end process;
   
   wr: process
   begin
   
        wait until wr_ack = '1';
        set_clock <= '0';
        
        wait until wr_ack = '0';
        read_en <='1';
        
        wait until valid_o = '1';
        wait until valid_o = '1';
        wait until valid_o = '1';
        
        wait until valid_o = '1';
        wait until valid_o = '1';
        wait until valid_o = '1';
        
        finish;
        
   end process;
   
   rtc : ENTITY work.pmod_real_time_clock 
  GENERIC map (
    sys_clk_freq => 100_000_000)              --input clock speed from user logic in Hz
  PORT map (
    clk           => main_clk,                    --system clock
    reset_n      => resetn,                     --asynchronous active-low reset also only when we need it.
    scl           => scl,                     --I2C serial clock
    sda          => sda,                --I2C serial data
    read_en      => read_en,
    i2c_ack_err   => open,                     --I2C slave acknowledge error flag
    set_clk_ena   => set_clock,                    --set clock enable
    set_seconds   => "0000001",  --seconds to set clock to
    set_minutes   => "0000010",   --minutes to set clock to
    set_hours     => "00010",   --hours to set clock to
    set_am_pm     => '1',                  --am/pm to set clock to, am = '0', pm = '1'
    set_weekday   => (others => '0'),  --weekday to set clock to
    set_day       => (others => '0'),   --day of month to set clock to
    set_month     => (others => '0'),  --month to set clock to
    set_year      => (others => '0'),   --year to set clock to
    set_leapyear  => '0',                      --specify if setting is a leapyear ('1') or not ('0')
    seconds       => open,  --clock output time: seconds
    minutes       => open,  --clock output time: minutes
    hours         => open,  --clock output time: hours
    am_pm         => open,                    --clock output time: am/pm (am = '0', pm = '1')
    weekday       => open,  --clock output time: weekday
    day           => open,  --clock output time: day of month
    month         => open,  --clock output time: month
    year          => open, --clock output time: year
    valid_o       => valid_o,
    wr_ack        => wr_ack
    );
   
   
    fake_rtc : MCP79410 
    port map (
    X1 => osc32k,
    X2 => open, 
    MFP => open, 
    SDA => sda, 
    SCL => scl, 
    VCC => '1', 
    VBAT => '0', 
    RESET => not resetn
    );
    
    
end structural;
