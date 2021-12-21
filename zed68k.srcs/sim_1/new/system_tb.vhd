library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std_unsigned.all;

entity main_tb is
end main_tb;

architecture structural of main_tb is

   -- Clock
   signal main_clk  : std_logic;
   signal resetn : std_logic := '0' ;

   signal LED : STD_LOGIC_VECTOR ( 15 downto 0 );


    signal usb_uart_rxd :  STD_LOGIC := '0';
    signal usb_uart_txd :  STD_LOGIC;
    signal ddr3_addr            :    std_logic_vector(13 downto 0);
    signal  ddr3_ba              :    std_logic_vector(2 downto 0);
    signal  ddr3_ras_n           :    std_logic;
    signal  ddr3_cas_n           :    std_logic;
    signal  ddr3_we_n            :    std_logic;
    signal  ddr3_ck_p            :    std_logic_vector(0 downto 0);
    signal  ddr3_ck_n            :    std_logic_vector(0 downto 0);
    signal  ddr3_cke             :    std_logic_vector(0 downto 0);
    signal  ddr3_dm              :    std_logic_vector(1 downto 0);
    signal  ddr3_odt             :    std_logic_vector(0 downto 0);
    signal  ddr3_dq              :  std_logic_vector(15 downto 0);
    signal  ddr3_dqs_p           :  std_logic_vector(1 downto 0);
    signal  ddr3_dqs_n           :  std_logic_vector(1 downto 0);
    
    signal ddr3_cs_n: std_logic;
    
    signal start : std_logic := '0';
    signal ddr_rst: std_logic := '0';
    component ddr3_model
    port (
    rst_n : in std_logic;
        ck : in std_logic_vector(0 downto 0);
        ck_n : in std_logic_vector(0 downto 0);
        cke : in std_logic_vector(0 downto 0);
        cs_n : in std_logic;
        ras_n : in std_logic;
        cas_n : in std_logic;
        we_n : in std_logic;
        dm_tdqs : inout std_logic_vector(1 downto 0);
        ba : in    std_logic_vector(2 downto 0);
        addr : in std_logic_vector(13 downto 0);
        dq : inout std_logic_vector(15 downto 0);
        dqs : inout std_logic_vector(1 downto 0);
        dqs_n : inout std_logic_vector(1 downto 0);
        tdqs_n : out std_logic_vector(1 downto 0);
        odt : in std_logic_vector(0 downto 0)
        );
   end component;
    
       
   -- Low-level byte-write
  procedure UART_WRITE_BYTE (
    i_Data_In       : in  std_logic_vector(7 downto 0);
    signal o_Serial : out std_logic) is
  begin

    -- Send Start Bit
    o_Serial <= '0';
    wait for 8600 ns;

    -- Send Data Byte
    for ii in 0 to 7 loop
      o_Serial <= i_Data_In(ii);
      wait for 8600 ns;
    end loop;  -- ii

    -- Send Stop Bit
    o_Serial <= '1';
    wait for 8600 ns;
  end UART_WRITE_BYTE;
    
begin
   
   --------------------------------------------------
   -- Generate clock
   --------------------------------------------------

   -- Generate clock
   main_clk_proc : process
   begin
      main_clk <= '1', '0' after 5 ns; -- 100 MHz
      
      if start = '0' then
        resetn <= '0', '1' after 10us;
        start <= '1';
      end if;
      
      wait for 10 ns;
   end process main_clk_proc;
   
   

--    serial: process
--    begin
--        wait for 100900 ns;
--        wait until rising_edge(main_clk);
--        UART_WRITE_BYTE(X"3F", usb_uart_rxd);
--        wait until rising_edge(main_clk);
--        UART_WRITE_BYTE(X"3F", usb_uart_rxd);
--        wait until rising_edge(main_clk);
--        UART_WRITE_BYTE(X"3F", usb_uart_rxd);        
--    end process serial;

--rst_n,
--    ck,
--    ck_n,
--    cke,
--    cs_n,
--    ras_n,
--    cas_n,
--    we_n,
--    dm_tdqs,
--    ba,
--    addr,
--    dq,
--    dqs,
--    dqs_n,
--    tdqs_n,
--    odt
    fake_ddr3: ddr3_model 
    port map (
    rst_n => ddr_rst,
        ck => ddr3_ck_p,
        ck_n => ddr3_ck_n,
        cke => ddr3_cke,
        cs_n => ddr3_cs_n,
        ras_n => ddr3_ras_n,
        cas_n => ddr3_cas_n,
        we_n => ddr3_we_n,
        dm_tdqs => ddr3_dm,
        ba => ddr3_ba,
        addr => ddr3_addr,
        dq => ddr3_dq,
        dqs => ddr3_dqs_p,
        dqs_n => ddr3_dqs_n,
        tdqs_n  => open,
        odt => ddr3_odt
        );

   --------------------------------------------------
   -- Instantiate MAIN
   --------------------------------------------------

   main_inst : entity work.multicomp_wrapper

   port map (
        sys_clock => main_clk,
        resetn => resetn,
        ddr3_reset_n => ddr_rst,
        ddr3_cs_n => ddr3_cs_n,
 
         LED => open,
              -- ddr3 interface
      ddr3_addr            => ddr3_addr,
      ddr3_ba              => ddr3_ba,
      ddr3_ras_n           => ddr3_ras_n,
      ddr3_cas_n           => ddr3_cas_n,
      ddr3_we_n            => ddr3_we_n,
      ddr3_ck_p            => ddr3_ck_p,
      ddr3_ck_n            => ddr3_ck_n,
      ddr3_cke             => ddr3_cke,
      ddr3_dm              => ddr3_dm,
      ddr3_dq             => ddr3_dq,
      ddr3_odt             => ddr3_odt,
      ddr3_dqs_p           => ddr3_dqs_p,
      ddr3_dqs_n           => ddr3_dqs_n,
      
        
      --dazzler
      
        gd_uart_txd_out => OPEN,                -- gd uart out
        gd_gpu_sel => OPEN,  
        gd_sd_sel => OPEN,  
        gd_daz_sel => OPEN,  
        gd_mosi => OPEN,  
        gd_miso => '0',
        gd_sclk  => OPEN,  
        
         SD_CSn => OPEN, -- #IO_L14P_T2_SRCC_35 Sch=sd_reset or DAT3
         SD_CD => '0',  --#IO_L9N_T1_DQS_AD7N_35 Sch=sd_cd
         SD_SCK => OPEN,  --
         SD_CMD => OPEN,   -- #IO_L16N_T2_35 Sch=sd_cmd
         SD_DAT0 => '0',-- #IO_L16P_T2_35 Sch=sd_dat[0]
         SD_DAT1 => OPEN,  -- #IO_L18N_T2_35 Sch=sd_dat[1]
         SD_DAT2 => OPEN,  -- #IO_L18P_T2_35 Sch=sd_dat[2]
         SD_WP => OPEN,  
        
        sw => "0000",
        

    scl_pup => OPEN,  
    sda_pup => OPEN,  
    ck_scl => OPEN,  
    ck_sda => OPEN,  
    
    eth_mdc => OPEN, 
    eth_mdio => OPEN, 
    eth_col => '0', 
    eth_crs  => '0', 
    eth_rstn  => OPEN, 
    eth_rx_clk  => '0',
    eth_rx_dv  => '0',
    eth_rxerr  => '0',
    eth_rxd  => "0000",
    eth_tx_clk  => '0', 
    eth_tx_en  => OPEN, 
    eth_txd => OPEN, 
    eth_ref_clk => OPEN, 
    
    op_a0 => OPEN, 
    op_a1 => OPEN, 
    op_a2 => OPEN, 
    op_wr => OPEN, 
    op_ic => OPEN, 
    op_mosi => OPEN, 
    op_sck => OPEN, 
    
    ps2_data => OPEN, 
    ps2_clock => OPEN, 
    
    esp_cts => '0', 
    esp_txd => OPEN, 
    esp_rxd  => '0', 
    esp_rts => OPEN 

   ); -- main_inst
   

  
end architecture structural;


