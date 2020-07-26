library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std_unsigned.all;

entity main_tb is
end main_tb;

architecture structural of main_tb is

   -- Clock
   signal main_clk  : std_logic;
   signal reset : std_logic := '0' ;

   signal LED : STD_LOGIC_VECTOR ( 15 downto 0 );

   signal qspi_flash_io0_io :  STD_LOGIC;
   signal qspi_flash_io1_io :  STD_LOGIC;
   signal qspi_flash_io2_io :  STD_LOGIC;
   signal qspi_flash_io3_io :  STD_LOGIC;
    signal qspi_flash_ss_io :  STD_LOGIC;
    signal usb_uart_rxd :  STD_LOGIC := '0';
    signal usb_uart_txd :  STD_LOGIC;
    
       
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
      wait for 10 ns;
   end process main_clk_proc;

    serial: process
    begin
        wait for 100900 ns;
        wait until rising_edge(main_clk);
        UART_WRITE_BYTE(X"3F", usb_uart_rxd);
        wait until rising_edge(main_clk);
        UART_WRITE_BYTE(X"3F", usb_uart_rxd);
        wait until rising_edge(main_clk);
        UART_WRITE_BYTE(X"3F", usb_uart_rxd);        
    end process serial;
   --------------------------------------------------
   -- Instantiate MAIN
   --------------------------------------------------

   main_inst : entity work.multicomp_wrapper

   port map (
        sys_clock => main_clk,
        resetn => not reset,
		videoR0	=> open,
		videoG0	=> open,
		videoB0	=> open,
		videoR1	=> open,
		videoG1 => open,
		videoB1 => open,
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
        txd1 => open
   ); -- main_inst
   

  
end architecture structural;




