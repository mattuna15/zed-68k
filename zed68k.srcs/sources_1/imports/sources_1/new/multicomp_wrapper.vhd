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

    led : out STD_LOGIC_VECTOR ( 3 downto 0 );
    
    --serial
    uart_rxd_out : out STD_LOGIC;
    uart_txd_in : in STD_LOGIC;

    rxd2 : in STD_LOGIC;
        
    txd3 : out STD_LOGIC;
	rxd3 : in STD_LOGIC;
      
      --ram
    
      ddr3_addr            : out   std_logic_vector(13 downto 0);
      ddr3_ba              : out   std_logic_vector(2 downto 0);
      ddr3_ras_n           : out   std_logic;
      ddr3_cas_n           : out   std_logic;
      ddr3_we_n            : out   std_logic;
      ddr3_ck_p            : out   std_logic_vector(0 downto 0);
      ddr3_ck_n            : out   std_logic_vector(0 downto 0);
      ddr3_cke             : out   std_logic_vector(0 downto 0);
      ddr3_cs_n             : out   std_logic;
      ddr3_dm              : out   std_logic_vector(1 downto 0);
      ddr3_odt             : out   std_logic_vector(0 downto 0);
      ddr3_dq              : inout std_logic_vector(15 downto 0);
      ddr3_dqs_p           : inout std_logic_vector(1 downto 0);
      ddr3_dqs_n           : inout std_logic_vector(1 downto 0);
      
      ddr3_reset_n :out std_logic;
      
      ps2clk :inout std_logic;
      ps2data :inout std_logic;
      
      --dazzler
      
        gd_uart_txd_out : out   std_logic;                  -- gd uart out
        gd_gpu_sel : out std_logic;
        gd_sd_sel : out std_logic;
        gd_daz_sel : out std_logic;
        gd_mosi : out std_logic;
        gd_miso : in std_logic;
        gd_sclk  : out std_logic;
        
        sw : in std_logic_vector(3 downto 0);
        

    scl_pup : out STD_LOGIC;
    sda_pup : out STD_LOGIC;
    ck_scl : inout STD_LOGIC;
    ck_sda : inout STD_LOGIC
    
--    eth_mdio_mdc_mdc : out STD_LOGIC;
--    eth_mdio_mdc_mdio_io : inout STD_LOGIC;
--    eth_mii_col : in STD_LOGIC;
--    eth_mii_crs : in STD_LOGIC;
--    eth_mii_rst_n : out STD_LOGIC;
--    eth_mii_rx_clk : in STD_LOGIC;
--    eth_mii_rx_dv : in STD_LOGIC;
--    eth_mii_rx_er : in STD_LOGIC;
--    eth_mii_rxd : in STD_LOGIC_VECTOR ( 3 downto 0 );
--    eth_mii_tx_clk : in STD_LOGIC;
--    eth_mii_tx_en : out STD_LOGIC;
--    eth_mii_txd : out STD_LOGIC_VECTOR ( 3 downto 0 )
      
	);
end multicomp_wrapper;

architecture Behavioral of multicomp_wrapper is

    signal boot_rom : std_logic := '1';
    
    signal i_valid_count: integer := 0;
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
    
    signal reset: std_logic;
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
    signal mem_resetn :std_logic;

          -- RAM interface

        signal clk200: std_logic := '0';
        signal ram_ack: std_logic := '1';
        
      signal cpuAddress                :    std_logic_vector(26 downto 0) := (others => '0');
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
    signal clk166 : std_logic;
    signal clk100 : std_logic;
    
    signal ddr_cke : std_logic_vector(0 downto 0);
    signal ddr_rstn : std_logic;
    signal rstn_flag : std_logic := '0';
    signal cke_flag :std_logic :='0';
    
    signal mem_i_valid : std_logic;
    signal mem_i_valid_p : std_logic;
    
-- clocks 

    signal clk25 : std_logic;
    

    component pll
    port ( 
        resetn  : in std_logic;
        clk_in : in std_logic;
        locked : out std_logic;
        clk200  : out std_logic;
        clk166 : out std_logic;
        clk25: out std_logic
    );
    end component;
    
    component main_memory_control 
    port (
    sys_clock : in std_logic;
    clock166 : in std_logic;
    clock200 : in std_logic;
    sys_resetn : in std_logic;
    --// SRAM like interface ////
    -- cpu (Fast memory)
    address: in std_logic_vector(27 downto 0);   -- // Address bus (Upper part not used)
    i_cen : in std_logic;  --     // Chip select 
    i_valid_p : in std_logic;
    wr_byte_mask : in std_logic_vector(1 downto 0);
    i_wren : in std_logic;  --     // Write enable
    wr_data : in std_logic_vector(15 downto 0); --     // Data to write
    rd_data : out std_logic_vector(15 downto 0); --     // Data to read
    o_ready_p : out std_logic; --  // idel ready
    o_valid_p : out std_logic; --  // Transaction ready
    wr_ack_p : out std_logic; --  // Transaction ready
    --//// SDRAM DDR3 ////
    --// DDR3 Inouts
      ddr3_sdram_addr            : out   std_logic_vector(13 downto 0);
      ddr3_sdram_reset_n            : out   std_logic;
      ddr3_sdram_ba              : out   std_logic_vector(2 downto 0);
      ddr3_sdram_ras_n           : out   std_logic;
      ddr3_sdram_cas_n           : out   std_logic;
      ddr3_sdram_we_n            : out   std_logic;
      ddr3_sdram_ck_p            : out   std_logic_vector(0 downto 0);
      ddr3_sdram_ck_n            : out   std_logic_vector(0 downto 0);
      ddr3_sdram_cke             : out   std_logic_vector(0 downto 0);
      ddr3_sdram_dm              : out   std_logic_vector(1 downto 0);
      ddr3_sdram_odt             : out   std_logic_vector(0 downto 0);
      ddr3_sdram_dq              : inout std_logic_vector(15 downto 0);
      ddr3_sdram_dqs_p           : inout std_logic_vector(1 downto 0);
      ddr3_sdram_dqs_n           : inout std_logic_vector(1 downto 0);
      ddr3_sdram_cs_n : out   std_logic;

      init_calib_complete :out std_logic
    );
    end component;
    
  component design_1_wrapper
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
    
    
component serial_wrapper is
  port (
    cts : out STD_LOGIC;
    reset_n : in STD_LOGIC;
    rts : out STD_LOGIC;
    sys_clk : in STD_LOGIC;
    tx_data : in STD_LOGIC_VECTOR ( 7 downto 0 );
    tx_send_active : out STD_LOGIC;
    tx_wr_en : in STD_LOGIC;
    txd : out STD_LOGIC
  );
end component;

attribute dont_touch : string;

attribute dont_touch of reset_proc : label is "true";
attribute dont_touch of valid_flag : label is "true";
attribute dont_touch of mem_i_valid : signal is "true";
attribute dont_touch of mem_i_valid_p : signal is "true";

      signal ramDataOut: std_logic_vector(15 downto 0);
      signal initial_stack: std_logic_vector(31 downto 0) := x"009F0000";
      signal initial_pc: std_logic_vector(31 downto 0) := x"00A00BB4";
      
      signal memDataOut: std_logic_vector(15 downto 0);
      signal mem_ack:std_logic;
      signal mem_wr_ack : std_logic;

begin
   --------------------------------------------------
   -- Instantiate Clock generation
   --------------------------------------------------
       
    pll1:  pll
    port map (
        clk_in => sys_clock,
        resetn  => resetn,
        locked => clk_locked,
        clk200 => clk200,
        clk166 => clk166,
        clk25 => clk25
    );
     
reset_proc : process
begin   

    sys_resetn <= resetn and mem_ready and clk_locked;

    rstn_flag <= '0', '1' after 220us; -- 200 & 750
    cke_flag <= '0', '1' after 750us; 

    ddr3_reset_n <= '0' when rstn_flag = '0' else ddr_rstn;
    ddr3_cke <= "0" when cke_flag = '0' else ddr_cke;

    
    wait for 3us;
end process;

boot_proc : process (sys_clock)
begin

    if rising_edge(sys_clock) and cpuCS = '0' then
    if boot_rom = '1'  then
            
            -- setup boot details
            
            if cpuAddress = x"0000" then
                  cpuDataIn <= initial_stack(31 downto 16);
	        elsif cpuAddress = x"0002" then
	              cpuDataIn <= initial_stack(15 downto 0); 
	        elsif cpuAddress = x"0004" then
	              cpuDataIn <= initial_pc(31 downto 16);
	        elsif cpuAddress = x"0006" then
                  cpuDataIn <= initial_pc(15 downto 0);
            end if;

	           
            if cpuAddress > x"0008" then 
                boot_rom <= '0';
            elsif resetn = '0' then
                boot_rom <= '1';
            end if;
            
            ram_ack <= '1';

    else
            cpuDataIn <= memDataOut;
            ram_ack <= mem_ack or mem_wr_ack;
    end if;

    end if;

end process;

 gd_uart_txd_out <= uart_rxd_out;
 
 computer: entity work.Microcomputer 
    port map (
        
        sys_clk => sys_clock,
        n_reset	=> sys_resetn,
		
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
		
		esp_sts => esp_sts, 
        esp_rxd => esp_rxd,
        esp_txd => esp_txd,
        esp_rden => esp_rden,
        esp_wren => esp_wren,
        
        ps2clk => ps2clk,
        ps2data => ps2data,
        
        gd_gpu_sel => gd_gpu_sel,
        gd_sd_sel => gd_sd_sel,
        gd_daz_sel => gd_daz_sel,
        gd_mosi => gd_mosi,
        gd_miso => gd_miso,
        gd_sclk => gd_sclk,
        
        clk25 => clk25,
        sda => ck_sda, --        // I2C Serial data line, pulled high at board level
        scl => ck_scl

    );
    
    sda_pup <= '1';
    scl_pup <= '1';

    --serial
    
    io_serial_term_tx: serial_wrapper 
        port map (
        sys_clk => sys_clock,
        tx_data => serialTermTxData,
        tx_wr_en => serialTermTxWrite_en,
        cts => open,
        rts => open,
        reset_n => sys_resetn,
        txd => uart_rxd_out,
        tx_send_active => serialTermTxActive
  );
  
  gd_uart_txd_out <= uart_rxd_out;
  
  io_serial_term_rx : entity work.design_1_wrapper
    port map (
      LED => open,
      rd_en => serialTermRead_en,
      m68_rxd => serialTermRxData,
      rd_clk => sys_clock,
      reset_n => sys_resetn,
      rxd1 => uart_txd_in,
      rd_data_cnt(8 downto 1) => rx_count,
      rd_data_cnt(0) => rx_data_trigger,
      clk100_i => sys_clock,
      cts => open,
      rts => open
    );  
    
    
    -- esp
--    		esp_sts => esp_sts, 
--        esp_rxd => esp_rxd,
--        esp_txd => esp_txd,
--        esp_rden => esp_rden,
--        esp_wren => esp_wren
    
    esp_serial_term_tx: serial_wrapper 
        port map (
        sys_clk => sys_clock,
        tx_data => esp_txd,
        tx_wr_en => esp_wren,
        cts => open,
        rts => open,
        reset_n => sys_resetn,
        txd => txd3,
        tx_send_active => esp_tx_act
  );
  
  esp_serial_term_rx : design_1_wrapper
    port map (
      LED => open,
      rd_en => esp_rden,
      m68_rxd => esp_rxd,
      rd_clk => sys_clock,
      reset_n => sys_resetn,
      rxd1 => rxd3,
      rd_data_cnt(8 downto 1) => esp_rx_count,
      rd_data_cnt(0) => esp_rx_act,
      clk100_i => sys_clock,
      cts => open,
      rts => open
    );  
    
    
    io_serial_load : design_1_wrapper
    port map (
      LED => open,
      rd_en => serialRead_en,
      m68_rxd => serialData,
      rd_clk => sys_clock,
      reset_n => sys_resetn,
      rxd1 => rxd2,
      rd_data_cnt(8 downto 1) => count,
      rd_data_cnt(0) => data_trigger,
      clk100_i => sys_clock,
      cts => open,
      rts => open
    );  
    
    mem_i_valid <= ((not cpuCS) and (not ( cpuLower and CpuUpper))) and (not boot_rom) and (not cpuAS);
    
    valid_flag: process (sys_clock)
    begin

    if rising_edge(sys_clock) then
        if (i_valid_count = 0) and (mem_i_valid = '1') then
            mem_i_valid_p <= '1';
            i_valid_count <= i_valid_count+1;
        elsif (i_valid_count = 1) then
            mem_i_valid_p <= '1';
            i_valid_count <= 2;
        else 
            mem_i_valid_p <= '0';
            i_valid_count <= 0;
        end if;
    end if;

    end process;
    
 memory:  main_memory_control
    port map(
    sys_clock => sys_clock,      
    sys_resetn => resetn and clk_locked,    
    clock166 => clk166,
    clock200 => clk200,    
     --// SRAM like interface ////
    -- cpu (Fast memory)
    address(27) => '0',  -- // Address bus (Upper part not used)
    address(26 downto 4) => cpuAddress(23 downto 1), --ignore last digit. always 0
    address(3 downto 0) => "0000",
    i_cen =>  cpuCS or boot_rom, --     // Chip select active low
    i_valid_p => mem_i_valid_p, --//valid input active high
    wr_byte_mask(1) => not cpuUpper, --     // Low byte [0:7]
    wr_byte_mask(0) => not cpuLower,
    i_wren => cpuWriteEn, --     // Write enable
    wr_data => cpuDataOut, --     // Data to write
    rd_data => memDataOut, --     // Data to read
    o_valid_p => mem_ack ,--  // Transaction ready
    wr_ack_p => mem_wr_ack, 
      o_ready_p => open,
    --//// SDRAM DDR3 ////
    --// DDR3 Inouts
      ddr3_sdram_addr   => ddr3_addr,
      ddr3_sdram_ba  => ddr3_ba,
      ddr3_sdram_ras_n => ddr3_ras_n,
      ddr3_sdram_cas_n  => ddr3_cas_n,
      ddr3_sdram_we_n  => ddr3_we_n,
      ddr3_sdram_ck_p => ddr3_ck_p,
      ddr3_sdram_ck_n => ddr3_ck_n,
      ddr3_sdram_cke  => ddr_cke,
      ddr3_sdram_dm => ddr3_dm,
      ddr3_sdram_odt => ddr3_odt,--            : out   std_logic_vector(0 downto 0);
      ddr3_sdram_dq => ddr3_dq,--             : inout std_logic_vector(15 downto 0);
      ddr3_sdram_dqs_p  => ddr3_dqs_p,--         : inout std_logic_vector(1 downto 0);
      ddr3_sdram_dqs_n  => ddr3_dqs_n ,--       : inout std_logic_vector(1 downto 0)
      ddr3_sdram_cs_n => ddr3_cs_n,
      ddr3_sdram_reset_n => ddr_rstn,
        
      init_calib_complete => mem_ready
    );
    
   led(0) <= mem_ready;
   serialTermStatus(0) <= '1' when rx_count > x"00" else '0';
   serialTermStatus(1) <= '1' when serialTermTxActive = '0' else '0';
   serialStatus(0) <= '1' when count > x"00" else '0';
   
   esp_sts(0) <= '1' when esp_rx_count > x"00" else '0';
   esp_sts(1) <= '1' when esp_tx_act = '0' else '0';

end Behavioral;