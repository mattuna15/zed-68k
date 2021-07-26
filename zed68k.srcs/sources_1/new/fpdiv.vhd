----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.07.2021 10:02:18
-- Design Name: 
-- Module Name: fpdiv - Behavioral
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

entity fpdiv is
    Port ( 
        clock_i : in std_logic;
        reset_n : in std_logic;
        op_a : in std_logic_vector(31 downto 0);
        op_b : in std_logic_vector(31 downto 0);
        result : out std_logic_vector(31 downto 0) := (others => '0');
        
        valid_i : in std_logic;
        ready_o : out std_logic
    
    );
end fpdiv;

architecture Behavioral of fpdiv is

 component floating_point_0 is
    port  (
      -- Global signals
      aclk  : in std_logic;
    -- AXI4-Stream slave channel for operand A
      s_axis_a_tvalid  : in std_logic;
      s_axis_a_tready : out std_logic;
      s_axis_a_tdata  : in std_logic_vector(31 downto 0);
      -- AXI4-Stream slave channel for operand B
      s_axis_b_tvalid : in std_logic;
      s_axis_b_tready : out std_logic;
      s_axis_b_tdata  : in std_logic_vector(31 downto 0);
      -- AXI4-Stream master channel for output result
      m_axis_result_tvalid : out std_logic;
      m_axis_result_tready : in std_logic;
      m_axis_result_tdata  : out std_logic_vector(31 downto 0)
      );
  end component;

 -- A operand slave channel signals
  signal s_axis_a_tvalid         : std_logic := '0';  -- payload is valid
  signal s_axis_a_tready         : std_logic := '1';  -- slave is ready
  signal s_axis_a_tdata          : std_logic_vector(31 downto 0) := (others => '0');  -- data payload

  -- B operand slave channel signals
  signal s_axis_b_tvalid         : std_logic := '0';  -- payload is valid
  signal s_axis_b_tready         : std_logic := '1';  -- slave is ready
  signal s_axis_b_tdata          : std_logic_vector(31 downto 0) := (others => '0');  -- data payload

  -- Result master channel signals
  signal m_axis_result_tvalid    : std_logic := '0';
  signal m_axis_result_tready    : std_logic := '1';
  signal m_axis_result_tdata     : std_logic_vector(31 downto 0) := (others => '0');  -- data payload

    signal  fpu_state: std_logic_vector(2 downto 0);
    
begin

fpu1 : floating_point_0
    port map (
      -- Global signals
      aclk                    => clock_i,
    -- AXI4-Stream slave channel for operand A
      s_axis_a_tvalid         => s_axis_a_tvalid,
      s_axis_a_tready         => s_axis_a_tready,
      s_axis_a_tdata          => s_axis_a_tdata,
      -- AXI4-Stream slave channel for operand B
      s_axis_b_tvalid         => s_axis_b_tvalid,
      s_axis_b_tready         => s_axis_b_tready,
      s_axis_b_tdata          => s_axis_b_tdata,
      -- AXI4-Stream master channel for output result
      m_axis_result_tvalid    => m_axis_result_tvalid,
      m_axis_result_tready    => m_axis_result_tready,
      m_axis_result_tdata     => m_axis_result_tdata
      );


fsm: process (clock_i) 
begin

     if rising_edge(clock_i) then

        case fpu_state is
        when "000" => -- idle
            m_axis_result_tready <= '0';
            if valid_i = '1' then 
                s_axis_a_tdata <= op_a;
                s_axis_b_tdata <= op_b;
                s_axis_a_tvalid <= '1';
                s_axis_b_tvalid <= '1';
                fpu_state <= "001";
            else 
                s_axis_a_tvalid <= '0';
                s_axis_b_tvalid <= '0';
            end if;
        when "001" =>
            s_axis_a_tvalid <= '0';
            s_axis_b_tvalid <= '0';
            m_axis_result_tready <= '1';
            fpu_state <= "010";
        when "010" =>
            if m_axis_result_tvalid = '1' then
                result <= m_axis_result_tdata;
                ready_o <= '1';
                fpu_state <= "011";
            end if;
        when others =>
            ready_o <= '0';
            fpu_state <= "000";
        end case;
        
      end if;
      
end process;
            

end Behavioral;
