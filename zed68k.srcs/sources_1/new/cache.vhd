----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2021 11:34:23
-- Design Name: 
-- Module Name: cache - Behavioral
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

entity cache is
    Port ( 
    clock : in std_logic;
    address: in std_logic_vector(23 downto 0);   -- // Address bus (Upper part not used)

    wr_byte_mask : in std_logic_vector(1 downto 0);
    i_valid : in std_logic;
    i_wren : in std_logic;  --     // Write enable
    wr_data : in std_logic_vector(15 downto 0); --     // Data to write
    rd_data : out std_logic_vector(15 downto 0); --     // Data to read
    hit : out std_logic;
    complete : out std_logic
    
    );
end cache;

architecture Behavioral of cache is


component ram is
   generic (
      -- Number of bits in the address bus. The size of the memory will
      -- be 2**G_ADDR_BITS bytes.
      G_ADDR_BITS : integer;
      G_DATA_LEN : integer
   );
   port (
      clk_i  : in  std_logic;

      -- Current address selected.
      addr_i : in  std_logic_vector(G_ADDR_BITS-1 downto 0);

      -- Data contents at the selected address.
      -- Valid in same clock cycle.
      data_o : out std_logic_vector(G_DATA_LEN-1 downto 0);

      -- New data to (optionally) be written to the selected address.
      data_i : in  std_logic_vector(G_DATA_LEN-1 downto 0);

      bytemask_i : in std_logic_vector(1 downto 0);
      -- '1' indicates we wish to perform a write at the selected address.
      wren_i : in  std_logic
   );
end component;


    signal cache_state: std_logic_vector(3 downto 0);
    signal data_wren : std_logic := '0';
    signal tag_wren :std_logic := '0';
    
    signal tag_address : std_logic_vector(11 downto 0) := (others => '0');
    signal cpu_address, rd_address, wr_address : std_logic_vector(23 downto 0) := (others => '0');
    
    signal cache_data : std_logic_vector(15 downto 0);

begin

    tag_address <= address(11 downto 0);
    cpu_address <= address;
    
    rd_data <= cache_data;

    data_cache: ram
    generic map (
      G_ADDR_BITS => 12,
      G_DATA_LEN => 16
    )
    port map (
      clk_i => clock,
      -- Current address selected. 
        addr_i => tag_address,

      -- Data contents at the selected address.
      -- Valid in same clock cycle.
        data_o => cache_data,

      -- New data to (optionally) be written to the selected address.
      data_i => wr_data,

      bytemask_i => wr_byte_mask,
      -- '1' indicates we wish to perform a write at the selected address.
      wren_i => data_wren
    );
    
    
    tag_cache: ram
    generic map (
      G_ADDR_BITS => 12,
      G_DATA_LEN => 24
    )
    port map (
      clk_i => clock,
      -- Current address selected. 
        addr_i => tag_address,

      -- Data contents at the selected address.
      -- Valid in same clock cycle.
        data_o => rd_address,

      -- New data to (optionally) be written to the selected address.
        data_i => wr_address,

        bytemask_i => "11",
      -- '1' indicates we wish to perform a write at the selected address.
        wren_i => tag_wren
    );

cache_proc: process (clock)
begin
    
    
    case cache_state is
        when "0000" => -- idle
        
        hit <= '0';
        complete <= '0';
        
        if i_valid = '1' then
            cache_state <= "0001";
        end if;
        
        when "0001" => -- check
        
            if cpu_address = rd_address and i_wren = '0' then
                cache_state <= "0111"; -- read hit
            elsif cpu_address /= rd_address and i_wren = '0' then
                cache_state <= "0010"; -- read miss
            elsif cpu_address = rd_address and i_wren = '1' and wr_data = cache_data then
                cache_state <= "1000"; -- write hit
            elsif cpu_address /= rd_address and i_wren = '1' and wr_data /= cache_data then
                cache_state <= "0011"; -- write miss
            end if;
        
        when "0010" => -- read miss
            cache_state <= "1001";
        when "0011" => -- write miss
            wr_address <= cpu_address;
            tag_wren <= '1';
            data_wren <= '1';
            cache_state <= "1001";
        when "0111" => -- read hit
            hit <= '1';
            cache_state <= "1001";
        
        when "1000" => -- write hit';
            cache_state <= "1001";
        
        when "1001" => -- complete
            complete <= '1';
            cache_state <= "1111";
            
        when others =>     -- others
            tag_wren <= '0';
            data_wren <= '0';
            cache_state <= "0000";
        end case;
        
        
end process;
        
end Behavioral;
