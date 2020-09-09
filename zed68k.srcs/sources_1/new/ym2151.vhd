----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.09.2020 08:32:19
-- Design Name: 
-- Module Name: ym2151 - Behavioral
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
use ieee.numeric_std_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ym2151 is
Port (
    clk100: in std_logic;
    rst_n : in std_logic;

    ym2151_CS_n : in std_logic;
    ym2151_WR_n : in std_logic;
    
    address_sel : in std_logic;
    data_in : in std_logic_vector(7 downto 0);
    data_out : out std_logic_vector(7 downto 0);
    
    audio_out : out std_logic_vector(15 downto 0);
    pwm_audio : out std_logic
 );
end ym2151;

architecture Behavioral of ym2151 is

    component audio_clock48
    port (
    -- Clock out ports  
        clk48 : out std_logic;
  -- Status and control signals               
        resetn :in std_logic; 
 -- Clock in ports
        clk_in100 : in std_logic
  );
  end component;
  
      component  audio_clock229
    port (
    -- Clock out ports  
        clk229 : out std_logic;
  -- Status and control signals               
        resetn :in std_logic; 
 -- Clock in ports
        clk_in100 : in std_logic
  );
  end component;

    signal clk48 : std_logic;
    signal clk229 : std_logic;
    signal clk3_57 : std_logic;
    signal clk1_78 : std_logic;

begin

    audioclk48:  audio_clock48
    port map (
    -- Clock out ports  
        clk48 => clk48,
  -- Status and control signals               
        resetn => rst_n,
 -- Clock in ports
        clk_in100 => clk100
  );
  
  
    audioclk229:   audio_clock229
    port map (
    -- Clock out ports  
        clk229 => clk229,
  -- Status and control signals               
        resetn => rst_n,
 -- Clock in ports
        clk_in100 => clk100
  );

    jtframe_cen3p57: entity work.jtframe_cen3p57
    port map (
        clk => clk48,       -- 48 MHz
        cen_3p57 => clk3_57,
        cen_1p78 => clk1_78   
    );

    jt51: entity work.jt51
    port map (
        clk => clk48,    -- main clock
        rst => not rst_n,    -- reset
        cen => clk3_57,    -- clock enable
        cen_p1 => clk1_78, -- clock enable at half the speed
        cs_n => ym2151_CS_n,   -- chip select
        wr_n => ym2151_WR_n,   -- write
        a0 => address_sel,
        din => data_in, -- data in
        dout => data_out, -- data out
    -- peripheral control
        ct1 => open,
        ct1 => open,
        irq_n => open,  -- I do not synchronize this signal
    -- Low resolution output (same as real chip)
        sample => open, -- marks new output sample

    -- unsigned outputs for sigma delta converters, full resolution
        dacleft => audio_out,
        dacright => open
    );

    pwmdac: entity work.pwm
    port map (
      clk_i  => clk229,
      wav_i => audio_out,
      pwm_o => pwm_audio
   );
    
end Behavioral;
