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
        resetn <= '0', '1' after 25ns;
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

   main_inst : entity work.multicomp_wrapper

   port map (
        sys_clock => main_clk,
        resetn => resetn,
        
                VGA_R      => open,
        VGA_G      => open,
        VGA_B     => open,
		hSync	=> open,
		vSync	=> open,

		ps2Clk	=> open,
		ps2Data	=> open,
		
		SD_RESET => open, -- #IO_L14P_T2_SRCC_35 Sch=sd_reset
         SD_CD => '1',  --#IO_L9N_T1_DQS_AD7N_35 Sch=sd_cd
         SD_SCK => open, --
         SD_CMD => open, -- #IO_L16N_T2_35 Sch=sd_cmd
         SD_DAT0  => '0', -- #IO_L16P_T2_35 Sch=sd_dat[0]
         SD_DAT1 => open, -- #IO_L18N_T2_35 Sch=sd_dat[1]
         SD_DAT2 => open,-- #IO_L18P_T2_35 Sch=sd_dat[2]
         SD_DAT3 => open,

         LED => open,
        
        rxd1 => usb_uart_rxd,
        txd1 => open,
        cts1 => '0',
        rts1 => open,
        rxd2 => '0',
        
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
      ddr2_dqs_n           => ddr2_dqs_n,
      AUD_PWM              => open,
      AUD_SD               => open
   ); -- main_inst
   

  
end architecture structural;




