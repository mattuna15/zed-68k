----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.08.2020 14:53:14
-- Design Name: 
-- Module Name: mem_control - Behavioral
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
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.numeric_std.all;
use work.fun_pkg.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mem_control is
Port (

    mem_clock, resetn, clk_locked, sys_clock : in std_logic; --clocks
    
    -- ram
    cpuAddress : in std_logic_vector(26 downto 0);
    cpuDataOut   : in std_logic_vector(15 downto 0);
    mem_cen, mem_oen,  mem_wen, mem_ubs, mem_lbs : in std_logic; -- chip enables
    mem_data_valid : out std_logic; 
    mem_ready : out  std_logic; 
    ramDataOut :  out std_logic_vector(15 downto 0);
    -- ddr
    
    ddr2_addr            : out   std_logic_vector(12 downto 0);
      ddr2_ba              : out   std_logic_vector(2 downto 0);
      ddr2_ras_n           : out   std_logic;
      ddr2_cas_n           : out   std_logic;
      ddr2_we_n            : out   std_logic;
      ddr2_ck_p            : out   std_logic_vector(0 downto 0);
      ddr2_ck_n            : out   std_logic_vector(0 downto 0);
      ddr2_cke             : out   std_logic_vector(0 downto 0);
      ddr2_cs_n            : out   std_logic_vector(0 downto 0);
      ddr2_dm              : out   std_logic_vector(1 downto 0);
      ddr2_odt             : out   std_logic_vector(0 downto 0);
      ddr2_dq              : inout std_logic_vector(15 downto 0);
      ddr2_dqs_p           : inout std_logic_vector(1 downto 0);
      ddr2_dqs_n           : inout std_logic_vector(1 downto 0)

 );
end mem_control;

architecture Behavioral of mem_control is

component mem_example
   port  (
      -- Common
      clk_mem        : std_logic; -- 200 MHz system clock
      CPU_RESETN     : std_logic;
      
      -- RAM interface


      cpu_clk              : std_logic;
      addr                 :std_logic_vector(27 downto 0);
      data_in               : std_logic_vector(63 downto 0);

      data_out              : std_logic_vector(63 downto 0);
      width                : std_logic_vector(1 downto 0);
      rstrobe              : std_logic;
      wstrobe             : std_logic;
      transaction_complete : std_logic;
      ready               : std_logic;
      init_calib_complete : std_logic;
      
-- ddr
    
      ddr2_addr            : out   std_logic_vector(12 downto 0);
      ddr2_ba              : out   std_logic_vector(2 downto 0);
      ddr2_ras_n           : out   std_logic;
      ddr2_cas_n           : out   std_logic;
      ddr2_we_n            : out   std_logic;
      ddr2_ck_p            : out   std_logic_vector(0 downto 0);
      ddr2_ck_n            : out   std_logic_vector(0 downto 0);
      ddr2_cke             : out   std_logic_vector(0 downto 0);
      ddr2_cs_n            : out   std_logic_vector(0 downto 0);
      ddr2_dm              : out   std_logic_vector(1 downto 0);
      ddr2_odt             : out   std_logic_vector(0 downto 0);
      ddr2_dq              : inout std_logic_vector(15 downto 0);
      ddr2_dqs_p           : inout std_logic_vector(1 downto 0);
      ddr2_dqs_n           : inout std_logic_vector(1 downto 0)
      
   );
   
end component;

signal boot_rom : std_logic := '0';
signal oldAddress : std_logic_vector(26 downto 0) := (others => '0');

      signal initial_stack: std_logic_vector(31 downto 0) := x"00000E00";
      signal initial_pc: std_logic_vector(31 downto 0) := x"00A00BB4";
      signal sys_resetn : std_logic := '0'; --reset cpu system
      signal first_read_rcvd : std_logic := '0'; --workaround?
      
      -- Memory FSM
    type state_type is (stIdle, stAddressPending, stReadPending, stWritePending, stDataReady, 
                            stComplete);  
    signal cState, nState : state_type := stIdle;
    
    signal mem_cen_int, mem_oen_int, mem_wen_int : std_logic := '1'; --active low
    signal mem_data_ready, mem_write_complete: std_logic;   
    signal mem_data_out : std_logic_vector(63 downto 0);
    

    signal cache_write_ack, cache_write_en, cache_read_en : std_logic := '0';
    signal mem_busy: std_logic;
    signal cache_data_out, saveData: std_logic_vector(15 downto 0);
    signal cache_addr_out, read_address: std_logic_vector(26 downto 0);
    signal cache_data_in: std_logic_vector(15 downto 0);
    signal cache_addr_in: std_logic_vector(26 downto 0);
    signal cache_data_count: std_logic_vector(8 downto 0);
    
    signal cache_upper_in, cache_lower_in, cache_lower_out, cache_upper_out : std_logic_vector(0 downto 0);
    
    signal data_width : std_logic_vector(1 downto 0);
begin

ext_ram: entity work.mem_example 
   port map (
      -- Common
      clk_mem         => mem_clock, -- 200 MHz system clock
      CPU_RESETN           => resetn, 
      
      -- RAM interface


      cpu_clk              => sys_clock,
      write_addr(27 downto 27)   => std_logic_vector(to_unsigned(0, 1)),
      write_addr(26 downto 0) => cache_addr_out,
      read_addr(27 downto 27)   => std_logic_vector(to_unsigned(0, 1)),
      read_addr(26 downto 0) => read_address,
      data_in(63 downto 16) => std_logic_vector(to_unsigned(0, 48)),
      data_in(15 downto 0)   => cache_data_out,
      data_out => mem_data_out,
      width                 => std_logic_vector(to_unsigned(2, 2)), -- 16-bit
      mem_upper            => cache_upper_out,
      mem_lower            => cache_lower_out,
      rd_mem_upper            => mem_ubs,
      rd_mem_lower            => mem_lbs,
      rstrobe              => not mem_oen and not boot_rom and (not mem_ubs or not mem_lbs), 
      wstrobe              => cache_read_en,
      read_transaction_complete => mem_data_ready,
      write_transaction_complete => open,
      init_calib_complete  => mem_ready,
      mem_busy => mem_busy,
      
      -- DDR2 interface

      ddr2_addr            => ddr2_addr,
      ddr2_ba              => ddr2_ba,
      ddr2_ras_n           => ddr2_ras_n,
      ddr2_cas_n           => ddr2_cas_n,
      ddr2_we_n            => ddr2_we_n,
      ddr2_ck_p            => ddr2_ck_p,
      ddr2_ck_n            => ddr2_ck_n,
      ddr2_cke             => ddr2_cke,
      ddr2_cs_n            => ddr2_cs_n,
      ddr2_dm              => ddr2_dm,
      ddr2_dq             => ddr2_dq,
      ddr2_odt             => ddr2_odt,
      ddr2_dqs_p           => ddr2_dqs_p,
      ddr2_dqs_n           => ddr2_dqs_n
      
   );
   
   write_fifo_i: entity work.write_fifo_wrapper
     port map (
      clk => sys_clock,
      din(15 downto 0) => cache_data_in,
      din(42 downto 16) => cache_addr_in,
      din(43 downto 43) => cache_lower_in,
      din(44 downto 44) => cache_upper_in,
      dout(15 downto 0) => cache_data_out,
      dout(42 downto 16) => cache_addr_out,
      dout(43 downto 43) => cache_lower_out,
      dout(44 downto 44) => cache_upper_out,
      data_count => cache_data_count,
      wr_en => cache_write_en,
      rd_en => cache_read_en, --cache_read_en,
      rst => not resetn or not mem_ready,
      wr_ack => cache_write_ack
    );

    mem_state: process (sys_clock)
    begin
    
    if rising_edge(sys_clock) then
    
        if cache_data_count > x"00" and mem_busy = '0' then
            cache_read_en <= '1';
        else 
            cache_read_en <= '0';
        end if;
    
        if boot_rom = '1'  then
            --oldAddress <= cpuAddress;
            mem_data_valid <= '1';
            mem_cen_int <= '1';
            mem_oen_int <= '1';
            mem_wen_int <= '1';
            cache_write_en <= '0';
            cache_read_en <= '0';
            
            -- setup boot details
            
            if cpuAddress = x"0000" then
                  ramDataOut <= initial_stack(31 downto 16);
	        elsif cpuAddress = x"0002" then
	              ramDataOut <= initial_stack(15 downto 0); 
	        elsif cpuAddress = x"0004" then
	              ramDataOut <= initial_pc(31 downto 16);
	        elsif cpuAddress = x"0006" then
                  ramDataOut <= initial_pc(15 downto 0);
            end if;

	           
            if cpuAddress > x"0008" then 
                boot_rom <= '0';
            elsif resetn = '0' then
                boot_rom <= '1';
            end if;
            
        else 
        
            -- DDR State machine
            case nState is
            when stIdle =>
                cState <= nState;  
                mem_cen_int <= '1';
                mem_oen_int <= '1';
                mem_wen_int <= '1';
                mem_data_valid <= '0';
                
                if (cpuAddress /= oldAddress or cpuDataOut /= saveData)
                   and mem_cen = '0' and (mem_ubs = '0' or mem_lbs = '0') 
                   and cpuAddress /= x"00"
                   then
                        oldAddress <= cpuAddress;
                        saveData <= cpuDataOut;
                        nState <= stAddressPending; --address changing
                
                else if cpuAddress = x"00" then                     
                    oldAddress <= cpuAddress;
                end if;
                end if;
            
            when stAddressPending => 
                cState <= nState;
                
                 mem_cen_int <= mem_cen;
                 mem_oen_int <= mem_oen;
                 mem_wen_int <= mem_wen;

                if mem_oen_int = '0' then
                    nState <= stReadPending;
                    read_address <= cpuAddress; -- not using fifo for reads
                else if mem_wen_int = '0' then
                    cache_addr_in <= cpuAddress;
                    cache_data_in <= cpuDataOut;
                    cache_upper_in(0) <= mem_ubs;
                    cache_lower_in(0) <= mem_lbs;
                    cache_write_en <= '1';
                    nState <= stWritePending;
                end if;
                end if;

            when stReadPending =>
            
                cState <= nState;
                mem_cen_int <= '0';
                mem_oen_int <= '0';
                mem_wen_int <= '1'; 
            
               if mem_data_ready = '1' and first_read_rcvd = '1' then
                    first_read_rcvd <= '0';
                    nState <= stDataReady;
               elsif mem_data_ready = '1' then
                    first_read_rcvd <= '1';
               end if;

               
            when stWritePending =>
            
                cState <= nState;
                mem_cen_int <= '0';
                mem_oen_int <= '1';
                mem_wen_int <= '0'; 
                
                if cache_write_ack = '1' then
                    cache_write_en <= '0';
                    nState <= stComplete;
                end if;
                
            when stDataReady =>
            
                cState <= nState;
                                
                mem_cen_int <= '1';
                mem_oen_int <= '1';
                mem_wen_int <= '1'; 

                ramDataOut <= mem_data_out(63 downto 48);
                nState <= stComplete after 50ns; -- access delay...

            when stComplete =>
            
                cState <= nState;
                mem_cen_int <= '1';
                mem_oen_int <= '1';
                mem_wen_int <= '1'; 
                cache_addr_in <= (others => '0');
                mem_data_valid <= '1';
                nState <= stIdle;
            
            end case;
        end if;
        end if;

    end process;    


end Behavioral;
