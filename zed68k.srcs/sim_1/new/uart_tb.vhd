----------------------------------------------------------------------
-- File Downloaded from http://www.nandland.com
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
entity uart_tb is
end uart_tb;
 
architecture behave of uart_tb is

    component uart_wrapper is
    port(
      i_cen,i_regsel,i_valid,i_wren, rx_in, sys_clock, sys_resetn : in std_logic;
      interrupt, o_ready, o_valid, tx_out, wr_ack : out std_logic;
      wr_data : in std_logic_vector(7 downto 0);
      rd_data : out std_logic_vector(7 downto 0)
  );
  end component;
 
 
    signal r_Clock : std_logic := '0';

 
        --signal cts   :  std_logic;
        signal din  :  std_logic_vector(7 downto 0) := x"00";
        signal dout :  std_logic_vector(7 downto 0) := x"00";
        signal o_valid :  std_logic;
        signal i_RX_Serial :  std_logic := '0';
        signal o_TX_Serial :  std_logic;
        signal rd_en :  std_logic := '0';
        signal reset_n :  std_logic := '1';
        signal rts :  std_logic;
        signal wr_ack :  std_logic;
        signal full :  std_logic;
        signal wr_en :  std_logic := '1';
        signal o_ready : std_logic := '0';
        signal i_cen : std_logic := '1';
        signal rx_data_count :  std_logic_vector(6 downto 0) := "0000000";
        
        signal i_regsel :std_logic := '0';
        signal i_valid : std_logic := '0';
        signal interrupt : std_logic := '0';
begin

--  component uart_wrapper is
--    port(
--      i_cen,i_regsel,i_valid,i_wren, rx_in, sys_clock, sys_resetn : in std_logic;
--      interrupt, o_ready, o_valid, tx_out, wr_ack : out std_logic;
--      wr_data : in std_logic_vector(7 downto 0);
--      rd_data : out std_logic_vector(7 downto 0)
--  );
--  end component;
 
  -- Instantiate UART transmitter
    uart1 : uart_wrapper
    port map ( -- CLOCK AND RESET
        sys_clock   => r_CLOCK, 
        sys_resetn   => '1',
        i_valid => i_valid,
        -- UART INTERFACE
        tx_out    => o_TX_Serial,  -- serial transmit data
        rx_in    => o_TX_Serial,  -- serial receive data
        -- USER DATA INPUT INTERFACE
        wr_data    => din, -- input data to be transmitted over UART
        i_wren   => wr_en, -- when DIN_VLD = 1, input data (DIN) are valid
        wr_ack  => wr_ack, -- when DIN_RDY = 1, transmitter is ready and valid input data will be accepted for transmiting
        -- USER DATA OUTPUT INTERFACE
        rd_data     => dout, -- output data received via UART
        o_valid  => o_valid, -- when DOUT_VLD = 1, output data (DOUT) are valid (is assert only for one clock cycle)
        o_ready   => o_ready, -- when FRAME_ERROR = 1, stop bit was invalid (is assert only for one clock cycle)
        i_cen  => i_cen,  -- when PARITY_ERROR = 1, parity bit was invalid (is assert only for one clock cycle)
        interrupt => interrupt,
        i_regsel => i_regsel
    );
 
  r_CLOCK <= not r_CLOCK after 5 ns; --100mhz
  
  send : process is 
  begin
  
     wait until o_ready = '1';
    
    din <= "00010000";
    wr_en   <= '0'; i_cen <= '0'; i_valid <='1'; i_regsel<= '1';
    wait until wr_ack = '1';
    wr_en   <= '1'; i_cen <= '1'; i_valid <='0'; i_regsel<= '0';
 
  
      -- Tell the UART to send a command.
    wait until o_ready = '1';
    
    din <= X"AB";
    wr_en   <= '0'; i_cen <= '0'; i_valid <='1' ;          -- Tell the UART to send a command.
    wait until wr_ack = '1';
    wr_en   <= '1'; i_cen <= '1'; i_valid <='0' ;
    
        wait until o_ready = '1';
    
    din <= X"CD";
    wr_en   <= '0'; i_cen <= '0'; i_valid <='1' ;          -- Tell the UART to send a command.
    wait until wr_ack = '1';
    wr_en   <= '1'; i_cen <= '1'; i_valid <='0' ;
    
        wait until o_ready = '1';
    
    din <= X"EF";
    wr_en   <= '0'; i_cen <= '0'; i_valid <='1' ;          -- Tell the UART to send a command.
    wait until wr_ack = '1';
    wr_en   <= '1'; i_cen <= '1'; i_valid <='0' ;
    
    
    wait until o_ready = '1';   
    wr_en   <= '1'; i_cen <= '0'; i_valid <='1'; i_regsel<= '1';
    wait until o_valid = '1';
    wr_en   <= '1'; i_cen <= '1'; i_valid <='0'; i_regsel<= '0';
  
    while (dout(0) = '0' ) loop
        wr_en   <= '1'; i_cen <= '0'; i_valid <='1'; i_regsel<= '1';
        wait until o_valid = '1';
        wr_en   <= '1'; i_cen <= '1'; i_valid <='0'; i_regsel<= '0';
    end loop; 
    
    
    wait until o_ready = '1';
    wr_en   <= '1'; i_cen <= '0'; i_valid <='1'; i_regsel<= '0';
    wait until o_valid = '1';
    wr_en   <= '1'; i_cen <= '1'; i_valid <='0'; i_regsel<= '0';
    
       
    wait until o_ready = '1';
    wr_en   <= '1'; i_cen <= '0'; i_valid <='1'; i_regsel<= '0';
    wait until o_valid = '1';
    wr_en   <= '1'; i_cen <= '1'; i_valid <='0'; i_regsel<= '0';
    
    wait until o_ready = '1';
    wr_en   <= '1'; i_cen <= '0'; i_valid <='1'; i_regsel<= '0';
    wait until o_valid = '1';
    wr_en   <= '1'; i_cen <= '1'; i_valid <='0'; i_regsel<= '0';
    
    
    wait until o_ready = '1';   
    wr_en   <= '1'; i_cen <= '0'; i_valid <='1'; i_regsel<= '1';
    wait until o_valid = '1';
    wr_en   <= '1'; i_cen <= '1'; i_valid <='0'; i_regsel<= '0';
       
    wait until o_ready = '1';
    
    
    
    assert false report "Tests Complete" severity failure;
  
  end process;
   
   
end behave;