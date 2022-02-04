----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.10.2021 08:59:01
-- Design Name: 
-- Module Name: timer_tb - Behavioral
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

entity timer_tb is
--  Port ( );
end timer_tb;

architecture Behavioral of timer_tb is


component timer is
port (clk1 : in std_logic;
      clk100hz : out std_logic;
      int_en : in std_logic;
      count_up_millis : buffer std_logic_vector(31 downto 0)
     );

end component;

    signal clock: std_logic := '0';

begin


    clock <= NOT clock AFTER 5ns;
    
    timer_comp:  timer 
    port map (
        clk1 => clock,
       clk100hz => open,
       int_en => '1',
        count_up_millis => open

     );


end Behavioral;
