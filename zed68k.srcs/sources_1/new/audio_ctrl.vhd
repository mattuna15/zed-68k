----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.08.2020 17:28:34
-- Design Name: 
-- Module Name: audio_ctrl - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std_unsigned.all;

-- This is the top level module of the Nexys4DDR. The ports on this entity are
-- mapped directly to pins on the FPGA.

entity ym2151_top is
   port (
      sys_clk_i  : in    std_logic;    -- 100 MHz
      sys_rstn_i : in    std_logic;
      m68k_data_i: in    std_logic_vector(15 downto 0);  -- register - data
      audio_wr_ack : out  std_logic;
      aud_pwm_o  : inout std_logic;
      aud_sd_o   : out   std_logic
   );
end ym2151_top;

architecture synthesis of ym2151_top is

   signal ym2151_clk_s       : std_logic;
   signal ym2151_rst_s       : std_logic; 
   signal ym2151_cfg_valid_s : std_logic;
   signal ym2151_cfg_ready_s : std_logic;
   signal ym2151_cfg_addr_s  : std_logic_vector(7 downto 0);
   signal ym2151_cfg_data_s  : std_logic_vector(7 downto 0);
   signal ym2151_wav_s       : std_logic_vector(15 downto 0);

   signal pwm_clk_s          : std_logic;
   signal pwm_aud_s          : std_logic;

begin

   -----------------------------------------------------------------------------
   -- Instantiate Clock and Reset generation.
   -----------------------------------------------------------------------------

   i_clk_rst : entity work.clk_rst
      port map (
         sys_clk_i    => sys_clk_i,      -- 100 MHz
         sys_rstn_i   => sys_rstn_i,
         ym2151_clk_o => ym2151_clk_s,   --   3.579545 MHz
         ym2151_rst_o => ym2151_rst_s,
         pwm_clk_o    => pwm_clk_s       -- 229 MHz
      ); -- i_clk_rst


   -----------------------------------------------------------------------------
   -- Instantiate controller.
   -----------------------------------------------------------------------------

   i_ctrl : entity work.ctrl
      port map (
         clk_i       => ym2151_clk_s,
         rst_i       => ym2151_rst_s,
         cfg_m68k_i  => m68k_data_i,
         cfg_wr_ack  => audio_wr_ack,
         cfg_valid_o => ym2151_cfg_valid_s,
         cfg_ready_i => ym2151_cfg_ready_s,
         cfg_addr_o  => ym2151_cfg_addr_s,
         cfg_data_o  => ym2151_cfg_data_s
      ); -- i_ctrl


   -----------------------------------------------------------------------------
   -- Instantiate YM2151 module.
   -----------------------------------------------------------------------------

   i_ym2151 : entity work.ym2151
      port map (
         clk_i       => ym2151_clk_s,
         rst_i       => ym2151_rst_s,
         cfg_valid_i => ym2151_cfg_valid_s,
         cfg_ready_o => ym2151_cfg_ready_s,
         cfg_addr_i  => ym2151_cfg_addr_s,
         cfg_data_i  => ym2151_cfg_data_s,
         wav_o       => ym2151_wav_s
      ); -- i_ym2151


   -----------------------------------------------------------------------------
   -- Instantiate PWM module.
   -- The implied Clock Domain Crossing can be safely ignore because the YM2151
   -- period is a multiple of the PWM period, and hence the ym2151_wav_s signal
   -- is synchronuous to pwm_clk_s too.
   -----------------------------------------------------------------------------

   i_pwm : entity work.pwm
      port map (
         clk_i => pwm_clk_s,
         wav_i => ym2151_wav_s,
         pwm_o => pwm_aud_s
      ); -- i_pwm


   -----------------------------------------------------------------------------
   -- Drive output signals
   -----------------------------------------------------------------------------

   aud_sd_o  <= '1';
   aud_pwm_o <= '0' when pwm_aud_s = '0' else 'Z';

end architecture synthesis;


