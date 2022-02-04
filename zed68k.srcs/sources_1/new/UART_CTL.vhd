----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity UART_FIFO_IO_cntl_proc is
    port(    clk : in std_logic;
            rst : in std_logic;
            
            -- status signals        INPUT
            uart_rx_dv : in std_logic;--indicates that uart data is received and valid at
            uart_tx_rfd : in std_logic;--indicates that UART is ready to get new data to transmit
            fifoM_full : in std_logic;--indicates that fifo buffer is full
            fifoM_empty : in std_logic;--indicates that fifo buffer is empty
            fifoM_wr_ack : in std_logic;
            
            -- control signals    OUTPUT
            uart_rx_rd_en : out std_logic;-- uart read enable (CE-pin at a FF-register)
            uart_tx_wr_en : out std_logic;-- uart write enable (CE-pin at FF-register)
            fifoM_wr_en : out std_logic := '0';-- fifo buffer write enable
            fifoM_rd_en : out std_logic-- fifo buffer    read enable
    );
end UART_FIFO_IO_cntl_proc;

architecture Behavioral of UART_FIFO_IO_cntl_proc is
    signal uart_tx_wr_en_next : std_logic;
    signal rden : std_logic := '0';

begin

    fifoM_rd_en <= rden ;
    
    clock_enable_proc : process(clk)
    begin
        if rising_edge(clk) then
            -- default values
            uart_rx_rd_en             <= '0';-- uart read enable (CE-pin at a FF-register)
            
            if fifoM_wr_ack = '1' then
                fifoM_wr_en             <= '0';-- fifo buffer write disable
            end if;
            
            uart_tx_wr_en_next    <= '0';-- uart write enable (CE-pin at FF-register)

            if uart_rx_dv='1' and fifoM_full='0' then
                fifoM_wr_en <= '1';    
            end if;

            if uart_tx_rfd='1' and fifoM_empty='0' and rden = '0' then
                rden <= '1';
                uart_tx_wr_en_next <= '1';
            else 
                rden <= '0';
            end if;


            
        end if;
    end process clock_enable_proc;
    
    next_proc : process(clk)
    begin
        if rising_edge(clk) then
            uart_tx_wr_en <= uart_tx_wr_en_next;
        end if;
    end process next_proc;
end Behavioral;