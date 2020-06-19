----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/19/2020 10:50:29 AM
-- Design Name: 
-- Module Name: cpu68k_tb - Behavioral
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

entity cpu68k_tb is
--  Port ( );
end cpu68k_tb;

architecture Behavioral of cpu68k_tb is

   -- Clock
   signal clk  : std_logic;
   signal reset : std_logic := '1' ;
   signal start_up  : std_logic := '0';
   
   -- cpu data 
   signal cpu_datain : std_logic_vector(15 downto 0);	-- Data provided by us to CPU
   signal cpu_dataout : std_logic_vector(15 downto 0) := "0000000000000000"; -- Data received from the CPU
   signal cpu_addr : std_logic_vector(31 downto 0); -- CPU's current address
   signal cpu_as : std_logic; -- Address strobe
   signal cpu_uds : std_logic; -- upper data strobe
   signal cpu_lds : std_logic; -- lower data strobe
   signal cpu_r_w : std_logic; -- read(high)/write(low)
   signal cpu_dtack : std_logic := '0'; -- data transfer acknowledge
   
   -- counter
   
   signal counter : std_logic_vector(15 downto 0) := "0000000000000000";

begin

   reset_proc : process
   begin
   
    if start_up = '0' then
        reset <= '0', '1' after 10 ns;
        start_up <= '1';
    end if;
    wait for 1 ns;
   end process reset_proc;
   --------------------------------------------------
   -- Generate clock
   --------------------------------------------------

   -- Generate clock
   main_clk_proc : process
   begin
      clk <= '1', '0' after 5 ns; -- 100 MHz
      wait for 10 ns;
   end process main_clk_proc;
    
   myTG68 : entity work.TG68
   port map
	(
		clk => clk,
      reset => reset,
      clkena_in => '1',
      data_in => cpu_datain,
		IPL => "111",	-- For this simple demo we'll ignore interrupts
		dtack => cpu_dtack,
		addr => cpu_addr,
		as => cpu_as,
		data_out => cpu_dataout,
		rw => cpu_r_w,
		uds => cpu_uds,
		lds => cpu_lds
   );




-- Test program: 
--		0x5240 (loop: addq.w #1,d0)
--		0x33c0 (move.w d0,$dff180)
--		0x00DF 0xF180
--		0x60f6 (bra.s loop)

-- Address decoding
rom_test: process(clk,cpu_addr)
begin
	if rising_edge(clk) then
		if cpu_as='0' then	-- The CPU has asserted Address Strobe, so decode the address...
			case cpu_addr(23 downto 0) is
				-- We have a simple program encoded into five words here...
				when X"000006" =>
					cpu_datain <= X"0008"; -- Initial program counter.  Initial stack pointer and high word of PC are zero.
					cpu_dtack<='0';	
				when X"000008" =>
					cpu_datain <= X"5240";  -- start: addq.w #1,d0
					cpu_dtack<='0';	
				when X"00000A" =>
					cpu_datain <= X"33c0";  -- move.w d0...
					cpu_dtack<='0';
				when X"00000C" =>
					cpu_datain <= X"00DF";  -- ...
					cpu_dtack<='0';	
				when X"00000E" =>
					cpu_datain <= X"F180";  -- ...,$dff180
					cpu_dtack<='0';	
				when X"000010" =>
					cpu_datain <= X"60f6";  -- bra.s start
					cpu_dtack<='0';

				-- Now a simple hardware register at 0xdff180, written to by the program:
				when X"dff180" =>
					if cpu_r_w='0' and cpu_uds='0' and cpu_lds='0' then	-- write cycle to the complete word...
						counter<=cpu_dataout;
						cpu_dtack<='0';
					end if;

				-- For any other address we simply return zero.
				when others =>
					cpu_datain <= X"0000";
					cpu_dtack<='0';
			end case;
		end if;

		-- When the CPU releases Data Strobe we release dtack.
		-- (No real need to do this, provided everything responds in a single cycle.  DTACK Grounded!)
		if cpu_uds='1' and cpu_lds='1' then
			cpu_dtack<='1';
		end if;
	end if;
end process;




end Behavioral;
