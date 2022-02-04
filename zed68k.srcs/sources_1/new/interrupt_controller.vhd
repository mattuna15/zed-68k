library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

-- Simple 68K interrupt controller
-- Accepts 7 individual interrupt lines.  A high pulse of at least one clock on any of these will
-- cause an interrupt condition to be stored.
-- The int_out lines are suitable for plumbing straight into TG68 or similar.
-- Interrupts are prioritised, highest number first, and asserted until acknowledged with the
-- ack signal.
-- Higher interrupts can usurp lower interrupts
-- FIXME - stack for storing MASK value?  Or perhaps two levels of "pending" registers, so
-- that no new interrupts will be signalled until the current int has been acknowledged?


entity interrupt_controller is
	port (
		clk : in std_logic;
		reset : in std_logic;
		int1 : in std_logic;
		int2 : in std_logic;
		int3 : in std_logic;
		int4 : in std_logic;
		int5 : in std_logic;
		int6 : in std_logic;
		int7 : in std_logic;
		int_out : out std_logic_vector(2 downto 0);
		ack : in std_logic
	);
end entity;

architecture rtl of interrupt_controller is
signal pending : std_logic_vector(6 downto 0) := "0000000";
signal mask : std_logic_vector(6 downto 0) := "1111111";

    attribute dont_touch : string;
    attribute dont_touch of pending : signal is "true";
    attribute dont_touch of mask : signal is "true";
    
begin

process(clk,reset)
begin

	if reset='0' then
		pending<="0000000";
		mask<="1111111";
		int_out<="111";
	elsif rising_edge(clk) then

		if int7='1' then
			pending(6)<='1';
		end if;
		if int6='1' then
			pending(5)<='1';
		end if;
		if int5='1' then
			pending(4)<='1';
		end if;
		if int4='1' then
			pending(3)<='1';
		end if;
		if int3='1' then
			pending(2)<='1';
		end if;
		if int2='1' then
			pending(1)<='1';
		end if;
		if int1='1' then
			pending(0)<='1';
		end if;

		if ack='1' then
			pending<=pending and mask;
		else
			if pending(6)='1' then
				int_out<="000";
				mask<="0111111";
			elsif pending(5)='1' then
				int_out<="001";
				mask<="1011111";
			elsif pending(4)='1' then
				int_out<="010";
				mask<="1101111";
			elsif pending(3)='1' then
				int_out<="011";
				mask<="1110111";
			elsif pending(2)='1' then
				int_out<="100";
				mask<="1111011";
			elsif pending(1)='1' then
				int_out<="101";
				mask<="1111101";
			elsif pending(0)='1' then
				int_out<="110";
				mask<="1111110";
			else
				int_out<="111";
			end if;
		end if;
	end if;
end process;

end architecture;

