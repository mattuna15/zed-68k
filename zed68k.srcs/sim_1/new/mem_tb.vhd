library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std_unsigned.all;

entity mem_tb is
end mem_tb;


architecture structural of mem_tb is

   -- Clock
   signal main_clk  : std_logic;
   signal resetn : std_logic := '0' ;

   signal LED : STD_LOGIC_VECTOR ( 15 downto 0 );

   signal qspi_flash_io0_io :  STD_LOGIC;
   signal qspi_flash_io1_io :  STD_LOGIC;
   signal qspi_flash_io2_io :  STD_LOGIC;
   signal qspi_flash_io3_io :  STD_LOGIC;
    signal qspi_flash_ss_io :  STD_LOGIC;
    signal usb_uart_rxd :  STD_LOGIC := '0';
    signal usb_uart_txd :  STD_LOGIC;
    signal ddr2_addr            :    std_logic_vector(12 downto 0);
    signal  ddr2_ba              :    std_logic_vector(2 downto 0);
    signal  ddr2_ras_n           :    std_logic;
    signal  ddr2_cas_n           :    std_logic;
    signal  ddr2_we_n            :    std_logic;
    signal  ddr2_ck_p            :    std_logic_vector(0 downto 0);
    signal  ddr2_ck_n            :    std_logic_vector(0 downto 0);
    signal  ddr2_cke             :    std_logic_vector(0 downto 0);
    signal  ddr2_cs_n            :    std_logic_vector(0 downto 0);
    signal  ddr2_dm              :    std_logic_vector(1 downto 0);
    signal  ddr2_odt             :    std_logic_vector(0 downto 0);
    signal  ddr2_dq              :  std_logic_vector(15 downto 0);
    signal  ddr2_dqs_p           :  std_logic_vector(1 downto 0);
    signal  ddr2_dqs_n           :  std_logic_vector(1 downto 0);
    signal ddr2_rdqs_n           :  std_logic_vector(1 downto 0);
    
    signal start : std_logic := '0';
    
        component pll
    port ( 
        resetn  : in std_logic;
        clk_in : in std_logic;
        locked : out std_logic;
        clk100  : out std_logic;
        clk200  : out std_logic;
        clk50  : out std_logic;
        clk25  : out std_logic
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
    
    signal clk50 : std_logic := '0';
    signal clk25 : std_logic := '0';
    signal start_up  : std_logic := '0';
    
    signal serialStatus: std_logic_vector(7 downto 0) := x"00"; 
    signal rxSerialData: std_logic_vector(7 downto 0) := x"00";
    signal serialData: std_logic_vector(7 downto 0) := x"00";
    signal serialRead_en: std_logic := '0';
    signal rxDataReady : std_logic := '0' ;
    
    signal reset: std_logic := '1' ;
    
    signal count: std_logic_vector( 7 downto 0) := x"00";
    signal data_trigger: std_logic := '0';
    signal clk_locked: std_logic := '0';
    signal serialClkCount			: std_logic_vector(15 downto 0) := (others => '0');
    signal serialClock   			: std_logic;

    
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
      
      signal data_width : std_logic_vector(1 downto 0) := "10";
      
begin
   
   --------------------------------------------------
   -- Generate clock
   --------------------------------------------------

   -- Generate clock
   main_clk_proc : process
   begin
      main_clk <= '1', '0' after 5 ns; -- 100 MHz
      
      if start = '0' then
        resetn <= '0', '1' after 25ns;
        start <= '1';
      end if;
      
      wait for 10 ns;
   end process main_clk_proc;
   
    pll1:  pll
    port map (
        clk_in => main_clk,
        resetn  => resetn,
        locked => clk_locked,
        clk100 => sys_clock100,
        clk200 => mem_clock,
        clk50 =>  clk50,
        clk25 => clk25
    );

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

    mem: process
    begin
        
        wait until mem_ready = '1';
        cpuAddress(26 downto 24) <= (others => '0');
        cpuAddress(23 downto 0) <= x"010002";
        cpuDataOut <= x"1234";
        cpuUpper <= '0';
        cpuLower <= '0';
        cpuCS <= '0';
        cpuWriteEn <= '0';
        cpuReadEn <= '1';
        
        wait until ram_ack = '1';
        cpuWriteEn <= '1';
        cpuCS <= '1';
        
        cpuAddress(26 downto 24) <= (others => '0');
        cpuAddress(23 downto 0) <= x"010004";
        cpuDataOut <= x"1200";
        cpuUpper <= '0';
        cpuLower <= '1';
        cpuCS <= '0';
        cpuWriteEn <= '0';
        cpuReadEn <= '1';
        
        wait until ram_ack = '1';
        cpuWriteEn <= '1';
        cpuCS <= '1';
    
    
        cpuAddress(26 downto 24) <= (others => '0');
        cpuAddress(23 downto 0) <= x"010006";
        cpuDataOut <= x"2235";
        cpuUpper <= '1';
        cpuLower <= '0';
        cpuCS <= '0';
        cpuWriteEn <= '0';
        cpuReadEn <= '1';
        
        wait until ram_ack = '1';
        
        cpuAddress(26 downto 24) <= (others => '0');
        cpuAddress(23 downto 0) <= x"010002";
        cpuDataOut <= x"1234";
        cpuUpper <= '0';
        cpuLower <= '0';
        cpuCS <= '0';
        cpuWriteEn <= '1';
        cpuReadEn <= '0';
        
        wait until ram_ack = '1';
        cpuReadEn <= '1';
        cpuCS <= '1';
        
        cpuAddress(26 downto 24) <= (others => '0');
        cpuAddress(23 downto 0) <= x"010004";
        cpuUpper <= '0';
        cpuLower <= '1';
        cpuCS <= '0';
        cpuWriteEn <= '1';
        cpuReadEn <= '0';
        
        wait until ram_ack = '1';
        cpuReadEn <= '1';
        cpuCS <= '1';
    
    
        cpuAddress(26 downto 24) <= (others => '0');
        cpuAddress(23 downto 0) <= x"010006";
        cpuUpper <= '1';
        cpuLower <= '0';
        cpuCS <= '0';
        cpuWriteEn <= '1';
        cpuReadEn <= '0';
        
        wait until ram_ack = '1';
    end process mem;

    fake_ddr2: entity ddr2_model 
    port map (
        ck => ddr2_ck_p,
        ck_n => ddr2_ck_n,
        cke => ddr2_cke,
        cs_n => ddr2_cs_n,
        ras_n => ddr2_ras_n,
        cas_n => ddr2_cas_n,
        we_n => ddr2_we_n,
        dm_rdqs => ddr2_dm,
        ba => ddr2_ba,
        addr => ddr2_addr,
        dq => ddr2_dq,
        dqs => ddr2_dqs_p,
        dqs_n => ddr2_dqs_n,
        rdqs_n  => ddr2_rdqs_n,
        odt => ddr2_odt
        );

   --------------------------------------------------
   -- Instantiate MAIN
   --------------------------------------------------

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

  
end architecture structural;



