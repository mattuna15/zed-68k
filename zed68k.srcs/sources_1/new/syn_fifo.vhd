----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.07.2020 08:59:02
-- Design Name: 
-- Module Name: syn_fifo - Behavioral
-- Project Name: 
-- Target Devices: 
-------------------------------------------------------
-- Design Name : syn_fifo
-- File Name   : syn_fifo.vhd
-- Function    : Synchronous (single clock) FIFO
-- Coder       : Deepak Kumar Tala (Verilog)
-- Translator  : Alexander H Pham (VHDL)
-------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;

entity syn_fifo is
    generic (
        DATA_WIDTH :integer := 8;
        ADDR_WIDTH :integer := 8
    );
    port (
        clk      :in  std_logic; -- Clock input
        rst      :in  std_logic; -- Active high reset
        wr_cs    :in  std_logic; -- Write chip select
        rd_cs    :in  std_logic; -- Read chipe select
        data_in  :in  std_logic_vector (DATA_WIDTH-1 downto 0); -- Data input
        rd_en    :in  std_logic; -- Read enable
        wr_en    :in  std_logic; -- Write Enable
        data_out :out std_logic_vector (DATA_WIDTH-1 downto 0); -- Data Output
        empty    :out std_logic; -- FIFO empty
        full     :out std_logic  -- FIFO full
    );
end entity;
architecture rtl of syn_fifo is
    -------------Internal variables-------------------
    constant RAM_DEPTH :integer := 2**ADDR_WIDTH;

    signal wr_pointer   :std_logic_vector (ADDR_WIDTH-1 downto 0);
    signal rd_pointer   :std_logic_vector (ADDR_WIDTH-1 downto 0);
    signal status_cnt   :std_logic_vector (ADDR_WIDTH   downto 0);
    signal data_ram_in  :std_logic_vector (DATA_WIDTH-1 downto 0);
    signal data_ram_out :std_logic_vector (DATA_WIDTH-1 downto 0);
    
    component ram_dp_ar_aw is
    generic (
        DATA_WIDTH :integer := 8;
        ADDR_WIDTH :integer := 8
    );
    port (
        address_0 :in    std_logic_vector (ADDR_WIDTH-1 downto 0);  -- address_0 Input
        data_0    :inout std_logic_vector (DATA_WIDTH-1 downto 0);  -- data_0 bi-directional
        cs_0      :in    std_logic;                                 -- Chip Select
        we_0      :in    std_logic;                                 -- Write Enable/Read Enable
        oe_0      :in    std_logic;                                 -- Output Enable
        address_1 :in    std_logic_vector (ADDR_WIDTH-1 downto 0);  -- address_1 Input
        data_1    :inout std_logic_vector (DATA_WIDTH-1 downto 0);  -- data_1 bi-directional
        cs_1      :in    std_logic;                                 -- Chip Select
        we_1      :in    std_logic;                                 -- Write Enable/Read Enable
        oe_1      :in    std_logic                                  -- Output Enable
    );
    end component;
    
begin
    -------------Code Start---------------------------
    full  <= '1' when (status_cnt = (RAM_DEPTH-1)) else '0';
    empty <= '1' when (status_cnt = 0) else '0';

    WRITE_POINTER:
    process (clk, rst) begin
        if (rst = '1') then
            wr_pointer <= (others=>'0');
        elsif (rising_edge(clk)) then
            if (wr_cs = '1' and wr_en = '1') then
                wr_pointer <= wr_pointer + 1;
            end if;
        end if;
    end process;
    
    READ_POINTER:
    process (clk, rst) begin
        if (rst  = '1') then
            rd_pointer <= (others=>'0');
        elsif (rising_edge(clk)) then
            if (rd_cs = '1' and rd_en = '1') then
                rd_pointer <= rd_pointer + 1;
            end if;
        end if;
    end process;

    READ_DATA:
    process (clk, rst) begin
        if (rst = '1') then
            data_out <= (others=>'0');
        elsif (rising_edge(clk)) then
            if (rd_cs = '1' and rd_en = '1') then
                data_out <= data_ram_out;
            end if;
        end if;
    end process;

    STATUS_COUNTER:
    process (clk, rst) begin
        if (rst = '1') then
            status_cnt <= (others=>'0');
        -- Read but no write.
        elsif (rising_edge(clk)) then
            if ((rd_cs = '1' and rd_en = '1') and not(wr_cs = '1' and wr_en = '1') and (status_cnt /= 0)) then
                status_cnt <= status_cnt - 1;
            -- Write but no read.
            elsif ((wr_cs = '1' and wr_en = '1') and not (rd_cs = '1' and rd_en = '1') and (status_cnt /= RAM_DEPTH)) then
                status_cnt <= status_cnt + 1;
            end if;
        end if;
    end process;
    
    data_ram_in <= data_in;

    DP_RAM : ram_dp_ar_aw
    generic map (
        DATA_WIDTH => DATA_WIDTH,
        ADDR_WIDTH => ADDR_WIDTH
    )
    port map (
        address_0 => wr_pointer,    -- address_0 input
        data_0    => data_ram_in,   -- data_0 bi-directional
        cs_0      => wr_cs,         -- chip select
        we_0      => wr_en,         -- write enable
        oe_0      => '0',           -- output enable
        address_1 => rd_pointer,    -- address_q input
        data_1    => data_ram_out,  -- data_1 bi-directional
        cs_1      => rd_cs,         -- chip select
        we_1      => '0',           -- Read enable
        oe_1      => rd_en          -- output enable
    );
    
end architecture;
