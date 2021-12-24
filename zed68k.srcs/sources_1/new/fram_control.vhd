----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.12.2021 09:28:39
-- Design Name: 
-- Module Name: fram_control - Behavioral
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

entity fram_control is
Port (

    cpu_clock : in std_logic;
    reset : in std_logic;
    
    -- cpu interface
    
    address : in std_logic_vector(23 downto 0);
    sel : in std_logic;
    ready : out std_logic;
    valid_o : out std_logic;
    rw : in std_logic;
    data_in : in std_logic_vector(7 downto 0);
    data_out : out std_logic_vector(7 downto 0); 
    
    -- spi
    
    sck : out std_logic;
    mosi : out std_logic;
    miso : in std_logic;
    cs_n : out std_logic
 );
end fram_control;

architecture Behavioral of fram_control is


    signal state : std_logic_vector(3 downto 0);
    signal valid_i, ready_o : std_logic := '0';
    

    
      -- FRAM OPCODES 
  constant OPCODE_WREN_C  : std_logic_vector(7 downto 0) := "00000110";
  constant OPCODE_WRDI_C  : std_logic_vector(7 downto 0) := "00000100";
  constant OPCODE_RDSR_C  : std_logic_vector(7 downto 0) := "00000101";
  constant OPCODE_WRSR_C  : std_logic_vector(7 downto 0) := "00000001";
  constant OPCODE_READ_C  : std_logic_vector(7 downto 0) := "00000011";
  constant OPCODE_WRITE_C : std_logic_vector(7 downto 0) := "00000010";
  
  
  signal data_i, data_o: std_logic_vector(7 downto 0) := x"00";
  signal in_progress :std_logic :='0';
  
  signal pause_count : integer := 0;
  signal save_address : std_logic_vector(23 downto 0);
  
attribute dont_touch : string; 
attribute dont_touch of spi : label is "true";  
attribute dont_touch of rx_proc : label is "true";
attribute dont_touch of state : signal is "true";

begin

spi: entity work.spi_master 
  PORT map (
      clk_i      => cpu_clock,
      rst_i      => reset, 

      -- CPU interface
      valid_i    => valid_i,
      ready_o    => ready_o,
      data_i     => data_i,
      data_o     => data_o,

      -- Connect to SD card
      spi_sclk_o => sck,       -- sd_sck_io
      spi_mosi_o => mosi,       -- sd_cmd_io
      spi_miso_i => miso       -- sd_dat_io(0)
   );
   

rx_proc: process(cpu_clock)
begin

    if rising_edge(cpu_clock) then
    
        if reset = '1' or sel = '0' or save_address /= address then
            valid_o <= '0';
            valid_i <= '0';
            in_progress <= '0';
            state <= "0000";
        end if;
    
    
        case state is
        when "0000" => -- idle
            pause_count <= 0;
            ready <= '1';
            cs_n <= '1';
            if sel = '1' and rw = '0'  then         
                save_address <= address;
                state <= "0001";
            elsif sel = '1' and rw = '1' then          
                save_address <= address;
                state <= "0010";
            else
                valid_o <= '0';
                valid_i <= '0';
                in_progress <= '0';
            end if; 
        
        when "0001" =>


            if valid_i = '0' and ready_o= '1' and in_progress = '0' then
                cs_n <= '0';
                ready <= '0';
                data_i <= OPCODE_WREN_C;
                valid_i <= '1';
            elsif valid_i = '1' and ready_o= '0' and in_progress = '0' then
                valid_i <= '0';
                in_progress <= '1';
            elsif ready_o= '1' and valid_i = '0' and in_progress = '1' and pause_count < 3 then
                cs_n <= '1';
                pause_count <= pause_count + 1;
            elsif pause_count = 3 then
                in_progress <= '0';
                pause_count <= 0;
                state <= "0010";
            end if;
        
        when "0010" => --  

            cs_n <= '0';
            if valid_i = '0' and ready_o= '1' and rw = '0' and in_progress = '0' then
                data_i <= OPCODE_WRITE_C;
                valid_i <= '1';
            elsif valid_i = '0' and ready_o= '1' and rw = '1' and in_progress = '0' then
                data_i <= OPCODE_READ_C;
                valid_i <= '1';
            elsif valid_i = '1' and ready_o= '0' and in_progress = '0' then
                valid_i <= '0';
                in_progress <= '1';
            elsif ready_o= '1' and valid_i = '0' and in_progress = '1' then
                state <= "0011";
                in_progress <= '0';
            end if;
        
        when "0011" =>
            if valid_i = '0' and ready_o= '1' and in_progress = '0' then
                data_i <= address(23 downto 16);
                valid_i <= '1';
            elsif valid_i = '1' and ready_o= '0' and in_progress = '0' then
                valid_i <= '0';
                in_progress <= '1';
            elsif ready_o= '1' and valid_i = '0' and in_progress = '1' then
                state <= "0100";
                in_progress <= '0';
            end if;
        
        when "0100" => --  
            if valid_i = '0' and ready_o= '1' and in_progress = '0' then
                data_i <= address(15 downto 8);
                valid_i <= '1';
            elsif valid_i = '1' and ready_o= '0' and in_progress = '0' then
                valid_i <= '0';
                in_progress <= '1';
            elsif ready_o= '1' and valid_i = '0' and in_progress = '1' then
                in_progress <= '0';
                state <= "0101";
            end if;
            
        when "0101" =>
            if valid_i = '0' and ready_o= '1' and in_progress = '0' then
                data_i <= address(7 downto 0);
                valid_i <= '1';
            elsif valid_i = '1' and ready_o= '0' and in_progress = '0' then
                valid_i <= '0';
                in_progress <= '1';
            elsif ready_o= '1' and valid_i = '0' and in_progress = '1' then
                in_progress <= '0';
                state <= "0111";
            end if;
        
        when "0111" =>
        
            if valid_i = '0' and ready_o= '1' and rw = '0' and in_progress = '0' then
                data_i <= data_in;
                valid_i <= '1';
            elsif valid_i = '0' and ready_o= '1' and rw = '1' and in_progress = '0' then
                data_i <= x"FF";
                valid_i <= '1';
            elsif valid_i = '1' and ready_o= '0' and in_progress = '0' then
                valid_i <= '0';
                in_progress <= '1';
            elsif ready_o= '1' and rw = '0' and in_progress = '1' then
                state <= "1000";
                in_progress <= '0';
                cs_n <= '1';
            elsif ready_o= '1' and rw = '1' and in_progress = '1' then
                data_out <= data_o;
                valid_o <= '1';
                pause_count <= 0;
                state <= "1111";
                cs_n <= '1';
                in_progress <= '0';
            end if;
            
         when "1000" =>
            if valid_i = '0' and ready_o= '1' and in_progress = '0' then
                cs_n <= '0';
                data_i <= OPCODE_WRDI_C;
                valid_i <= '1';
            elsif valid_i = '1' and ready_o= '0' and in_progress = '0' then
                valid_i <= '0';
                in_progress <= '1' ;
            elsif ready_o= '1' and valid_i = '0' and in_progress = '1'  then
                cs_n <= '1';
                in_progress <= '0';
                valid_o <= '1';
                pause_count <= 0;
                state <= "1111";
            end if;
 
        when others =>
            valid_o <= '0'; 
            
            pause_count <= pause_count + 1;
            
            if pause_count = 3 then
                state <= "0000";
                pause_count <= 0;
            end if;
    
        end case;
        
    end if;
    
    
end process;



end Behavioral;
