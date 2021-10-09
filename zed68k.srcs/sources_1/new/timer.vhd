library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 


entity timer is
port (clk1 : in std_logic;
      int_en : in std_logic;
      clk100hz : out std_logic;
      count_up_millis : buffer std_logic_vector(31 downto 0) := x"00000000"
     );
end timer;

architecture Behavioral of timer is

signal count : integer :=0;
signal count_up :std_logic_vector(31 downto 0) := x"00000000";

signal b : std_logic :='0';
begin

 --clk generation.For 100 MHz clock this generates 100 Hz clock.
 
clk100hz<=b and int_en;

process(clk1) 
begin
    if(rising_edge(clk1)) then
    
        count_up <= count_up + 1;
        count <=count+1;
	    if (count_up = x"186a0") then -- trigger count every 100,000 cycles for milliseconds
	      count_up <= x"00000000";
		  count_up_millis <= count_up_millis +1;
		  if (count_up_millis = x"FFFFFFFF") then
		      count_up_millis <= x"00000000";
		  end if;
	    end if;

        if(count = 500000) then
            b <= not b;
            count <=0;
        end if;
     end if;
end process;
end;