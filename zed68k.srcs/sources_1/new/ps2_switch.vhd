library ieee;
use ieee.std_logic_1164.all;

entity PS2Switch is
    port(
        -- control
        mode_s : in std_logic;
        -- keyboard ps/2 block
        kbd_clk_in   : in  std_logic;
        kbd_clk_out  : out std_logic;
        kbd_data_in  : in  std_logic;
        kbd_data_out : out std_logic;
        -- mouse ps/2 block
        mouse_clk_in   : in  std_logic;
        mouse_clk_out  : out std_logic;
        mouse_data_in  : in  std_logic;
        mouse_data_out : out std_logic;
        --port A
        prtA_clk  : inout std_logic;
        prtA_data : inout std_logic;
        --port B
        prtB_clk  : inout std_logic;
        prtB_data : inout std_logic
        );
end entity;

architecture rtl of PS2Switch is
    signal prtA_clk_out  : std_logic;
    signal prtA_data_out : std_logic;
    signal prtB_clk_out  : std_logic;
    signal prtB_data_out : std_logic;
begin
    -- output muxes
    kbd_clk_out    <= prtA_clk  when mode_s = '0' else prtB_clk;
    kbd_data_out   <= prtA_data when mode_s = '0' else prtB_data;
    mouse_clk_out  <= prtA_clk  when mode_s = '1' else prtB_clk;
    mouse_data_out <= prtA_data when mode_s = '1' else prtB_data;

    -- input muxes
    prtA_clk_out  <= kbd_clk_in  when mode_s = '0' else mouse_clk_in;
    prtA_data_out <= kbd_data_in when mode_s = '0' else mouse_data_in;
    prtB_clk_out  <= kbd_clk_in  when mode_s = '1' else mouse_clk_in;
    prtB_data_out <= kbd_data_in when mode_s = '1' else mouse_data_in;

    -- tristate buffers (output pins)
    prtA_clk  <= '0' when prtA_clk_out  = '0' else 'Z';
    prtA_data <= '0' when prtA_data_out = '0' else 'Z';
    prtB_clk  <= '0' when prtB_clk_out  = '0' else 'Z';
    prtB_data <= '0' when prtB_data_out = '0' else 'Z';
end architecture;
