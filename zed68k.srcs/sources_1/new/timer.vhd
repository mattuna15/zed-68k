library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 


entity timer is
port (clk1 : in std_logic;
      int_en : in std_logic;
      clk60hz : out std_logic; -- screen refresh
      count_up_millis : out std_logic_vector(31 downto 0) := x"00000000"
     );
end timer;

architecture Behavioral of timer is

signal count : integer :=0;
signal count_up :std_logic_vector(31 downto 0) := x"00000000";
signal count_up_millis_s : std_logic_vector(31 downto 0) := x"00000000";

signal b : std_logic :='0';
begin

 --clk generation.For 100 MHz clock this generates 100 Hz clock.
 
clk60hz<=b and int_en;
count_up_millis <= count_up_millis_s;

process(clk1) 
begin
    if(rising_edge(clk1)) then
    
        count_up <= count_up + 1;
        
        if int_en = '1' then
            count <=count+1;
        end if;
        
	    if (count_up = x"186a0") then -- trigger count every 100,000 cycles for milliseconds
	      count_up <= x"00000000";
		  count_up_millis_s <= count_up_millis_s +1;
		  if (count_up_millis_s = x"FFFFFFFF") then
		      count_up_millis_s <= x"00000000";
		  end if;
	    end if;

        if(count = 300000) then
            b <= not b;
            count <=0;
        end if;
     end if;
end process;
end;