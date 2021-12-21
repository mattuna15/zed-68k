----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2021 15:15:10
-- Design Name: 
-- Module Name: cache_tb - Behavioral
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

entity cache_tb is
--  Port ( );
end cache_tb;

architecture Behavioral of cache_tb is

component cache is
    Port ( 
    clock : in std_logic;
    address: in std_logic_vector(27 downto 0);   -- // Address bus (Upper part not used)

    wr_byte_mask : in std_logic_vector(1 downto 0);
    i_valid : in std_logic;
    i_wren : in std_logic;  --     // Write enable
    wr_data : in std_logic_vector(15 downto 0); --     // Data to write
    rd_data : out std_logic_vector(15 downto 0); --     // Data to read
    hit : out std_logic;
    complete : out std_logic
    
    );
end component;

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
      data_o : out std_logic_vector(15 downto 0);

      -- New data to (optionally) be written to the selected address.
      data_i : in  std_logic_vector(15 downto 0);

      bytemask_i : in std_logic_vector(1 downto 0);
      -- '1' indicates we wish to perform a write at the selected address.
      wren_i : in  std_logic
   );
end component;

    signal r_Clock, wren, valid, hit, complete : std_logic := '0';
    signal address : std_logic_vector(23 downto 0);
    signal main_rd_data : std_logic_vector(15 downto 0);
    signal main_wr_data : std_logic_vector(15 downto 0);
    
    signal byte_mask : std_logic_vector(1 downto 0);
    
begin

  r_CLOCK <= not r_CLOCK after 5 ns; --100mhz

main_ram: ram
    generic map (
      G_ADDR_BITS => 8,
      G_DATA_LEN => 16
    )
    port map (
      clk_i => r_Clock,
      -- Current address selected. 
        addr_i => address(7 downto 0),

      -- Data contents at the selected address.
      -- Valid in same clock cycle.
        data_o => main_rd_data,

      -- New data to (optionally) be written to the selected address.
      data_i => main_wr_data,

      bytemask_i => byte_mask,
      -- '1' indicates we wish to perform a write at the selected address.
      wren_i => wren 
    );
    
    cache_ram : cache 
    Port map ( 
    clock => r_clock,
    address(27) => '0',  -- // Address bus (Upper part not used)
    address(26 downto 4) => address(23 downto 1), --ignore last digit. always 0
    address(3 downto 0) => "0000",   -- // Address bus (Upper part not used
    wr_byte_mask => byte_mask,
    i_valid => valid,
    i_wren => wren, --     // Write enable
    wr_data => main_wr_data, --     // Data to write
    rd_data => main_rd_data,--     // Data to read
    hit => hit,
    complete => complete
    
    );
    
    test: process 
    begin
    
    wait for 200ns;
    
    address <= x"000002";
    byte_mask <= "11";
    main_wr_data <= x"0102";
    wren <= '1';
    valid <= '1';
    wait for 20ns;
    valid <= '0';
        wren <= '0';
    wait until complete = '1';
    
        wait for 10ns;                              
                              
    address <= x"000004";     
    byte_mask <= "11";        
    main_wr_data <= x"0304";  
    wren <= '1';              
    valid <= '1';             
    wait for 20ns;            
    valid <= '0';   
            wren <= '0';          
                              
    wait until complete = '1';    
    
        wait for 10ns;
     
    address <= x"000002";
    wren <= '0';
    valid <= '1';
    wait for 20ns;
    valid <= '0';
    
    wait until complete = '1';
    
           wait for 10ns;                           
                              
    address <= x"000004";        
    wren <= '0';              
    valid <= '1';             
    wait for 20ns;            
    valid <= '0';             
                              
    wait until complete = '1';    
    
    
    
    end process;


end Behavioral;
