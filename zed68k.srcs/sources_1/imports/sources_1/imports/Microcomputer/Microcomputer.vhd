-- This file is copyright by Grant Searle 2014
-- You are free to use this file in your own projects but must never charge for it nor use it without
-- acknowledgement.
-- Please ask permission from Grant Searle before republishing elsewhere.
-- If you use this file or any part of it, please add an acknowledgement to myself and
-- a link back to my main web site http://searle.hostei.com/grant/    
-- and to the "multicomp" page at http://searle.hostei.com/grant/Multicomp/index.html
--
-- Please check on the above web pages to see if there are any updates before using this file.
-- If for some reason the page is no longer available, please search for "Grant Searle"
-- on the internet to see if I have moved to another web hosting service.
--
-- Grant Searle
-- eMail address available on my main web page link above.

library ieee;
use ieee.std_logic_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.numeric_std.all;

entity Microcomputer is
	port(
	    sys_clk     : in std_logic;
		n_reset		: in std_logic;
		cpu_as      : out std_logic; -- Address strobe
		
-- terminal

        serialTerminalStatus: in std_logic_vector(7 downto 0);
        
		rx_serialRead_en : out std_logic;
        serialRxData: in std_logic_vector(7 downto 0);
        
        tx_serialWrite_en : out std_logic;
        serialTxData: out std_logic_vector(7 downto 0);

-- srec		
		serialRead_en : out std_logic;
        serialStatus: in std_logic_vector(7 downto 0);
        serialData: in std_logic_vector(7 downto 0);
        
        
              -- RAM interface
      ram_a                : out    std_logic_vector(26 downto 0);
      ram_dq_i             : out    std_logic_vector(15 downto 0);
      ram_dq_o             : in   std_logic_vector(15 downto 0);
      ram_cen              : out    std_logic;
      ram_oen              : out    std_logic;
      ram_wen              : out    std_logic;
      ram_ub               : out    std_logic;
      ram_lb               : out    std_logic;
      ram_ack              : in     std_logic;
		
		-- esp
	    esp_sts : in std_logic_vector(7 downto 0);
        esp_rxd : in std_logic_vector(7 downto 0);
        esp_txd : out std_logic_vector(7 downto 0);
        esp_rden : out std_logic;
        esp_wren : out std_logic;
        
        ps2clk :inout std_logic;
        ps2data :inout std_logic;
        
        gd_gpu_sel : out std_logic;
        gd_sd_sel : out std_logic;
        gd_daz_sel : out std_logic;
        
        clk25 : in std_logic;
        sda :inout std_logic; --        // I2C Serial data line, pulled high at board level
        scl : inout std_logic; -- 
		
		spi_ctrl : inout std_logic_vector(7 downto 0); -- 0-2 address - 3 enable - 4 busy/ready
        spi_DataIn :  inout std_logic_vector(7 downto 0);
        spi_DataOut : inout std_logic_vector(7 downto 0)
    
	);
	
end Microcomputer;

architecture struct of Microcomputer is

	signal basRomData					: std_logic_vector(15 downto 0);
    signal monRomData					: std_logic_vector(15 downto 0);

    signal n_interface2CS			: std_logic :='1';
	signal n_externalRamCS			: std_logic :='1';

	signal n_basRom1CS					: std_logic :='1';
    signal n_basRom2CS					: std_logic :='1';
    signal n_basRom3CS					: std_logic :='1';
    signal n_basRom4CS					: std_logic :='1';


    signal    cpuAddress	    :  std_logic_vector(31 downto 0);
	signal	  cpuDataOut		:  std_logic_vector(15 downto 0);
	signal    cpuDataIn		:  std_logic_vector(15 downto 0);
	signal    memAddress		:  std_logic_vector(15 downto 0);
	signal    vgaAddress        : std_logic_vector(15 downto 0);
	
    signal    cpu_uds :  std_logic; -- upper data strobe
    signal    cpu_lds :  std_logic; -- lower data strobe
    signal    cpu_r_w :   std_logic; -- read(high)/write(low)
    signal    cpu_dtack :  std_logic; -- data transfer acknowledge
    
    
    type t_Vector is array (0 to 10) of std_logic_vector(15 downto 0);
    signal r_vec : t_Vector;
    
    signal vecAddress: integer := 0;

    signal int_out: std_logic_vector(2 downto 0) := "111";
    signal int_ack: std_logic := '0';
    
	signal	timer_int :  std_logic;
	signal	ps2_int :  std_logic;
	signal	spi_int :  std_logic;
	signal mouse_int : std_logic;

    signal key_pressed_ascii : std_logic_vector(7 downto 0);
	signal mouse_data : std_logic_vector(23 downto 0);
	
	signal timerCS : std_logic;
	signal timerDataOut : std_logic_vector(7 downto 0);
	signal timer_reg_sel : std_logic;
	signal milliseconds: std_logic_vector(31 downto 0);
	
	signal keyboardCS : std_logic;
	
	signal rtcCS: std_logic;
	signal rtc_ack :std_logic;
	signal rtc_data : std_logic_vector(55 downto 0);
	
	attribute dont_touch : string;
    attribute dont_touch of rtc : label is "true";
	
	    
	
begin
--interrupts

--interrupts: entity work.interrupt_controller
--	port map (
--		clk => sys_clk,
--		reset => n_reset,
--		int1 => serialTerminalStatus(0),
--		int2 => ps2_int,
--		int3 => '0',
--		int4 => '0',
--		int5 => '0',
--	    int6 => '0',
--		int7 => '0',
--		int_out => int_out,
--		ack => int_ack
--		);


--rtc
  rtc : ENTITY work.pmod_real_time_clock 
  GENERIC map (
    sys_clk_freq => 100_000_000)              --input clock speed from user logic in Hz
  PORT map (
    clk           => sys_clk,                    --system clock
    reset_n      => n_reset,                     --asynchronous active-low reset also only when we need it.
    scl           => scl,                     --I2C serial clock
    sda          => sda,                --I2C serial data
    read_en      => rtcCS,
    i2c_ack_err   => rtc_data(42),                     --I2C slave acknowledge error flag
    set_clk_ena   => '0',                    --set clock enable
    set_seconds   => (others => '0'),  --seconds to set clock to
    set_minutes   => (others => '0'),   --minutes to set clock to
    set_hours     => (others => '0'),   --hours to set clock to
    set_am_pm     => '0',                  --am/pm to set clock to, am = '0', pm = '1'
    set_weekday   => (others => '0'),  --weekday to set clock to
    set_day       => (others => '0'),   --day of month to set clock to
    set_month     => (others => '0'),  --month to set clock to
    set_year      => (others => '0'),   --year to set clock to
    set_leapyear  => '0',                      --specify if setting is a leapyear ('1') or not ('0')
    seconds       => rtc_data(6 DOWNTO 0),  --clock output time: seconds
    minutes       => rtc_data(13 DOWNTO 7),  --clock output time: minutes
    hours         => rtc_data(18 DOWNTO 14),  --clock output time: hours
    am_pm         => rtc_data(19),                    --clock output time: am/pm (am = '0', pm = '1')
    weekday       => rtc_data(22 DOWNTO 20),  --clock output time: weekday
    day           => rtc_data(28 DOWNTO 23),  --clock output time: day of month
    month         => rtc_data(33 DOWNTO 29),  --clock output time: month
    year          => rtc_data(41 DOWNTO 34), --clock output time: year
    valid_o       => rtc_ack
);
		
----f30000/1 keyboard
keyboard: entity work.KeyboardMC 

	port map (
		n_reset	=> n_reset,
		clk    	=> sys_clk,
		n_wr	=> '1',
		n_rd	=> not cpu_r_w and not keyboardCS,
		regSel	=> '1',
		--dataIn	: in  std_logic_vector(7 downto 0);
		dataOut	=>  key_pressed_ascii,
		n_int		=> ps2_int, 
		n_rts		=> open,
		
		-- Keyboard signals
		ps2Clk	=> ps2clk,
		ps2Data	=> ps2data,
 
		-- FN keys passed out as general signals (momentary and toggled versions)
		FNkeys =>open,
		FNtoggledKeys	=> open);

----f30002-26
--mouse: entity work.ps2_mouse 
--	PORT map (
--			clk	=> sys_clk,								--system clock input
--			reset_n	=> n_reset,								--active low asynchronous reset
--			ps2_clk	=> ps2m_clk,							--clock signal from PS2 mouse
--			ps2_data => ps2m_dat,								--data signal from PS2 mouse
--			mouse_data => mouse_data,	--data received from mouse
--			mouse_data_new	=> mouse_int );								--new data packet available flag

--f30030 16 bit millisecond timer

timer: entity work.timer  
	port map ( 
	 clk       => sys_clk,
    rst        => not n_reset,
    cs         => timerCS, 
    addr       => timer_reg_sel,
    rw         => cpu_r_w, 
    data_in    => cpuDataOut(7 downto 0), 
	 data_out  => timerDataOut,
	 count_up_millis => milliseconds,
	 irq        => timer_int
  ); 

 
-- ____________________________________________________________________________________
-- CPU CHOICE GOES HERE
    
cpu1 : entity work.TG68
   port map
	(
		clk => sys_clk,
        reset => n_reset,
        clkena_in => '1',
        data_in => cpuDataIn,   
		IPL => "111", --int_out,	-- For this simple demo we'll ignore interrupts
		dtack => cpu_dtack,
		addr => cpuAddress,
		as => cpu_as,
		data_out => cpuDataOut,
		rw => cpu_r_w,
		uds => cpu_uds,
		lds => cpu_lds
  );
	
	-- rom address
    memAddress <= std_logic_vector(to_unsigned(conv_integer(cpuAddress(15 downto 0)) / 2, memAddress'length)) ;
    
    --gameduino address
    vgaAddress <= std_logic_vector(to_unsigned(conv_integer(cpuAddress(15 downto 0)) / 2, vgaAddress'length)) ;
   
    -- vector address storage
    vecAddress <= conv_integer(cpuAddress(3 downto 0)) / 2 ;
    r_Vec(vecAddress) <= cpuDataOut when cpuAddress(31 downto 16) = X"FFFF" and cpu_r_w = '0' ;
    int_ack <= '1' when cpuAddress(31 downto 16) = X"FFFF" and cpu_r_w = '1' else '0'; -- acknowledge interrupts
    
-- ____________________________________________________________________________________
-- ROM GOES HERE
    
	rom1 : entity work.rom -- 8 
	generic map (
	   G_ADDR_BITS => 13,
	   G_INIT_FILE => "D:/code/zed-68k/roms/monitor/monitor_0.hex"
	)
    port map(
        addr_i => memAddress(12 downto 0),
        clk_i => sys_clk,
        data_o => monRomData(15 downto 8)
    );
    
    rom2 : entity work.rom -- 8 
	generic map (
	   G_ADDR_BITS => 13,
	   G_INIT_FILE => "D:/code/zed-68k/roms/monitor/monitor_1.hex"
	)
    port map(
        addr_i => memAddress(12 downto 0),
        clk_i => sys_clk,
        data_o => monRomData(7 downto 0)
    );
    
    rom3 : entity work.rom -- 8 
	generic map (
	   G_ADDR_BITS => 13,
	   G_INIT_FILE => "D:/code/zed-68k/roms/ehbasic/basic_0.hex"
	)
    port map(
        addr_i => memAddress(12 downto 0),
        clk_i => sys_clk,
        data_o => basRomData(15 downto 8)
    );
    
    rom4 : entity work.rom -- 8 
	generic map (
	   G_ADDR_BITS => 13,
	   G_INIT_FILE => "D:/code/zed-68k/roms/ehbasic/basic_1.hex"
	)
    port map(
        addr_i => memAddress(12 downto 0),
        clk_i => sys_clk,
        data_o => basRomData(7 downto 0)
    );
    
-- ____________________________________________________________________________________
-- CHIP SELECTS GO HERE
  

n_basRom1CS <= '0' when cpu_uds = '0' and cpuAddress(23 downto 20) = "1010" else '1'; --A00000-A0FFFF
n_basRom2CS <= '0' when cpu_lds = '0' and cpuAddress(23 downto 20) = "1010" else '1'; 
n_basRom3CS <= '0' when cpu_uds = '0' and cpuAddress(23 downto 20) = "1011" else '1'; --B00000-B0FFFF
n_basRom4CS <= '0' when cpu_lds = '0' and cpuAddress(23 downto 20) = "1011" else '1'; 
n_interface2CS <= '0' when cpuAddress >= X"C00000" and cpuAddress <= X"CFFFFF" else '1'; --VGA

--terminal
tx_serialWrite_en <= '1' when cpuAddress = X"f0000b"  and cpu_r_w = '0' and cpu_lds = '0' else '0';
rx_serialRead_en <= '1' when cpuAddress = X"f0000b" and cpu_r_w = '1' and cpu_lds = '0'  else '0';
-- srec
serialRead_en <= '1' when cpuAddress = X"f2000b" else '0'; -- f200000

--terminal
esp_wren <= '1' when cpuAddress = X"f3000b"  and cpu_r_w = '0' and cpu_lds = '0' else '0';
esp_rden <= '1' when cpuAddress = X"f3000b" and cpu_r_w = '1' and cpu_lds = '0'  else '0';

--periph
timer_reg_sel <= '1' when cpuAddress >= x"f30000" and cpuAddress < x"f30040" else '0';           

-- RAM
ram_cen <= '0' when  cpuAddress < X"A00000" and n_reset = '1' else '1'; --n_internalRam1CS = '1' andand 
ram_oen <= ram_cen or (not cpu_r_w); -- ram read
ram_wen <= ram_cen or cpu_r_w; -- ram write
ram_a <= cpuAddress(26 downto 0) when ram_cen ='0' else (others => '0'); -- address
ram_ub <= cpu_uds;
ram_lb <= cpu_lds;
ram_dq_i <= cpuDataOut when ram_wen = '0' else (others => '0') ;

--terminal
serialTxData <= cpuDataOut(7 downto 0) when tx_serialWrite_en = '1';
esp_txd <= cpuDataOut(7 downto 0) when esp_wren = '1';

-- spi

spi_ctrl(4)     <= cpuDataOut(4) when (cpuAddress = X"f40008" or cpuAddress = X"f40009")  and cpu_lds = '0' and cpu_r_w = '0';  --cont                  
spi_ctrl(3)     <= cpuDataOut(3) when (cpuAddress = X"f40008" or cpuAddress = X"f40009")  and cpu_lds = '0' and cpu_r_w = '0'; -- enable
spi_ctrl(2 downto 0) <= cpuDataOut(2 downto 0) when (cpuAddress = X"f40008" or cpuAddress = X"f40009") and cpu_lds = '0' and cpu_r_w = '0';                   
spi_dataOut <= cpuDataOut(7 downto 0) when (cpuAddress = X"f4000A" or cpuAddress = X"f4000B") and cpu_lds = '0' and cpu_r_w = '0'; 
gd_gpu_sel <= not spi_ctrl(0);
gd_sd_sel <= not spi_ctrl(1);
gd_daz_sel <= not spi_ctrl(2);

-- timer
timerCS <= '1' when cpuAddress >= x"f30030" and cpuAddress <= x"f30033" else '0';
rtcCS <= '1' when cpuAddress >= x"f30040" and cpuAddress < x"f30048" else '0';
-- keyboard
keyboardCS <= '0' when cpuAddress = x"f30000" else '1';
-- ____________________________________________________________________________________
-- BUS ISOLATION GOES HERE
 
cpuDataIn(15 downto 8) 
<= 
X"00" 
when cpuAddress = X"f30000" and cpu_uds = '0' else
r_Vec(vecAddress)(15 downto 8)
when cpuAddress(31 downto 16) = X"FFFF" and cpu_r_w = '1' else
X"00"
when cpuAddress(31 downto 16) = X"FFFF" and cpu_r_w = '0'  else
monRomData(15 downto 8)
when n_basRom1CS = '0' else
basRomData(15 downto 8)
when n_basRom3CS = '0' else
ram_dq_o(15 downto 8)
when ram_oen = '0' and ram_cen = '0' and cpu_uds = '0' else
x"00"
when cpuAddress >= x"f40008" and cpuAddress <= x"f4000d" and cpu_r_w = '1' and cpu_uds = '0' else
milliseconds(31 downto 24)
when timerCS = '1' and cpuAddress = X"f30030" and cpu_r_w ='1' and cpu_uds = '0' else
milliseconds(15 downto 8)
when timerCS = '1' and cpuAddress = X"f30032" and cpu_r_w ='1' and cpu_uds = '0' else
x"00"
when rtcCS = '1' and cpuAddress = X"f30046" and cpu_r_w ='1' and cpu_uds = '0' else
rtc_data(47 downto 40)
when rtcCS = '1' and cpuAddress = X"f30044" and cpu_r_w ='1' and cpu_uds = '0' else
rtc_data(31 downto 24)
when rtcCS = '1' and cpuAddress = X"f30042" and cpu_r_w ='1' and cpu_uds = '0' else
rtc_data(15 downto 8)
when rtcCS = '1' and cpuAddress = X"f30040" and cpu_r_w ='1' and cpu_uds = '0' else
X"00" when cpu_uds = '1';

cpuDataIn(7 downto 0)
<= 
--vga_rd_data 
--when n_interface2CS = '0' and vga_rd_en = '1' else
monRomData(7 downto 0)
when n_basRom2CS = '0' else 
basRomData(7 downto 0)
when n_basRom4CS = '0' else 
"00000" & cpuAddress(3 downto 1)
when cpuAddress(31 downto 16) = X"FFFF" and cpu_r_w = '0' else 
r_Vec(vecAddress)(7 downto 0)
when cpuAddress(31 downto 16) = X"FFFF" and cpu_r_w = '1' else
serialStatus
when cpuAddress = x"f20009" else
serialData 
when serialRead_en = '1' else 
serialTerminalStatus
when cpuAddress = x"f00009" else
esp_rxd 
when esp_rden = '1' else 
esp_sts
when cpuAddress = x"f30009" else
serialRxData 
when rx_serialRead_en = '1' else 
ram_dq_o(7 downto 0)
when ram_oen = '0' and ram_cen = '0' and cpu_lds = '0' and cpuAddress < x"A00000" else
milliseconds(23 downto 16)
when timerCS = '1' and (cpuAddress = X"f30030" or cpuAddress = X"f30031") and cpu_r_w ='1' and cpu_lds = '0' else
milliseconds(7 downto 0)
when timerCS = '1' and (cpuAddress = X"f30032" or cpuAddress = X"f30033") and cpu_r_w ='1' and cpu_lds = '0' else
key_pressed_ascii 
when cpuAddress = X"f30000" and cpu_r_w ='1' and cpu_lds = '0' else
spi_DataIn
when (cpuAddress = X"F4000C" or cpuAddress = X"F4000D") and cpu_r_w = '1' and cpu_lds = '0' else
spi_DataOut
when (cpuAddress = X"F4000A" or cpuAddress = X"F4000B") and cpu_r_w = '1' and cpu_lds = '0' else
spi_ctrl
when (cpuAddress = X"F40008" or cpuAddress = X"F40009") and cpu_r_w = '1' and cpu_lds = '0' else
rtc_data(55 downto 48)
when rtcCS = '1' and (cpuAddress = X"f30046" or cpuAddress = X"F30047") and cpu_r_w ='1' and cpu_lds = '0' else
rtc_data(39 downto 32)
when rtcCS = '1' and (cpuAddress = X"f30044" or cpuAddress = X"F30045") and cpu_r_w ='1' and cpu_lds = '0' else
rtc_data(23 downto 16)
when rtcCS = '1' and (cpuAddress = X"f30042" or cpuAddress = X"F30043") and cpu_r_w ='1' and cpu_lds = '0' else
rtc_data(7 downto 0)
when rtcCS = '1' and (cpuAddress = X"f30040" or cpuAddress = X"F30041") and cpu_r_w ='1' and cpu_lds = '0' else
X"00" when cpu_lds = '1' ;


cpu_dtack <= 
not ram_ack when ram_cen = '0' else 
not rtc_ack when rtcCS = '1' else
'0';
    
end;