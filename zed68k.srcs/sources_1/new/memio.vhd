----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.11.2021 11:21:59
-- Design Name: 
-- Module Name: memio - Behavioral
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

entity memio is
Port (

        cpu_clock    : in std_logic;
        cpu_reset_n : in std_logic;

        --cpu bus
        addr          : in std_logic_vector(31 downto 0); --addr
		data_out      : in std_logic_vector(15 downto 0); --cpu data out
        data_in       : out std_logic_vector(15 downto 0); -- cpu data in
		dtack         : out std_logic;  -- cpu ack
		as            : in std_logic; -- address strobe
		uds           : in std_logic; -- upper byte strobe
		lds           : in std_logic; -- lower
		rw            : in std_logic; -- read write
		
		-- memory bus
		bram_select : out std_logic;
		bram_memory_in : out std_logic_vector(15 downto 0);
		bram_memory_out : in std_logic_vector(15 downto 0);
		bram_ack : in std_logic;
		
		  --ddr
		ddr3_select : out std_logic;
		ddr3_memory_in : out std_logic_vector(15 downto 0);
		ddr3_memory_out : in std_logic_vector(15 downto 0);
		ddr3_ack : in std_logic;
		
		-- spi buses
		
		gd_select, daz_select, sd_select, opl_select : out std_logic;
		
		gd_data_in, sd_data_in, opl_data_in : out std_logic_vector(7 downto 0);
		gd_data_out, sd_data_out : in std_logic_vector(7 downto 0);
		
		-- peripherals
		
		
		-- io 
		
		
		
		-- fpu
		
		
		
 );
end memio;

architecture Behavioral of memio is

    signal boot_rom : std_logic := '1';
    signal initial_stack: std_logic_vector(31 downto 0) := x"00006000";
    signal initial_pc: std_logic_vector(31 downto 0) := x"00E00BC0";

begin

boot_proc : process (cpu_clock)
begin

    if rising_edge(cpu_clock) then
        if boot_rom = '1'  then
            
            -- setup boot details
            
            if addr = x"0000" then
                  data_in <= initial_stack(31 downto 16);
	        elsif addr = x"0002" then
	              data_in <= initial_stack(15 downto 0); 
	        elsif addr = x"0004" then
	              data_in <= initial_pc(31 downto 16);
	        elsif addr = x"0006" then
                  data_in <= initial_pc(15 downto 0);
            end if;

	           
            if addr > x"0008" then 
                boot_rom <= '0';
            elsif cpu_reset_n = '0' then
                boot_rom <= '1';
            end if;
            
            dtack <= '1'; 

        else
            data_in <= memDataOut;
            dtack <= mem_ack or mem_wr_ack;
        end if;

    end if;

end process;


end Behavioral;
