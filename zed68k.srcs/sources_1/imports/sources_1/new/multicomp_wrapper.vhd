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
      
      --dazzler
      
        gd_uart_txd_out : out   std_logic;                  -- gd uart out
        gd_gpu_sel : out std_logic;
        gd_sd_sel : out std_logic;
        gd_daz_sel : out std_logic;
        gd_mosi : out std_logic;
        gd_miso : in std_logic;
        gd_sclk  : out std_logic;
        
         SD_CSn: inout std_logic; -- #IO_L14P_T2_SRCC_35 Sch=sd_reset or DAT3
         SD_CD : in std_logic;  --#IO_L9N_T1_DQS_AD7N_35 Sch=sd_cd
         SD_SCK : out std_logic; --
         SD_CMD : out std_logic; -- #IO_L16N_T2_35 Sch=sd_cmd
         SD_DAT0 : in std_logic; -- #IO_L16P_T2_35 Sch=sd_dat[0]
         SD_DAT1 : inout std_logic;-- #IO_L18N_T2_35 Sch=sd_dat[1]
         SD_DAT2: inout std_logic;-- #IO_L18P_T2_35 Sch=sd_dat[2]
         SD_WP : inout std_logic;--
        
        sw : in std_logic_vector(3 downto 0);
        

    scl_pup : out STD_LOGIC;
    sda_pup : out STD_LOGIC;
    ck_scl : inout STD_LOGIC;
    ck_sda : inout STD_LOGIC;
    
    eth_mdc : out STD_LOGIC;
    eth_mdio : inout STD_LOGIC;
    eth_col : in STD_LOGIC;
    eth_crs : in STD_LOGIC;
    eth_rstn : out STD_LOGIC;
    eth_rx_clk : in STD_LOGIC;
    eth_rx_dv : in STD_LOGIC;
    eth_rxerr : in STD_LOGIC;
    eth_rxd : in STD_LOGIC_VECTOR ( 3 downto 0 );
    eth_tx_clk : in STD_LOGIC;
    eth_tx_en : out STD_LOGIC;
    eth_txd : out STD_LOGIC_VECTOR ( 3 downto 0 );
    eth_ref_clk : out STD_LOGIC;
    
    op_a0 : out std_logic;
    op_a1 : out std_logic;
    op_a2 : out std_logic;
    op_wr : out std_logic;
    op_ic : out std_logic;
    op_mosi : out std_logic;
    op_sck :out std_logic;
    
    ps2_data : inout std_logic;
    ps2_clock : inout std_logic;
    
            -- SPI Flash Mem
     qspi_cs         : out std_logic;        
     qspi_dq         : inout std_logic_vector(3 downto 0);   -- dg(0) is MOSI, dq(1) MISO
     qspi_sck        : out std_logic
     
      
	);
end multicomp_wrapper;

architecture Behavioral of multicomp_wrapper is

    signal boot_rom : std_logic := '1';

   -- RAM interface

     signal i_valid_count: integer := 0;
     signal mem_resetn :std_logic;
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
      
    signal ddr_cke : std_logic_vector(0 downto 0);
    signal ddr_rstn : std_logic;
    signal rstn_flag : std_logic := '0';
    signal cke_flag :std_logic :='0';
    
    signal mem_i_valid : std_logic;
    signal mem_i_valid_p : std_logic;

      signal ramDataOut: std_logic_vector(15 downto 0);
      signal initial_stack: std_logic_vector(31 downto 0) := x"00DF0000";
      signal initial_pc: std_logic_vector(31 downto 0) := x"00E00BC0";
      
      signal memDataOut: std_logic_vector(15 downto 0);
      signal mem_ack:std_logic;
      signal mem_wr_ack : std_logic;
    
-- clocks 

    signal clk50 : std_logic;
    signal reset: std_logic;
    signal clk_locked: std_logic := '0';
          signal sys_resetn : std_logic;
      signal sys_clock100 : STD_LOGIC;
    signal clk166 : std_logic;
    signal clk200: std_logic := '0';
      
      --GD spi
      
    signal spi_ctrl : std_logic_vector(7 downto 0); -- 0-2 address - 3 enable - 5 busy/ready 4-opl
    signal spi_DataIn :  std_logic_vector(7 downto 0);
    signal spi_DataOut :  std_logic_vector(7 downto 0);

    -- sd
    
    signal sdCardDataOut				: std_logic_vector(7 downto 0);
    signal sdCardDataIn				: std_logic_vector(7 downto 0);
    signal sdStatus: std_logic_vector(7 downto 0) := (others => '0'); --f30009
    signal sdControl: std_logic_vector(7 downto 0); --f3000a
    signal sdAddress: std_logic_vector(31 downto 0) := (others => '0'); --f30000-2
    signal sdEraseCount: std_logic_vector(7 downto 0);
    signal sd_rden : std_logic;
    signal sd_wren : std_logic;

--net
      signal eth_ack_rx: std_logic;
    
    signal eth_data_in : std_logic_vector(7 downto 0);
    signal eth_data_out : std_logic_vector(7 downto 0);
    signal eth_ctl :std_logic_vector(7 downto 0);
    signal eth_clk :std_logic;
    signal eth_tx_free : std_logic_vector(15 downto 0);
    signal eth_rx_count : std_logic_vector(15 downto 0);
    signal eth_intr : std_logic;
    
    signal opl3_ctl :std_logic_vector(7 downto 0);
    signal opl3_DataOut : std_logic_vector(7 downto 0);
    
    
    signal ps2k_clk_in: std_logic;
	signal ps2k_dat_in : std_logic;
	signal ps2k_clk_out : std_logic;
	signal ps2k_dat_out : std_logic;

    
   -- components
    
component ethernet is
Port (
    eth_clk : in std_logic;
    sys_resetn : in std_logic;
    
    --cpu data
    eth_data_in : in std_logic_vector(7 downto 0);
    eth_data_out : out std_logic_vector(7 downto 0);
    eth_ctl : inout std_logic_vector(7 downto 0);
    eth_ack_rx: out std_logic;
    
    --phy
    eth_mdc : out STD_LOGIC;
    eth_mdio : inout STD_LOGIC;
    eth_col : in STD_LOGIC;
    eth_crs : in STD_LOGIC;
    eth_rstn : out STD_LOGIC;
    eth_rx_clk : in STD_LOGIC;
    eth_rx_dv : in STD_LOGIC;
    eth_rxerr : in STD_LOGIC;
    eth_rxd : in STD_LOGIC_VECTOR ( 3 downto 0 );
    eth_tx_clk : in STD_LOGIC;
    eth_tx_en : out STD_LOGIC;
    eth_txd : out STD_LOGIC_VECTOR ( 3 downto 0 );
    eth_ref_clk : out STD_LOGIC;
            --SPI/Boot Control
        SPI_CSn         : out std_logic; --Chip select
        SPI_SCK         : out std_logic; --Serial clock
        SPI_MOSI        : out std_logic; --Master out slave in
        SPI_MISO        : in  std_logic; --Master in slave out
    eth_intr : out STD_LOGIC

 );
end component;
    
    component pll
    port ( 
        resetn  : in std_logic;
        clk_in : in std_logic;
        locked : out std_logic;
        clk200  : out std_logic;
        clk166 : out std_logic;
        clk50: out std_logic;
        eth_clk :out std_logic
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

attribute dont_touch : string;

attribute dont_touch of reset_proc : label is "true";
attribute dont_touch of valid_flag : label is "true";
attribute dont_touch of mem_i_valid : signal is "true";
attribute dont_touch of mem_i_valid_p : signal is "true";


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
        clk50 => clk50,
        eth_clk => eth_clk
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

 --gd_uart_txd_out <= uart_rxd_out;
 
 computer: entity work.Microcomputer 
    port map (
        
        sys_clk => sys_clock,
        n_reset	=> sys_resetn,

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
		
        gd_gpu_sel => gd_gpu_sel,
        gd_sd_sel => open,
        gd_daz_sel => gd_daz_sel,
        
        sda => ck_sda, --        // I2C Serial data line, pulled high at board level
        scl => ck_scl,
        
        spi_ctrl => spi_ctrl, -- 0-2 address - 3 enable - 4 busy/ready
        spi_DataIn => spi_DataIn,
        spi_DataOut => spi_DataOut,
        
        -- sd
        sdCardDataOut => sdCardDataOut,
        sdCardDataIn => sdCardDataIn,
        sdAddress => sdAddress,
        sdStatus => sdStatus,
        sdControl => sdControl,
        sdEraseCount => sdEraseCount,
        
        --ethernet
        eth_data_out => eth_data_out,
        eth_data_in => eth_data_in,
        eth_ctl => eth_ctl,
        eth_ack_rx => eth_ack_rx,
        
        opl3_ctl => opl3_ctl,
        opl3_DataOut => opl3_DataOut,
        
        eth_tx_free => eth_tx_free,
        eth_rx_count => eth_rx_count,
        eth_intr => eth_intr,

        --ps2
        ps2k_clk_in => ps2k_clk_in,
		ps2k_dat_in => ps2k_dat_in,
		ps2k_clk_out => ps2k_clk_out,
		ps2k_dat_out => ps2k_dat_out,
		ps2m_clk_in => '0',
		ps2m_dat_in => '0',
		ps2m_clk_out => open,
		ps2m_dat_out => open
    );
    
    ps2switch: entity work.PS2Switch
    port map (
        mode_s => '0',
        -- keyboard ps/2 block
        kbd_clk_in  => ps2k_clk_out,
        kbd_clk_out  => ps2k_clk_in,
        kbd_data_in => ps2k_dat_out,
        kbd_data_out => ps2k_dat_in,
        -- mouse ps/2 block
        mouse_clk_in   => '0',
        mouse_clk_out  => open,
        mouse_data_in  => '0',
        mouse_data_out => open,
        --port A
        prtA_clk  => ps2_clock,
        prtA_data => ps2_data,
        --port B
        prtB_clk  => open,
        prtB_data => open
    );
    
    sda_pup <= '1';
    scl_pup <= '1';

    --serial
    
    gameduino_spi: entity work.spi_master 
  PORT map (
      clk_i      => sys_clock,
      rst_i      => not sys_resetn, 

      -- CPU interface
      valid_i    => spi_ctrl(3),
      ready_o    => spi_ctrl(5),
      data_i     => spi_DataOut,
      data_o     => spi_DataIn,

      -- Connect to SD card
      spi_sclk_o => gd_sclk,       -- sd_sck_io
      spi_mosi_o => gd_mosi,       -- sd_cmd_io
      spi_miso_i => gd_miso        -- sd_dat_io(0)
   );
    
    opl3_spi: entity work.spi_master 
  PORT map (
      clk_i      => sys_clock,
      rst_i      => not sys_resetn, 

      -- CPU interface
      valid_i    => opl3_ctl(5),
      ready_o    => opl3_ctl(6),
      data_i     => opl3_DataOut,
      data_o     => open,

      -- Connect to SD card
      spi_sclk_o => op_sck,       -- sd_sck_io
      spi_mosi_o => op_mosi,       -- sd_cmd_io
      spi_miso_i => '0'       -- sd_dat_io(0)
   );
   
   op_a0 <= opl3_ctl(0);
   op_a1 <= opl3_ctl(1);
   op_a2 <= opl3_ctl(2);
   op_ic <= opl3_ctl(3);
   op_wr <= opl3_ctl(4);
   
      -- sd 
      sd_rden <= sdControl(2);
      sd_wren <= sdControl(3);       
       --spi mode please.
         
       SD_DAT1 <= '1';
       SD_DAT2 <= '1';
       LED(1) <= not SD_CD; -- disk light


sdcard: entity work.sd_controller 
    port map   (
	cs =>   SD_CSn ,			-- To SD card
	mosi => SD_CMD,			-- To SD card
	miso => SD_DAT0,			-- From SD card 
	sclk => SD_SCK,			-- To SD card
	card_present => not SD_CD,	-- From socket - can be fixed to '1' if no switch is present
	card_write_prot => '0',	-- From socket - can be fixed to '0' if no switch is present, or '1' to make a Read-Only interface

	rd => sd_rden,				-- Trigger single block read
	rd_multiple => sdControl(4),		-- Trigger multiple block read
	dout => sdCardDataOut,	-- Data from SD card
	dout_avail => sdStatus(4),		-- Set when dout is valid
	dout_taken => sdControl(1),		-- Acknowledgement for dout
	
	wr => sd_wren,				-- Trigger single block write
	wr_multiple => sdControl(5),		-- Trigger multiple block write
	din => sdCardDataIn,	-- Data to SD card
	din_valid => sdControl(0),		-- Set when din is valid
	din_taken => sdStatus(3),		-- Ackowledgement for din
	
	addr => sdAddress,	-- Block address
	erase_count => sdEraseCount, -- For wr_multiple only

	sd_error => sdStatus(0),		-- '1' if an error occurs, reset on next RD or WR (just check for error code)
	sd_busy => sdStatus(5),		-- '0' if a RD or WR can be accepted
	sd_error_code => open, -- See above, 000=No error

	reset => not sys_resetn,	-- System reset
	clk => clk50,		-- twice the SPI clk (max 50MHz)
	
	-- Optional debug outputs
	sd_type => sdStatus(7 downto 6),	-- Card status (see above)
	sd_fsm => open -- FSM state (see block at end of file)
);
    
    -- memory
    
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
    
-- ethernet
ethernet_FSM: ethernet 
Port map ( 
    eth_clk => eth_clk,
    sys_resetn => sys_resetn,
    
    --cpu data
    eth_data_in => eth_data_in,
    eth_data_out => eth_data_out,
    eth_ctl => eth_ctl,
    eth_ack_rx => eth_ack_rx,
    
    --phy
    eth_mdc => eth_mdc,
    eth_mdio => eth_mdio,
    eth_col => eth_col,
    eth_crs => eth_crs,
    eth_rstn => eth_rstn,
    eth_rx_clk => eth_rx_clk,
    eth_rx_dv => eth_rx_dv,
    eth_rxerr => eth_rxerr,
    eth_rxd => eth_rxd,
    eth_tx_clk => eth_tx_clk,
    eth_tx_en => eth_tx_en,
    eth_txd => eth_txd,
    eth_ref_clk  => eth_ref_clk,
    --SPI/Boot Control
        SPI_CSn         => open, --qspi_cs,
        SPI_SCK         => open, --qspi_sck, --??qspi_sck,
        SPI_MOSI        => open, --qspi_dq(0),
        SPI_MISO        => '0', --qspi_dq(1),
    eth_intr => eth_intr
 );

    --opl
    
    op_a0 <= opl3_ctl(0);
    op_a1 <= opl3_ctl(1);
    op_a2 <= opl3_ctl(2);
    op_ic <= opl3_ctl(3);
    op_wr <= opl3_ctl(4);
    
    
   led(0) <= mem_ready;

end Behavioral;