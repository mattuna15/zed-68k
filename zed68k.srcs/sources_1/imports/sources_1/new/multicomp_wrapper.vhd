----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/16/2020 04:43:37 PM
-- Design Name: 
-- Module Name: multicomp_wrapper - Behavioral
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

entity multicomp_wrapper is
port(
        sys_clock   : in std_logic;
        resetn      : in STD_LOGIC;

        VGA_R       : out std_logic_vector(3 downto 0);
        VGA_G       : out std_logic_vector(3 downto 0);
        VGA_B       : out std_logic_vector(3 downto 0);
		hSync			: buffer std_logic;
		vSync			: buffer std_logic;

		ps2k_clk_in		: inout std_logic;
		ps2k_dat_in		: inout std_logic;
				--ps2
		ps2m_clk_in : inout std_logic;
		ps2m_dat_in : inout std_logic;
		
		SCL : inout std_logic;
		SDA : inout std_logic;

         SD_RESET: inout std_logic; -- #IO_L14P_T2_SRCC_35 Sch=sd_reset
         SD_CD : in std_logic;  --#IO_L9N_T1_DQS_AD7N_35 Sch=sd_cd
         SD_SCK : out std_logic; --
         SD_CMD : out std_logic; -- #IO_L16N_T2_35 Sch=sd_cmd
         SD_DAT0 : in std_logic; -- #IO_L16P_T2_35 Sch=sd_dat[0]
         SD_DAT1 : inout std_logic;-- #IO_L18N_T2_35 Sch=sd_dat[1]
         SD_DAT2: inout std_logic;-- #IO_L18P_T2_35 Sch=sd_dat[2]
         SD_DAT3 : inout std_logic;--
            
--                 input reset, // Resets controller on assertion.
--input clk, // 25Mhz clock.
-- output reg cs, // Connect to SD_DAT[3].
-- output mosi, // Connect to SD_CMD.
-- input miso, // Connect to SD_DAT[0].
-- output sclk, // Connect to SD_SCK.
-- // For SPI mode, SD_DAT[2] and SD_DAT[1] should be held
--// HIGH.
-- // SD_RESET should be held LOW.

    LED : out STD_LOGIC_VECTOR ( 15 downto 0 );
    
    --serial
    rxd1 : in STD_LOGIC;
    txd1 : out STD_LOGIC;
    cts1 : in STD_LOGIC;
    rts1 : out STD_LOGIC;
    
        rxd2 : in STD_LOGIC;
        
    esp_rx : in STD_LOGIC;
	esp_tx : out STD_LOGIC;
        
        --memory
    
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
      ddr2_dqs_n           : inout std_logic_vector(1 downto 0);
      
      
      -- audio
      AUD_PWM              : inout std_logic;
      AUD_SD               : out std_logic;
      
      I2S_MCLK : out std_logic;
      I2S_LRCLK : out std_logic;
      I2S_SCLK :  out std_logic;
      I2S_DATA : out std_logic;

		
		-- ethernet

                ETH_MDC : OUT STD_LOGIC; --	output        eth_mdc,
                ETH_MDIO : INOUT STD_LOGIC; --	inout         eth_mdio, 
                ETH_RSTN : OUT STD_LOGIC; --	output        eth_rstn,
                ETH_CRSDV :  INOUT STD_LOGIC; --	inout         eth_crsdv,
                ETH_RXERR : INOUT STD_LOGIC; --	inout         eth_rxerr,
                ETH_RXD : INOUT STD_LOGIC_VECTOR(1 DOWNTO 0); --	inout  [1:0]  eth_rxd,
                ETH_TXEN : OUT STD_LOGIC; --	output        eth_txen,
                ETH_TXD : INOUT STD_LOGIC_VECTOR(1 DOWNTO 0); --	output [1:0]  eth_txd,
                ETH_REFCLK : OUT STD_LOGIC; --	output        eth_clkin,
                ETH_INTN :  INOUT STD_LOGIC --	inout         eth_intn,
	);
end multicomp_wrapper;


architecture Behavioral of multicomp_wrapper is

function reverse_any_vector (a: in std_logic_vector)
return std_logic_vector is
  variable result: std_logic_vector(a'RANGE);
  alias aa: std_logic_vector(a'REVERSE_RANGE) is a;
begin
  for i in aa'RANGE loop
    result(i) := aa(i);
  end loop;
  return result;
end; -- function reverse_any_vector

    signal clk50 : std_logic := '0';
    signal clk25 : std_logic := '0';
    signal clk48 : std_logic := '0';
    signal start_up  : std_logic := '0';
    --serial term
    signal serialTermStatus: std_logic_vector(7 downto 0) := x"00"; 
    signal serialTermRxData: std_logic_vector(7 downto 0) := x"00";
    signal serialTermRead_en: std_logic := '0';
    signal serialTermTxData: std_logic_vector(7 downto 0) := x"00";
    signal serialTermTxActive : std_logic := '0';
    signal serialTermTxWrite_en: std_logic;
    signal rx_count: std_logic_vector( 7 downto 0) := x"00";
    signal rx_data_trigger: std_logic := '0';
    
    --serial s-rec
    signal serialStatus: std_logic_vector(7 downto 0) := x"00"; 
    signal serialData: std_logic_vector(7 downto 0) := x"00";
    signal serialRead_en: std_logic := '0';
    signal count: std_logic_vector( 7 downto 0) := x"00";
    signal data_trigger: std_logic := '0';
    
    signal reset: std_logic := '1' ;
    signal clk_locked: std_logic := '0';


    -- esp
    
    signal esp_tx_act : std_logic := '0';
    signal esp_rx_act: std_logic := '0';
    signal esp_sts: std_logic_vector(7 downto 0) := x"00"; 
    signal esp_rxd: std_logic_vector(7 downto 0) := x"00";
    signal esp_txd: std_logic_vector(7 downto 0) := x"00";
    signal esp_rden: std_logic := '0';
    signal esp_wren: std_logic := '0';
    signal esp_rx_count: std_logic_vector( 7 downto 0) := x"00";

          -- RAM interface

        signal mem_clock: std_logic := '0';
        signal ram_access_delay: integer := 0;
        signal ram_ack: std_logic := '1';
        
      signal cpuAddress                :    std_logic_vector(26 downto 0) := (others => '0');
      signal oldAddress                :    std_logic_vector(26 downto 0) := (others => '0');
      signal cpuDataOut             :     std_logic_vector(15 downto 0) := (others => '0');
      signal cpuDataIn             :    std_logic_vector(15 downto 0) := (others => '0');
      signal cpuCS              :    std_logic;
      signal cpuAS      : std_logic; -- address steobe
      signal cpuReadEn              :     std_logic;
      signal cpuWriteEn              :     std_logic;
      signal cpuUpper               :     std_logic;
      signal cpuLower               :     std_logic;
      signal mem_ready              :     std_logic := '0';
      
      signal sys_resetn : std_logic;
      signal sys_clock100 : STD_LOGIC;
      
          
            -- vga
      signal vga_irq               :    std_logic;
      signal vga_addr              :    std_logic_vector(15 downto 0);
      signal vga_wr_en             :    std_logic;
      signal vga_rd_en             :    std_logic;
      signal vga_wr_data           :    std_logic_vector(7 downto 0);
      signal vga_rd_data           :    std_logic_vector(7 downto 0);
      
      --audio 
      signal audio_data_wr         : std_logic_vector(15 downto 0);
      signal audio_wr_ack          : std_logic;
      signal audio_playing         : std_logic;
      signal audio_wr_en           : std_logic;
      signal audio_enable          : std_logic;
      signal audio_regsel          : std_logic;
      
      signal pwm_audio_o : std_logic;
      
      signal audio_l : std_logic_vector(15 downto 0);
      signal audio_r : std_logic_vector(15 downto 0);
      
      signal clock_357 : std_logic;
      signal clock_148 : std_logic;
      
-- clocks 

    component pll
    port ( 
        resetn  : in std_logic;
        clk_in : in std_logic;
        locked : out std_logic;
        clk100  : out std_logic;
        clk200  : out std_logic;
        clk50  : out std_logic;
        clk48  : out std_logic
    );
    end component;
    
  component serial_rx
  port (
    LED : out STD_LOGIC_VECTOR ( 7 downto 0 );
    clk100_i : in STD_LOGIC;
    cts : out STD_LOGIC;
    m68_rxd : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rd_clk : in STD_LOGIC;
    rd_data_cnt : out STD_LOGIC_VECTOR ( 8 downto 0 );
    rd_en : in STD_LOGIC;
    reset_n : in STD_LOGIC;
    rts : out STD_LOGIC;
    rxd1 : in STD_LOGIC
  );
end component;
    
begin
   --------------------------------------------------
   -- Instantiate Clock generation
   --------------------------------------------------
       
    pll1:  pll
    port map (
        clk_in => sys_clock,
        resetn  => resetn,
        locked => clk_locked,
        clk100 => sys_clock100,
        clk200 => mem_clock,
        clk50 =>  clk50,
        clk48 => clk48
    );
    
    jt51_clock: entity work.jtframe_cen3p57
    port map (
        clk => clk48,       -- 48 MHz
        cen_3p57 => clock_357,
        cen_1p78 => clock_148
    );
    
        memory_control: entity work.mem_control 
        Port map (

        mem_clock => mem_clock, 
        resetn => resetn,
        clk_locked => clk_locked, 
        sys_clock => sys_clock100,
    
    -- ram
    cpuAddress => cpuAddress,
    cpuDataOut   => cpuDataOut,
    ramDataOut => cpuDataIn,
    mem_cen => cpuCS ,
    mem_oen => cpuReadEn,
    mem_wen => cpuWriteEn, -- chip enables
    mem_ubs => cpuUpper,
    mem_lbs => cpuLower,
    mem_data_valid => ram_ack,
    mem_ready => mem_ready,
    
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

    reset_proc : process
    begin
    
        if resetn = '1' and mem_ready = '1' and clk_locked = '1' then 
            sys_resetn <= '1'; 
        else 
            sys_resetn <= '0';
        end if;
        
        wait for 3us;
        
    end process;
 
 computer: entity work.Microcomputer 
    port map (
        
        sys_clk => sys_clock100,
        n_reset	=> sys_resetn,
        clk50 => clk50,
		
		sdCD => SD_CD,
		sdCS => SD_DAT3,
		sdMOSI => SD_CMD,
		sdMISO => SD_DAT0,
		sdSCLK => SD_SCK,
		driveLED => open , -- LED(0),
		
		--srec
	    serialRead_en => serialRead_en,
		serialStatus => serialStatus,
		serialData => serialData,
		
		--terminal

        serialTerminalStatus => serialTermStatus,
        rx_serialRead_en => serialTermRead_en,
        serialRxData => serialTermRxData,
        tx_serialWrite_en => serialTermTxWrite_en,
        serialTxData => serialTermTxData,
		
		                  -- RAM interface
      ram_a                => cpuAddress,
      ram_dq_i             => cpuDataOut(15 downto 0),
      ram_dq_o             => cpuDataIn(15 downto 0),
      ram_cen              => cpuCS,
      ram_oen              => cpuReadEn,
      ram_wen              => cpuWriteEn,
      ram_ub               => cpuUpper,
      ram_lb               => cpuLower,
      ram_ack              => ram_ack,
      
      cpu_as                => cpuAS,
      
        vga_addr => vga_addr,
        vga_wr_en =>  vga_wr_en,
        vga_rd_en => vga_rd_en,
        vga_wr_data => vga_wr_data,
        vga_rd_data => vga_rd_data,
       vga_irq => vga_irq,
		
		--ps2
		ps2k_clk => ps2k_clk_in,
		ps2k_dat => ps2k_dat_in,
		ps2m_clk => ps2m_clk_in,
		ps2m_dat => ps2m_dat_in,
		
		
		esp_sts => esp_sts, 
        esp_rxd => esp_rxd,
        esp_txd => esp_txd,
        esp_rden => esp_rden,
        esp_wren => esp_wren
		
		
    );
    
    --only using spi do drive dat1&2 high & reset is low.
    SD_RESET <= '0';
    SD_DAT1 <= '1';
    SD_DAT2 <= '1';
    --LED(1) <= not SD_CD;
    
    LED(15 downto 8) <= esp_txd;
    LED(7 downto 0) <= esp_rxd;
    
    --serial
    
    io_serial_term_tx: entity work.serial_wrapper 
        port map (
        sys_clk => sys_clock100,
        tx_data => serialTermTxData,
        tx_wr_en => serialTermTxWrite_en,
        cts => open,
        rts => open,
        reset_n => resetn and mem_ready and clk_locked,
        txd => txd1,
        tx_send_active => serialTermTxActive
  );
  
  io_serial_term_rx : serial_rx
    port map (
      LED => open,
      rd_en => serialTermRead_en,
      m68_rxd => serialTermRxData,
      rd_clk => sys_clock100,
      reset_n => resetn and mem_ready and clk_locked,
      rxd1 => rxd1,
      rd_data_cnt(8 downto 1) => rx_count,
      rd_data_cnt(0) => rx_data_trigger,
      clk100_i => sys_clock100,
      cts => open,
      rts => open
    );  
    
    
    -- esp
--    		esp_sts => esp_sts, 
--        esp_rxd => esp_rxd,
--        esp_txd => esp_txd,
--        esp_rden => esp_rden,
--        esp_wren => esp_wren
    
    esp_serial_term_tx: entity work.serial_wrapper 
        port map (
        sys_clk => sys_clock100,
        tx_data => esp_txd,
        tx_wr_en => esp_wren,
        cts => open,
        rts => open,
        reset_n => resetn and mem_ready and clk_locked,
        txd => esp_tx,
        tx_send_active => esp_tx_act
  );
  
  esp_serial_term_rx : serial_rx
    port map (
      LED => open,
      rd_en => esp_rden,
      m68_rxd => esp_rxd,
      rd_clk => sys_clock100,
      reset_n => resetn and mem_ready and clk_locked,
      rxd1 => esp_rx,
      rd_data_cnt(8 downto 1) => esp_rx_count,
      rd_data_cnt(0) => esp_rx_act,
      clk100_i => sys_clock100,
      cts => open,
      rts => open
    );  
    
    
    io_serial_load : serial_rx
    port map (
      LED => open,
      rd_en => serialRead_en,
      m68_rxd => serialData,
      rd_clk => sys_clock100,
      reset_n => resetn and mem_ready and clk_locked,
      rxd1 => rxd2,
      rd_data_cnt(8 downto 1) => count,
      rd_data_cnt(0) => data_trigger,
      clk100_i => sys_clock100,
      cts => open,
      rts => open
    );  

vga: entity work.gameduino_main
    port map (
      vga_clk => clk50, -- Twice the frequency of the original clka board clock
      vga_red => VGA_R(3 downto 1),
      vga_green => VGA_G(3 downto 1),
      vga_blue => VGA_B(3 downto 1),
      vga_hsync => hSync,
      vga_vsync => vSync,
      vga_active => open,
      --coll_rd => vga_irq,
    
      mem_clk => sys_clock100, -- Should probably be same as vga_clk
      host_mem_wr => vga_wr_en,             -- set to zero if not used
      host_mem_w_addr => vga_addr(14 downto 0),  -- set to zero if not used
      host_mem_data_wr => vga_wr_data,  -- set to zero if not used
      host_mem_rd => vga_rd_en,            -- set to zero if not used
      host_mem_r_addr => vga_addr(14 downto 0),  -- set to zero if not used
      host_mem_data_rd => vga_rd_data,
    
      AUX_in => std_logic_vector(to_unsigned(0, 1)), -- set to zero if not used
      AUX_out => open,
      AUX_tristate => open,
    
      AUDIOL => pwm_audio_o,
      AUDIOR => open,
      audio_trigger => audio_playing,
      
      audio_l => audio_l,
      audio_r => audio_r,
    
      pin2f => open,
      pin2j => open,
      j1_flashMOSI  => open,
      j1_flashSCK  => open,
      j1_flashSSEL  => open,
      flashMISO => std_logic_vector(to_unsigned(0, 1))
  );
  
--  left_mixer: entity work.jtframe_mixer 
--  generic map (W0=16,W1=16,W2=16,W3=16,WOUT=16)
--  port map(
--    input                    clk,
--    input                    cen,
--    // input signals
--    input  signed [W0-1:0]   ch0,
--    input  signed [W1-1:0]   ch1,
--    input  signed [W2-1:0]   ch2,
--    input  signed [W3-1:0]   ch3,
--    // gain for each channel in 4.4 fixed point format
--    input  [7:0]             gain0,
--    input  [7:0]             gain1,
--    input  [7:0]             gain2,
--    input  [7:0]             gain3,
--    output     signed [WOUT-1:0] mixed
--);

--module jt51(
--    input               rst,    // reset
--    input               clk,    // main clock
--    input               cen,    // clock enable
--    input               cen_p1, // clock enable at half the speed
--    input               cs_n,   // chip select
--    input               wr_n,   // write
--    input               a0,
--    input       [7:0]   din, // data in
--    output      [7:0]   dout, // data out
--    // peripheral control
--    output              ct1,
--    output              ct2,
--    output              irq_n,  // I do not synchronize this signal
--    // Low resolution output (same as real chip)
--    output              sample, // marks new output sample
--    output  signed  [15:0] left,
--    output  signed  [15:0] right,
--    // Full resolution output
--    output  signed  [15:0] xleft,
--    output  signed  [15:0] xright,
--    // unsigned outputs for sigma delta converters, full resolution
--    output  [15:0] dacleft,
--    output  [15:0] dacright
--);


--i2s: entity  work.i2s 
-- generic map (DAC_OUTPUT_WIDTH=16)
-- port map (
--    clk => clk, 
--    input wire sample_clk_en,
--    input wire [DAC_OUTPUT_WIDTH-1:0] left_channel,
--    input wire [DAC_OUTPUT_WIDTH-1:0] right_channel,
--    output logic i2s_sclk = 0,
--    output logic i2s_ws = 0,
--    output logic i2s_sd = 0
--);
    
--ethernet: entity work.eth_mac
--    port map (
--	input         clk_mac,
--	input         clk_phy,
--	input         rst_n,
--	input [2:0]   mode_straps,
	
	
--	--board
--	eth_mdc =>  ETH_MDC, 
--	eth_mdio => ETH_MDIO,  --	inout         eth_mdio, 
--    eth_rstn => ETH_RSTN , --	output        eth_rstn,
--    eth_crsdv => ETH_CRSDV, -- :  INOUT STD_LOGIC; --	inout         eth_crsdv,
--    eth_rxerr => ETH_RXERR, -- : INOUT STD_LOGIC; --	inout         eth_rxerr,
--    eth_rxd => ETH_RXD, --	inout  [1:0]  eth_rxd,
--    eth_txen => ETH_TXEN, --	output        eth_txen,
--    eth_txd => ETH_TXD,  --	output [1:0]  eth_txd,
--    eth_clkin =>  ETH_REFCLK, --	output        eth_clkin,
--    eth_intn =>  ETH_INTN, -- :  INOUT STD_LOGIC --	inout         eth_intn,


--	inout         eth_intn,
	
--	--rx
--	output        rx_vld,
--	output [7:0]  rx_dat,
--	output        rx_sof,
--	output        rx_eof,
--	output        rx_err,
	
--	output [7:0]  rx_axis_mac_tdata,
--	output        rx_axis_mac_tvalid,
--	output        rx_axis_mac_tlast,
--	output        rx_axis_mac_tuser,
	
--	--tx
--	input         tx_vld,
--	input [7:0]   tx_dat,
--	input         tx_sof,
--	input         tx_eof,
--	output        tx_ack,
	
--	input  [7:0]  tx_axis_mac_tdata,
--	input         tx_axis_mac_tvalid,
--	input         tx_axis_mac_tlast,
--	output        tx_axis_mac_tready,
	
--	--status
--	input         reg_vld,
--	input  [4:0]  reg_addr,
--	input         reg_write,
--	input  [15:0] reg_wval,
--	output [15:0] reg_rval,
--	output        reg_ack,
	
--	output        speed_100,
--	output        full_duplex,
--	output        link_up,
--	output        remote_fault,
--	output        auto_neg_done
--);


   AUD_SD  <= '1';
   AUD_PWM <= '0' when pwm_audio_o = '0' else 'Z';
    
   serialTermStatus(0) <= '1' when rx_count > x"00" else '0';
   serialTermStatus(1) <= '1' when serialTermTxActive = '0' else '0';
   serialStatus(0) <= '1' when count > x"00" else '0';
   
   esp_sts(0) <= '1' when esp_rx_count > x"00" else '0';
   esp_sts(1) <= '1' when esp_tx_act = '0' else '0';

end Behavioral;