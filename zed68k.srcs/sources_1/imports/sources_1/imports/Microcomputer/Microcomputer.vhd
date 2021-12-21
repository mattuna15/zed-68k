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
        
        gd_gpu_sel : out std_logic;
        gd_sd_sel : out std_logic;
        gd_daz_sel : out std_logic;
        
        sda :inout std_logic; --        // I2C Serial data line, pulled high at board level
        scl : inout std_logic; -- 
		
		spi_ctrl : inout std_logic_vector(7 downto 0); -- 0-2 address - 3 enable - 4 busy/ready
        spi_DataIn :  inout std_logic_vector(7 downto 0);
        spi_DataOut : inout std_logic_vector(7 downto 0);
        
        sdCardDataOut				: in std_logic_vector(7 downto 0);
        sdCardDataIn				: out std_logic_vector(7 downto 0);
        sdEraseCount				: out std_logic_vector(7 downto 0);
        sdStatus: inout std_logic_vector(7 downto 0) := (others => '0'); --f30009
        sdControl: inout std_logic_vector(7 downto 0); --f3000a
    
        sdAddress: out std_logic_vector(31 downto 0); --f30000-2
        
        -- ethernet terminal

        eth_data_out : inout std_logic_vector(7 downto 0);
        eth_data_in : inout std_logic_vector(7 downto 0);
        eth_ctl : inout std_logic_vector(7 downto 0);
        eth_tx_free : in std_logic_vector(15 downto 0);
        eth_rx_count : in std_logic_vector(15 downto 0);
        eth_ack_rx : in std_logic;
        eth_intr : in std_logic;
        
        --sound
        opl3_ctl : inout std_logic_vector(7 downto 0);
        opl3_DataOut : inout std_logic_vector(7 downto 0);
        
        -- fram
        
        fram_spi_ctrl : inout std_logic_vector(7 downto 0); -- 0-2 address - 3 enable - 4 busy/ready
        fram_spi_DataIn :  in std_logic_vector(7 downto 0);
        fram_spi_DataOut : out std_logic_vector(7 downto 0);
        
        fram_spi_ctrl2 : inout std_logic_vector(7 downto 0); -- 0-2 address - 3 enable - 4 busy/ready
        fram_spi_DataIn2 :  in std_logic_vector(7 downto 0);
        fram_spi_DataOut2 : out std_logic_vector(7 downto 0);
        
		-- PS/2 keyboard / mouse
		ps2k_clk_in : inout std_logic;
		ps2k_dat_in : inout std_logic;
		
		uartIrq     : in std_logic;
		uartDataOut : out std_logic_vector(7 downto 0);
		uartDataIn  : in std_logic_vector(7 downto 0);
		uartRegSel  : out std_logic;
		uartWRn    : out std_logic;
		uartRDn    : out std_logic;
        uartIdle : in std_logic;
        uartDataAvail : in std_logic;
        
        cpu_r_w : out std_logic;
        cpu_uds : out std_logic;
        cpu_lds : out std_logic
        
	);
	
end Microcomputer;

architecture struct of Microcomputer is

	component fpu_double IS

   PORT( 
      clk, rst, enable : IN     std_logic;
      rmode : IN     std_logic_vector (1 DOWNTO 0);
      fpu_op : IN     std_logic_vector (2 DOWNTO 0);
      opa, opb : IN     std_logic_vector (63 DOWNTO 0);
      out_fp_reg: OUT    std_logic_vector (63 DOWNTO 0);
      idle, valid : OUT  std_logic
   );

	END component;

    signal monRomData					: std_logic_vector(15 downto 0);

	signal n_basRom1CS					: std_logic :='1';
    signal n_basRom2CS					: std_logic :='1';
    
    signal    cpuAddress	    :  std_logic_vector(31 downto 0);
	signal	  cpuDataOut		:  std_logic_vector(15 downto 0);
	signal    cpuDataIn		:  std_logic_vector(15 downto 0);
	signal    memAddress		:  std_logic_vector(15 downto 0);

    signal    cpu_dtack :  std_logic; -- data transfer acknowledge
    signal    cpu_fc : std_logic_vector(2 downto 0);

    signal int_out: std_logic_vector(2 downto 0) := "111";

	signal rtcCS: std_logic;
	signal rtc_ack :std_logic;
	signal rtc_data : std_logic_vector(63 downto 0);

    signal sd_rden : std_logic;
    signal sd_wren : std_logic;
	
	signal timerCS : std_logic;
	signal milliseconds: std_logic_vector(31 downto 0);
	--fpu
	
signal opa_i, opb_i : std_logic_vector(63 downto 0);
signal fpu_op_i		: std_logic_vector(2 downto 0);
signal rmode_i : std_logic_vector(1 downto 0);
signal result_o, result_reg : std_logic_vector(63 downto 0);
signal start_i, idle_o, rd_en, valid_o : std_logic ; 
signal error: std_logic;
signal fpu_sts, fpu_ctl : std_logic_vector(7 downto 0);

signal timer_in1, timer_clk_en, keyb_int : std_logic ;
signal keyb_data : std_logic_vector(7 downto 0);
signal uartIrqEn : std_logic := '0';

signal hiMem,  spiMem, ethMem, uartMem, fpuMem, ioMem, fram1Mem, fram2Mem : std_logic := '0';
signal hiMemRegAddr : std_logic_vector(7 downto 0);
signal auto_iack :std_logic;

component keyboard is
   port (
      clk_i      : in std_logic;

      -- From keyboard
      ps2_clk_i  : in std_logic;
      ps2_data_i : in std_logic;

      -- To computer
      data_o     : out std_logic_vector(7 downto 0);
      irq_o      : out std_logic;

      debug_o    : out std_logic_vector(15 downto 0)
   );
end component;
	
	attribute dont_touch : string; 
    attribute dont_touch of sdAddress : signal is "true";
    attribute dont_touch of sdCardDataIn : signal is "true";
    attribute dont_touch of sdCardDataOut : signal is "true";
    
    attribute dont_touch of hiMem : signal is "true";
    attribute dont_touch of fpuMem : signal is "true";
    attribute dont_touch of ethMem : signal is "true";
    attribute dont_touch of spiMem : signal is "true";
    
begin

interrupts: entity work.interrupt_controller
	port map (
		clk => sys_clk,
		reset => n_reset,
		int1 => timer_in1, -- 100hz
		int2 => keyb_int, 
		int3 => uartIrq and uartIrqEn,
		int4 => '0',
		int5 => '0',
	    int6 => '0',
		int7 => '0',
		int_out => int_out,
		ack => auto_iack
	);
 
    
timer_1 : entity work.timer
port map (clk1 => sys_clk,
      clk100hz => timer_in1,
      int_en => timer_clk_en,
      count_up_millis => milliseconds
     );

keyboard_1 : keyboard 
   port map (
      clk_i     => sys_clk,

      -- From keyboard
      ps2_clk_i  => ps2k_clk_in,
      ps2_data_i => ps2k_dat_in,

      -- To computer
      data_o   => keyb_data,
      irq_o    => keyb_int,

      debug_o  => open
   );

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
    i2c_ack_err   => rtc_data(57),                     --I2C slave acknowledge error flag
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
    minutes       => rtc_data(14 DOWNTO 8),  --clock output time: minutes
    hours         => rtc_data(21 DOWNTO 16),  --clock output time: hours
    am_pm         => rtc_data(56),                    --clock output time: am/pm (am = '0', pm = '1')
    weekday       => rtc_data(26 DOWNTO 24),  --clock output time: weekday
    day           => rtc_data(37 DOWNTO 32),  --clock output time: day of month
    month         => rtc_data(44 DOWNTO 40),  --clock output time: month
    year          => rtc_data(55 DOWNTO 48), --clock output time: year
    valid_o       => rtc_ack
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
		IPL => int_out,	-- For this simple demo we'll ignore interrupts
		dtack => cpu_dtack,
		addr => cpuAddress,
		as => cpu_as,
		data_out => cpuDataOut,
		rw => cpu_r_w,
		uds => cpu_uds,
		lds => cpu_lds,
		fc => cpu_fc
  );

      -- instantiate fpu
    fpu1: fpu_double 
    port map (
			clk => sys_clk,
			rst =>  not n_reset,
			opa => opa_i,
			opb => opb_i,
			fpu_op =>	fpu_op_i,
			rmode => rmode_i,	
			out_fp_reg => result_o,  
        	enable => start_i,
        	idle => idle_o,
        	valid => valid_o
   );

	-- rom address
    memAddress <= std_logic_vector(to_unsigned(conv_integer(cpuAddress(15 downto 0)) / 2, memAddress'length)) ;
    
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
	
	-- rom address
    memAddress <= std_logic_vector(to_unsigned(conv_integer(cpuAddress(15 downto 0)) / 2, memAddress'length)) ;
-- 

-- ____________________________________________________________________________________
-- CHIP SELECTS GO HERE

n_basRom1CS <= '0' when cpu_uds = '0' and cpuAddress(23 downto 16) = x"E0" else '1'; --E00000-E0FFFF
n_basRom2CS <= '0' when cpu_lds = '0' and cpuAddress(23 downto 16) = x"E0" else '1';       

hiMem <= '1' when cpuAddress(23 downto 20) = "1111" else '0';
hiMemRegAddr <= cpuAddress(7 downto 0);

fpuMem  <= '1' when hiMem = '1' and cpuAddress(19 downto 16) = x"5" else '0'; --f5 
ethMem  <= '1' when hiMem = '1' and cpuAddress(19 downto 16) = x"4" and hiMemRegAddr(7 downto 4) = x"4" else '0';  --f4
spiMem  <= '1' when hiMem = '1' and cpuAddress(19 downto 16) = x"4" and hiMemRegAddr(7 downto 4) /= x"4"  else '0';  --f4
timerCS  <= '1' when hiMem = '1' and cpuAddress(19 downto 16) = x"3" and hiMemRegAddr(7 downto 4) = x"3" else '0'; -- timer f3003
rtcCS <= '1' when hiMem = '1' and cpuAddress(19 downto 16) = x"3" and hiMemRegAddr(7 downto 4) = x"4" else '0';  -- f3004
ioMem  <= '1' when hiMem = '1' and cpuAddress(19 downto 16) = x"2" else '0';  --f2
uartMem  <= '1' when hiMem = '1' and cpuAddress(19 downto 16) = "0000" else '0'; --f0


-- ____________________________________________________________________________________
-- RAM
ram_cen <= '0' when  cpuAddress(23 downto 20)  < X"E" and n_reset = '1' else '1'; --n_internalRam1CS = '1' andand 
ram_oen <= ram_cen or (not cpu_r_w); -- ram read
ram_wen <= ram_cen or cpu_r_w; -- ram write
ram_a <= cpuAddress(26 downto 0); -- address
ram_ub <= cpu_uds;
ram_lb <= cpu_lds;
ram_dq_i <= cpuDataOut when ram_wen = '0' else (others => '0') ;

-- spi

spi_ctrl(4) <= cpuDataOut(4) when spiMem = '1' and (hiMemRegAddr = x"08" or hiMemRegAddr = x"09")  and cpu_lds = '0' and cpu_r_w = '0';  --cont                  
spi_ctrl(3) <= cpuDataOut(3) when spiMem = '1' and (hiMemRegAddr = x"08" or hiMemRegAddr = x"09")  and cpu_lds = '0' and cpu_r_w = '0'; -- enable
spi_ctrl(2 downto 0) <= cpuDataOut(2 downto 0) when spiMem = '1' and (hiMemRegAddr = x"08" or hiMemRegAddr = x"09") and cpu_lds = '0' and cpu_r_w = '0';                   
spi_dataOut <= cpuDataOut(7 downto 0) when spiMem = '1' and (hiMemRegAddr = x"0a" or hiMemRegAddr = x"0b") and cpu_lds = '0' and cpu_r_w = '0'; 
gd_gpu_sel <= not spi_ctrl(0);
gd_sd_sel <= not spi_ctrl(1);
gd_daz_sel <= not spi_ctrl(2);

opl3_ctl(5 downto 0) <= cpuDataout(5 downto 0) when spiMem = '1' and (hiMemRegAddr = x"10" or hiMemRegAddr = x"11") and cpu_lds = '0' and cpu_r_w = '0'; 
opl3_DataOut <= cpuDataout(7 downto 0) when spiMem = '1' and (hiMemRegAddr = x"12" or hiMemRegAddr = x"13") and cpu_lds = '0' and cpu_r_w = '0'; 

--fram_spi_ctrl(4 downto 0) <= cpuDataOut(4 downto 0) when spiMem = '1' and (hiMemRegAddr = x"38" or hiMemRegAddr = x"39") and cpu_lds = '0' and cpu_r_w = '0';                   
--fram_spi_dataOut <= cpuDataOut(7 downto 0) when spiMem = '1' and (hiMemRegAddr = x"3a" or hiMemRegAddr = x"3b") and cpu_lds = '0' and cpu_r_w = '0'; 
fram1Mem <= '1' when cpuAddress(23 downto 16) >= X"E4" and cpuAddress(23 downto 16) < x"E8" and cpu_lds = '0' else  '0';
fram2Mem <= '1' when cpuAddress(23 downto 16) >= X"E4" and cpuAddress(23 downto 16) < x"E8" and cpu_uds = '0' else '0';

fram_spi_ctrl(0) <= fram1Mem;
fram_spi_ctrl2(0) <= fram2Mem;
fram_spi_dataOut <= cpuDataOut(7 downto 0) when fram1Mem = '1';
fram_spi_dataOut2 <= cpuDataOut(15 downto 8) when fram2Mem = '1';

-- timer
timer_clk_en <= cpuDataOut(0) when timerCS = '1' and (hiMemRegAddr = x"34" or hiMemRegAddr = x"35") and cpu_lds = '0' and cpu_r_w = '0'; 

-- sd 
sdAddress(31 downto 16) <= cpuDataOut when spiMem = '1' and hiMemRegAddr = x"22" and cpu_r_w = '0';
sdAddress(15 downto 0) <= cpuDataOut  when spiMem = '1' and hiMemRegAddr = x"24" and cpu_r_w = '0';
sdControl <= cpuDataOut(7 downto 0) when spiMem = '1' and (hiMemRegAddr = x"20" or hiMemRegAddr = x"21") and cpu_r_w = '0' and cpu_lds = '0';
sdCardDataIn <= cpuDataOut(7 downto 0) when spiMem = '1' and (hiMemRegAddr = x"26" or hiMemRegAddr = x"27") and cpu_r_w = '0' and cpu_lds = '0';
sdEraseCount <= cpuDataOut(7 downto 0) when spiMem = '1' and (hiMemRegAddr = x"28" or hiMemRegAddr = x"29") and cpu_r_w = '0' and cpu_lds = '0';
sd_rden <= sdControl(2);
sd_wren <= sdControl(3);

--net 
eth_data_in(7 downto 0) <= cpuDataOut(7 downto 0) when ethMem = '1' and (hiMemRegAddr = x"40" or hiMemRegAddr = x"41") and cpu_r_w = '0' and cpu_lds = '0';
eth_ctl(6 downto 5) <= cpuDataOut(6 downto 5) when ethMem = '1' and hiMemRegAddr = x"45" and cpu_r_w = '0' and cpu_lds = '0';

--FPU
opa_i(63 downto 48) <= cpuDataOut when fpuMem = '1' and hiMemRegAddr = x"00" and cpu_r_w = '0';
opa_i(47 downto 32) <= cpuDataOut when fpuMem = '1' and hiMemRegAddr = x"02" and cpu_r_w = '0';
opa_i(31 downto 16) <= cpuDataOut when fpuMem = '1' and hiMemRegAddr = x"04" and cpu_r_w = '0';
opa_i(15 downto 0) <= cpuDataOut when fpuMem = '1' and hiMemRegAddr = x"06" and cpu_r_w = '0';

opb_i(63 downto 48) <= cpuDataOut when fpuMem = '1' and hiMemRegAddr = x"08" and cpu_r_w = '0';
opb_i(47 downto 32) <= cpuDataOut when fpuMem = '1' and hiMemRegAddr = x"0a" and cpu_r_w = '0';
opb_i(31 downto 16) <= cpuDataOut when fpuMem = '1' and hiMemRegAddr = x"0c" and cpu_r_w = '0';
opb_i(15 downto 0) <= cpuDataOut when fpuMem = '1' and hiMemRegAddr = x"0e" and cpu_r_w = '0';

fpu_ctl <= cpuDataOut(7 downto 0) when fpuMem = '1' and (hiMemRegAddr = x"18" or hiMemRegAddr = x"19") 
            and cpu_r_w = '0' and cpu_lds = '0';
            
start_i <= fpu_ctl(0);
fpu_op_i <= fpu_ctl(3 downto 1);
rmode_i <= fpu_ctl(5 downto 4);

--fpu_clock_en <= fpu_ctl(7);

fpu_sts(0) <= idle_o ;
fpu_sts(1) <= valid_o;
--fpu_sts(2) <= fpu_ready;

uartRDn <= '0' when uartMem = '1' and (hiMemRegAddr = x"0a" or hiMemRegAddr = x"0b") and cpu_r_w = '1' and cpu_lds = '0' else '1';
uartWRn <= '0' when uartMem = '1' and (hiMemRegAddr = x"0a" or hiMemRegAddr = x"0b") and cpu_r_w = '0' and cpu_lds = '0' else '1';
uartRegSel <= '1' when uartMem = '1' and (hiMemRegAddr = x"08" or hiMemRegAddr = x"09")  and cpu_lds = '0' else '0'; -- 2 bytes 
uartDataOut <= cpuDataOut(7 downto 0) when uartMem = '1' and (hiMemRegAddr = x"0a" or hiMemRegAddr = x"0b") and cpu_r_w = '0' and cpu_lds = '0';
                
uartIrqEn <= uartDataOut(2) when uartRegSel='1' and cpu_r_w = '0' and cpu_lds = '0';
-- ____________________________________________________________________________________
-- BUS ISOLATION GOES HERE

auto_iack <= '1' when cpu_fc = "111" else '0';

-- upper
cpuDataIn(15 downto 8) 
<= 
x"00" 
when uartMem = '1' and cpu_r_w = '1' and cpu_uds = '0' else
monRomData(15 downto 8)
when n_basRom1CS = '0' else
ram_dq_o(15 downto 8)
when ram_oen = '0' and ram_cen = '0' and cpu_uds = '0' else

fram_spi_DataIn2 
when fram2Mem = '1' and cpu_r_w = '1' and cpu_uds = '0' else

X"00"
when ethMem = '1' and hiMemRegAddr >= X"40" and hiMemRegAddr <= x"45" and cpu_r_w = '1' and cpu_uds = '0' else
eth_tx_free(15 downto 8)
when ethMem = '1' and hiMemRegAddr = X"46" and cpu_r_w = '1' and cpu_uds = '0' else
eth_rx_count(15 downto 8)
when ethMem = '1' and hiMemRegAddr = X"48" and cpu_r_w = '1' and cpu_uds = '0' else   

x"00"
when spiMem = '1' and hiMemRegAddr >= x"08" and hiMemRegAddr <= x"0d" and cpu_r_w = '1' and cpu_uds = '0' else
sdStatus
when spiMem = '1' and hiMemRegAddr = X"20" and cpu_r_w = '1' and cpu_uds = '0' else
sdAddress(31 downto 24)
when spiMem = '1' and hiMemRegAddr = X"22" and cpu_r_w = '1' and cpu_uds = '0' else 
sdAddress(15 downto 8)
when spiMem = '1' and hiMemRegAddr = X"24" and cpu_r_w = '1' and cpu_uds = '0' else 
x"00"
when spiMem = '1' and hiMemRegAddr = X"26" and cpu_r_w = '1' and cpu_uds = '0' else
x"00"
when spiMem = '1' and hiMemRegAddr = X"28" and cpu_r_w = '1' and cpu_uds = '0' else

--x"00"
--when spiMem = '1' and hiMemRegAddr >= x"30" and hiMemRegAddr <= x"3d" and cpu_r_w = '1' and cpu_uds = '0' else

opa_i(63 downto 56) when fpuMem = '1' and hiMemRegAddr = X"00" and cpu_r_w = '1' and cpu_uds = '0' else
opa_i(47 downto 40) when fpuMem = '1' and hiMemRegAddr = X"02" and cpu_r_w = '1' and cpu_uds = '0' else
opa_i(31 downto 24) when fpuMem = '1' and hiMemRegAddr = X"04" and cpu_r_w = '1' and cpu_uds = '0' else
opa_i(15 downto 8) when fpuMem = '1' and hiMemRegAddr = X"06"   and cpu_r_w = '1' and cpu_uds = '0' else
opb_i(63 downto 56) when fpuMem = '1' and hiMemRegAddr = X"08" and cpu_r_w = '1' and cpu_uds = '0' else
opb_i(47 downto 40) when fpuMem = '1' and hiMemRegAddr = X"0a" and cpu_r_w = '1' and cpu_uds = '0' else
opb_i(31 downto 24) when fpuMem = '1' and hiMemRegAddr = X"0c" and cpu_r_w = '1' and cpu_uds = '0' else
opb_i(15 downto 8) when fpuMem = '1' and hiMemRegAddr = X"0e" and cpu_r_w = '1' and cpu_uds = '0' else
result_o(63 downto 56) when fpuMem = '1' and hiMemRegAddr = X"10" and cpu_r_w = '1' and cpu_uds = '0' else
result_o(47 downto 40) when fpuMem = '1' and hiMemRegAddr = X"12" and cpu_r_w = '1' and cpu_uds = '0' else
result_o(31 downto 24) when fpuMem = '1' and hiMemRegAddr = X"14" and cpu_r_w = '1' and cpu_uds = '0' else
result_o(15 downto 8) when fpuMem = '1' and hiMemRegAddr = X"16" and cpu_r_w = '1' and cpu_uds = '0' else

milliseconds(31 downto 24)
when timerCS = '1' and hiMemRegAddr = X"30" and cpu_r_w ='1' and cpu_uds = '0' else
milliseconds(15 downto 8)
when timerCS = '1' and hiMemRegAddr = X"32" and cpu_r_w ='1' and cpu_uds = '0' else

x"00"
when rtcCS = '1' and hiMemRegAddr = X"46" and cpu_r_w ='1' and cpu_uds = '0' else
rtc_data(47 downto 40)
when rtcCS = '1' and hiMemRegAddr = X"44" and cpu_r_w ='1' and cpu_uds = '0' else
rtc_data(31 downto 24)
when rtcCS = '1' and hiMemRegAddr = X"42" and cpu_r_w ='1' and cpu_uds = '0' else
rtc_data(15 downto 8)
when rtcCS = '1' and hiMemRegAddr = X"40" and cpu_r_w ='1' and cpu_uds = '0' else
X"00" when cpu_uds = '1';

--lower
cpuDataIn(7 downto 0)
<= 
monRomData(7 downto 0)
when n_basRom2CS = '0' else 
ram_dq_o(7 downto 0)
when ram_oen = '0' and ram_cen = '0' and cpu_lds = '0' and cpuAddress(23 downto 20)  < X"E" else

fram_spi_DataIn 
when fram1Mem = '1' and cpu_r_w = '1' and cpu_lds = '0' else

eth_data_in(7 downto 0)
when ethMem = '1' and (hiMemRegAddr = x"40" or hiMemRegAddr = x"41") and cpu_r_w = '1' and cpu_lds = '0' else 
eth_data_out(7 downto 0)
when ethMem = '1' and (hiMemRegAddr = x"42" or hiMemRegAddr = x"43") and cpu_r_w = '1' and cpu_lds = '0' else 
eth_ctl(7 downto 0)
when ethMem = '1' and (hiMemRegAddr = x"44" or hiMemRegAddr = x"45") and cpu_r_w = '1' and cpu_lds = '0' else
eth_tx_free(7 downto 0)
when ethMem = '1' and (hiMemRegAddr = x"46" or hiMemRegAddr = x"47") and cpu_r_w = '1' and cpu_lds = '0' else
eth_rx_count(7 downto 0)
when ethMem = '1' and (hiMemRegAddr = x"48" or hiMemRegAddr = x"49") and cpu_r_w = '1' and cpu_lds = '0' else


sdControl
when spiMem = '1' and (hiMemRegAddr = x"20" or hiMemRegAddr = x"21") and cpu_r_w = '1' and cpu_lds = '0' else
sdAddress(23 downto 16)
when spiMem = '1' and (hiMemRegAddr = x"22" or hiMemRegAddr = x"23")  and cpu_r_w = '1' and cpu_lds = '0' else 
sdAddress(7 downto 0)
when spiMem = '1' and (hiMemRegAddr = x"24" or hiMemRegAddr = x"25") and cpu_r_w = '1' and cpu_lds = '0' else 
sdCardDataOut
when spiMem = '1' and (hiMemRegAddr = x"26" or hiMemRegAddr = x"27") and cpu_r_w = '1' and cpu_lds = '0' else
sdEraseCount
when spiMem = '1' and (hiMemRegAddr = x"28" or hiMemRegAddr = x"29") and cpu_r_w = '1' and cpu_lds = '0' else

spi_DataOut
when spiMem = '1' and (hiMemRegAddr = x"0A" or hiMemRegAddr = x"0B")and cpu_r_w = '1' and cpu_lds = '0' else
spi_DataIn
when spiMem = '1' and (hiMemRegAddr = x"0C" or hiMemRegAddr = x"0D") and cpu_r_w = '1' and cpu_lds = '0' else
spi_ctrl
when spiMem = '1' and (hiMemRegAddr = x"08" or hiMemRegAddr = x"09") and cpu_r_w = '1' and cpu_lds = '0' else
opl3_ctl
when spiMem = '1' and (hiMemRegAddr = x"10" or hiMemRegAddr = x"11") and cpu_r_w = '1' and cpu_lds = '0' else
opl3_DataOut
when spiMem = '1' and (hiMemRegAddr = x"12" or hiMemRegAddr = x"13") and cpu_r_w = '1' and cpu_lds = '0' else

--fram_spi_DataOut
--when spiMem = '1' and (hiMemRegAddr = x"3A" or hiMemRegAddr = x"3B")and cpu_r_w = '1' and cpu_lds = '0' else
--fram_spi_DataIn
--when spiMem = '1' and (hiMemRegAddr = x"3C" or hiMemRegAddr = x"3D") and cpu_r_w = '1' and cpu_lds = '0' else
--fram_spi_ctrl
--when spiMem = '1' and (hiMemRegAddr = x"38" or hiMemRegAddr = x"39") and cpu_r_w = '1' and cpu_lds = '0' else

opa_i(55 downto 48) when fpuMem = '1' and (hiMemRegAddr = x"00" or hiMemRegAddr = x"01") and cpu_r_w = '1' and cpu_lds = '0' else
opa_i(39 downto 32) when fpuMem = '1' and (hiMemRegAddr = x"02" or hiMemRegAddr = x"03") and cpu_r_w = '1' and cpu_lds = '0' else
opa_i(23 downto 16) when fpuMem = '1' and (hiMemRegAddr = x"04" or hiMemRegAddr = x"05") and cpu_r_w = '1' and cpu_lds = '0' else
opa_i(7 downto 0) when fpuMem = '1' and (hiMemRegAddr = x"06" or hiMemRegAddr = x"07")   and cpu_r_w = '1' and cpu_lds = '0' else
opb_i(55 downto 48) when fpuMem = '1' and (hiMemRegAddr = x"08" or hiMemRegAddr = x"09") and cpu_r_w = '1' and cpu_lds = '0' else
opb_i(39 downto 32) when fpuMem = '1' and (hiMemRegAddr = x"0a" or hiMemRegAddr = x"0b") and cpu_r_w = '1' and cpu_lds = '0' else
opb_i(23 downto 16) when fpuMem = '1' and (hiMemRegAddr = x"0c"or hiMemRegAddr = x"0d") and cpu_r_w = '1' and cpu_lds = '0' else
opb_i(7 downto 0) when fpuMem = '1' and (hiMemRegAddr = x"0e" or hiMemRegAddr = x"0f") and cpu_r_w = '1' and cpu_lds = '0' else
result_o(55 downto 48) when fpuMem = '1' and (hiMemRegAddr = x"10" or hiMemRegAddr = x"11") and cpu_r_w = '1' and cpu_lds = '0' else
result_o(39 downto 32) when fpuMem = '1' and (hiMemRegAddr = x"12" or hiMemRegAddr = x"13") and cpu_r_w = '1'and cpu_lds = '0' else
result_o(23 downto 16) when fpuMem = '1' and (hiMemRegAddr = x"14" or hiMemRegAddr = x"15") and cpu_r_w = '1' and cpu_lds = '0' else
result_o(7 downto 0) when fpuMem = '1' and  (hiMemRegAddr = x"16" or hiMemRegAddr = x"17") and cpu_r_w = '1'and cpu_lds = '0' else
fpu_ctl when  fpuMem = '1' and (hiMemRegAddr = x"18" or hiMemRegAddr = x"19") and cpu_r_w = '1' and cpu_lds = '0' else
fpu_sts when fpuMem = '1' and (hiMemRegAddr = x"1a" or hiMemRegAddr = x"1b") and cpu_r_w = '1' and cpu_lds = '0' else

milliseconds(23 downto 16)
when timerCS = '1' and (hiMemRegAddr = x"30" or hiMemRegAddr = x"31") and cpu_r_w ='1' and cpu_lds = '0' else
milliseconds(7 downto 0)
when timerCS = '1' and (hiMemRegAddr = x"32" or hiMemRegAddr = x"33") and cpu_r_w ='1' and cpu_lds = '0' else

uartDataIn 
when  uartMem = '1' and (hiMemRegAddr = x"0a" or hiMemRegAddr = x"0b")and cpu_r_w = '1' and cpu_lds = '0' else
"00000" & uartIrqEn & uartIdle & uartDataAvail  
when uartMem = '1' and (hiMemRegAddr = x"08" or hiMemRegAddr = x"09") and cpu_r_w = '1' and cpu_lds = '0' else
"0000000" & timer_clk_en when timerCS = '1' and (hiMemRegAddr = x"34" or hiMemRegAddr = x"35") and cpu_lds = '0' and cpu_r_w = '1' else

rtc_data(55 downto 48)
when rtcCS = '1' and (hiMemRegAddr = x"46" or hiMemRegAddr = x"47") and cpu_r_w ='1' and cpu_lds = '0' else
rtc_data(39 downto 32)
when rtcCS = '1' and (hiMemRegAddr = x"44" or hiMemRegAddr = x"45") and cpu_r_w ='1' and cpu_lds = '0' else
rtc_data(23 downto 16)
when rtcCS = '1' and (hiMemRegAddr = x"42" or hiMemRegAddr = x"43") and cpu_r_w ='1' and cpu_lds = '0' else
rtc_data(7 downto 0)
when rtcCS = '1' and (hiMemRegAddr = x"40" or hiMemRegAddr = x"41") and cpu_r_w ='1' and cpu_lds = '0' else
keyb_data when ioMem = '1' and (hiMemRegAddr = x"00" or hiMemRegAddr = x"01") and cpu_lds = '0' and cpu_r_w = '1' else
X"00" when cpu_lds = '1' ;

cpu_dtack <= 
not ram_ack when ram_cen = '0' else 
not rtc_ack when rtcCS = '1' else
NOT eth_ack_rx when ethMem = '1' and (hiMemRegAddr = x"42" or hiMemRegAddr = x"43") else
NOT fram_spi_ctrl(5) when fram1Mem = '1' else
NOT fram_spi_ctrl2(5) when fram2Mem = '1' else
'0';
    
end;