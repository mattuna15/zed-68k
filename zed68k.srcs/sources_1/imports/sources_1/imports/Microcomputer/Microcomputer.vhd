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
        

		-- PS/2 keyboard / mouse
		ps2k_clk_in : in std_logic;
		ps2k_dat_in : in std_logic;
		ps2k_clk_out : out std_logic;
		ps2k_dat_out : out std_logic;
		ps2m_clk_in : in std_logic;
		ps2m_dat_in : in std_logic;
		ps2m_clk_out : out std_logic;
		ps2m_dat_out : out std_logic


	);
	
end Microcomputer;

architecture struct of Microcomputer is

	component fpu_double IS

   PORT( 
      clk, rst, enable : IN     std_logic;
      rmode : IN     std_logic_vector (1 DOWNTO 0);
      fpu_op : IN     std_logic_vector (2 DOWNTO 0);
      opa, opb : IN     std_logic_vector (63 DOWNTO 0);
      out_fp: OUT    std_logic_vector (63 DOWNTO 0);
      ready : OUT  std_logic
      --underflow, overflow, inexact : OUT    std_logic;
      --exception, invalid : OUT    std_logic
   );

	END component;

    signal monRomData					: std_logic_vector(15 downto 0);
	signal n_externalRamCS			: std_logic :='1';

	signal n_basRom1CS					: std_logic :='1';
    signal n_basRom2CS					: std_logic :='1';
    
    signal    cpuAddress	    :  std_logic_vector(31 downto 0);
	signal	  cpuDataOut		:  std_logic_vector(15 downto 0);
	signal    cpuDataIn		:  std_logic_vector(15 downto 0);
	signal    memAddress		:  std_logic_vector(15 downto 0);
	
    signal    cpu_uds :  std_logic; -- upper data strobe
    signal    cpu_lds :  std_logic; -- lower data strobe
    signal    cpu_r_w :   std_logic; -- read(high)/write(low)
    signal    cpu_dtack :  std_logic; -- data transfer acknowledge
    
    type t_Vector is array (0 to 10) of std_logic_vector(15 downto 0);
    signal r_vec : t_Vector;
    
    signal vecAddress: integer := 0;

    signal int_out: std_logic_vector(2 downto 0) := "111";
    signal int_ack: std_logic := '0';
    
-- Peripheral register block signals

signal per_reg_addr : std_logic_vector(11 downto 0);
signal per_reg_dataout : std_logic_vector(15 downto 0);
signal per_reg_datain : std_logic_vector(15 downto 0);
signal per_reg_rw : std_logic;
signal per_reg_req : std_logic;
signal per_reg_dtack : std_logic;
signal per_timer_int : std_logic;
signal per_ps2_int : std_logic;
	
	signal rtcCS: std_logic;
	signal rtc_ack :std_logic;
	signal rtc_data : std_logic_vector(63 downto 0);

    signal sd_rden : std_logic;
    signal sd_wren : std_logic;
	signal n_sdCardCS : std_logic;
	
		signal timerCS : std_logic;
	signal timerDataOut : std_logic_vector(7 downto 0);
	signal timer_reg_sel : std_logic;
	signal milliseconds: std_logic_vector(31 downto 0);
	
	--fpu
	
signal opa_i, opb_i : std_logic_vector(63 downto 0);
signal fpu_op_i		: std_logic_vector(2 downto 0);
signal rmode_i : std_logic_vector(1 downto 0);
signal result_o : std_logic_vector(63 downto 0);
signal start_i, ready_o, rd_en : std_logic ; 
signal error: std_logic;
signal fpu_sts, fpu_ctl : std_logic_vector(7 downto 0);
signal fpu_count : std_logic_vector(4 downto 0);

signal fpu_switch :  std_logic;
signal fpu_running : std_logic;
	
	
    attribute dont_touch : string;
    attribute dont_touch of rtc : label is "true";
    
begin

--interrupts: entity work.interrupt_controller
--	port map (
--		clk => sys_clk,
--		reset => n_reset,
--		int1 => per_ps2_int,
--		int2 => per_timer_int,
--		int3 => '0',
--		int4 => '0',
--		int5 => '0',
--	    int6 => '0',
--		int7 => '0',
--		int_out => int_out,
--		ack => int_ack
--		);

--peripheral : entity work.peripheral_controller
--		port map (
--		clk => sys_clk,
--		reset => n_reset,
		
--		reg_addr_in => per_reg_addr,
--		reg_data_in => per_reg_datain,
--		reg_data_out => per_reg_dataout,
--		reg_rw => per_reg_rw,
--		reg_uds => cpu_uds,
--		reg_lds => cpu_lds,
--		reg_dtack => per_reg_dtack,
--		reg_req => per_reg_req,

--		timer_int => per_timer_int,
--		ps2_int => per_ps2_int,

--		ps2k_clk_in => ps2k_clk_in,
--		ps2k_dat_in => ps2k_dat_in,
--		ps2k_clk_out => ps2k_clk_out,
--		ps2k_dat_out => ps2k_dat_out,
--		ps2m_clk_in => ps2m_clk_in,
--		ps2m_dat_in => ps2m_dat_in,
--		ps2m_clk_out => ps2m_clk_out,
--		ps2m_dat_out => ps2m_dat_out,

--		bootrom_overlay => open,
--		hex => open
--	);

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
		IPL => "111",	-- For this simple demo we'll ignore interrupts
		dtack => cpu_dtack,
		addr => cpuAddress,
		as => cpu_as,
		data_out => cpuDataOut,
		rw => cpu_r_w,
		uds => cpu_uds,
		lds => cpu_lds
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
			out_fp => result_o,  
        	enable => start_i,
        	ready => ready_o 
   );

  
  timer: entity work.timer  
	port map ( 
	 clk       => sys_clk,
    rst        => not n_reset,
    cs         => timerCS, 
    addr       => '0',
    rw         => cpu_r_w, 
    data_in    => (others => '0'), 
	 data_out  => open,
	 count_up_millis => milliseconds,
	 irq        => open
  ); 
	
	-- rom address
    memAddress <= std_logic_vector(to_unsigned(conv_integer(cpuAddress(15 downto 0)) / 2, memAddress'length)) ;
    
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

-- ____________________________________________________________________________________
-- CHIP SELECTS GO HERE

n_basRom1CS <= '0' when cpu_uds = '0' and cpuAddress(23 downto 20) = "1110" else '1'; --E00000-E0FFFF
n_basRom2CS <= '0' when cpu_lds = '0' and cpuAddress(23 downto 20) = "1110" else '1';       

-- RAM
ram_cen <= '0' when  cpuAddress < X"E00000" and n_reset = '1' else '1'; --n_internalRam1CS = '1' andand 
ram_oen <= ram_cen or (not cpu_r_w); -- ram read
ram_wen <= ram_cen or cpu_r_w; -- ram write
ram_a <= cpuAddress(26 downto 0) when ram_cen ='0' else (others => '0'); -- address
ram_ub <= cpu_uds;
ram_lb <= cpu_lds;
ram_dq_i <= cpuDataOut when ram_wen = '0' else (others => '0') ;

-- spi

spi_ctrl(4)     <= cpuDataOut(4) when (cpuAddress = X"f40008" or cpuAddress = X"f40009")  and cpu_lds = '0' and cpu_r_w = '0';  --cont                  
spi_ctrl(3)     <= cpuDataOut(3) when (cpuAddress = X"f40008" or cpuAddress = X"f40009")  and cpu_lds = '0' and cpu_r_w = '0'; -- enable
spi_ctrl(2 downto 0) <= cpuDataOut(2 downto 0) when (cpuAddress = X"f40008" or cpuAddress = X"f40009") and cpu_lds = '0' and cpu_r_w = '0';                   
spi_dataOut <= cpuDataOut(7 downto 0) when (cpuAddress = X"f4000A" or cpuAddress = X"f4000B") and cpu_lds = '0' and cpu_r_w = '0'; 
gd_gpu_sel <= not spi_ctrl(0);
gd_sd_sel <= not spi_ctrl(1);
gd_daz_sel <= not spi_ctrl(2);

opl3_ctl(5 downto 0) <= cpuDataout(5 downto 0) when (cpuAddress = X"f40010" or cpuAddress = X"f40011") and cpu_lds = '0' and cpu_r_w = '0'; 
opl3_DataOut <= cpuDataout(7 downto 0) when (cpuAddress = X"f40012" or cpuAddress = X"f40013") and cpu_lds = '0' and cpu_r_w = '0'; 

-- timer
rtcCS <= '1' when cpuAddress >= x"f30040" and cpuAddress < x"f30048" else '0';
timerCS <= '1' when cpuAddress >= x"f30030" and cpuAddress <= x"f30033" else '0';

-- sd 
n_sdCardCS <= '0' when cpuAddress >= x"f40020" and cpuAddress <= x"f40030" else '1';
sdAddress(31 downto 16) <= cpuDataOut when cpuAddress = x"f40022" and cpu_r_w = '0';
sdAddress(15 downto 0) <= cpuDataOut when cpuAddress = x"f40024" and cpu_r_w = '0';
sdControl <= cpuDataOut(7 downto 0) when (cpuAddress = x"f40020" or cpuAddress = x"f40021") and cpu_r_w = '0' and cpu_lds = '0';
sdCardDataIn <= cpuDataOut(7 downto 0) when (cpuAddress = x"f40026" or cpuAddress = x"f40027") and cpu_r_w = '0' and cpu_lds = '0';
sdEraseCount <= cpuDataOut(7 downto 0) when (cpuAddress = x"f40028" or cpuAddress = x"f40029") and cpu_r_w = '0' and cpu_lds = '0';
sd_rden <= sdControl(2);
sd_wren <= sdControl(3);

--net 
eth_data_in(7 downto 0) <= cpuDataOut(7 downto 0) when (cpuAddress = x"f40040" or cpuAddress = x"f40041") 
                            and cpu_r_w = '0' and cpu_lds = '0';

eth_ctl(6 downto 5) <= cpuDataOut(6 downto 5) when cpuAddress = x"f40045" and cpu_r_w = '0' and cpu_lds = '0';


-- peripheral

--per_reg_req <= '1' when cpuAddress >= X"f20000" and cpuAddress <= X"f2FFFF" else '0';
--per_reg_addr <= cpuAddress(11 downto 0) when per_reg_req = '1' ;
--per_reg_datain <= cpuDataOut when per_reg_req = '1' and cpu_r_w = '0';
--per_reg_rw <= cpu_r_w when per_reg_req = '1';


--FPU


opa_i(63 downto 48) <= cpuDataOut when cpuAddress = x"f50000" and cpu_r_w = '0';
opa_i(47 downto 32) <= cpuDataOut when cpuAddress = x"f50002" and cpu_r_w = '0';
opa_i(31 downto 16) <= cpuDataOut when cpuAddress = x"f50004" and cpu_r_w = '0';
opa_i(15 downto 0) <= cpuDataOut when cpuAddress  = x"f50006" and cpu_r_w = '0';

opb_i(63 downto 48) <= cpuDataOut when cpuAddress = x"f50008" and cpu_r_w = '0';
opb_i(47 downto 32) <= cpuDataOut when cpuAddress = x"f5000a" and cpu_r_w = '0';
opb_i(31 downto 16) <= cpuDataOut when cpuAddress = x"f5000c" and cpu_r_w = '0';
opb_i(15 downto 0) <= cpuDataOut when cpuAddress  = x"f5000e" and cpu_r_w = '0';

fpu_ctl <= cpuDataOut(7 downto 0) when (cpuAddress = x"f50018" or cpuAddress = x"f50019") 
            and cpu_r_w = '0' and cpu_lds = '0';
           
--rd_en <= '1' when (cpuAddress >= x"f50010" and cpuAddress <= x"f50017") and cpu_r_w = '1' else '0';
            
start_i <= fpu_ctl(0);
fpu_op_i <= fpu_ctl(3 downto 1);
rmode_i <= fpu_ctl(5 downto 4);
--fpu_switch <= not fpu_ctl(6);

fpu_sts(0) <= '1' when  ready_o = '1' or fpu_count > 0 else '0' ;
fpu_sts(1) <= error;
--fpu_sts(2) <= fpu_running;

-- ____________________________________________________________________________________
-- BUS ISOLATION GOES HERE
 
-- upper
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
ram_dq_o(15 downto 8)
when ram_oen = '0' and ram_cen = '0' and cpu_uds = '0' else
x"00"
when cpuAddress >= x"f40008" and cpuAddress <= x"f4000d" and cpu_r_w = '1' and cpu_uds = '0' else
x"00"
when rtcCS = '1' and cpuAddress = X"f30046" and cpu_r_w ='1' and cpu_uds = '0' else
rtc_data(47 downto 40)
when rtcCS = '1' and cpuAddress = X"f30044" and cpu_r_w ='1' and cpu_uds = '0' else
rtc_data(31 downto 24)
when rtcCS = '1' and cpuAddress = X"f30042" and cpu_r_w ='1' and cpu_uds = '0' else
rtc_data(15 downto 8)
when rtcCS = '1' and cpuAddress = X"f30040" and cpu_r_w ='1' and cpu_uds = '0' else
sdAddress(31 downto 24)
when cpuAddress = x"f40022" and cpu_r_w = '1' and cpu_uds = '0' else 
sdAddress(15 downto 8)
when cpuAddress = x"f40024" and cpu_r_w = '1' and cpu_uds = '0' else 
sdStatus
when cpuAddress = x"f40020" and cpu_r_w = '1' and cpu_uds = '0' else
x"00"
when cpuAddress = x"f40026" and cpu_r_w = '1' and cpu_uds = '0' else
x"00"
when cpuAddress = x"f40028" and cpu_r_w = '1' and cpu_uds = '0' else
x"00"
when cpuAddress = x"f00018" and cpu_r_w = '1' and cpu_uds = '0' else
eth_tx_free(15 downto 8)
when cpuAddress = x"f40046" and cpu_r_w = '1' and cpu_uds = '0' else
eth_rx_count(15 downto 8)
when cpuAddress = x"f40048" and cpu_r_w = '1' and cpu_uds = '0' else 
X"00"
when (cpuAddress >= x"f40040" and cpuAddress <= x"f40045") and cpu_r_w = '1' and cpu_uds = '0' else  
per_reg_dataout(15 downto 8) 
when per_reg_req = '1' and cpu_r_w = '1' and cpu_uds = '0' else
milliseconds(31 downto 24)
when timerCS = '1' and cpuAddress = X"f30030" and cpu_r_w ='1' and cpu_uds = '0' else
milliseconds(15 downto 8)
when timerCS = '1' and cpuAddress = X"f30032" and cpu_r_w ='1' and cpu_uds = '0' else
opa_i(63 downto 56) when cpuAddress = x"f50000" and cpu_r_w = '1' and cpu_uds = '0' else
opa_i(47 downto 40) when cpuAddress = x"f50002" and cpu_r_w = '1' and cpu_uds = '0' else
opa_i(31 downto 24) when cpuAddress = x"f50004" and cpu_r_w = '1' and cpu_uds = '0' else
opa_i(15 downto 8) when cpuAddress = x"f50006"   and cpu_r_w = '1' and cpu_uds = '0' else
opb_i(63 downto 56) when cpuAddress = x"f50008" and cpu_r_w = '1' and cpu_uds = '0' else
opb_i(47 downto 40) when cpuAddress = x"f5000a" and cpu_r_w = '1' and cpu_uds = '0' else
opb_i(31 downto 24) when cpuAddress = x"f5000c" and cpu_r_w = '1' and cpu_uds = '0' else
opb_i(15 downto 8) when cpuAddress = x"f5000e" and cpu_r_w = '1' and cpu_uds = '0' else
result_o(63 downto 56) when cpuAddress = x"f50010" and cpu_r_w = '1' and cpu_uds = '0' else
result_o(47 downto 40) when cpuAddress = x"f50012" and cpu_r_w = '1'and cpu_uds = '0' else
result_o(31 downto 24) when cpuAddress = x"f50014" and cpu_r_w = '1' and cpu_uds = '0' else
result_o(15 downto 8) when cpuAddress = x"f50016" and cpu_r_w = '1'and cpu_uds = '0' else
X"00" when cpu_uds = '1';

--lower
cpuDataIn(7 downto 0)
<= 
monRomData(7 downto 0)
when n_basRom2CS = '0' else 
"00000" & cpuAddress(3 downto 1)
when cpuAddress(31 downto 16) = X"FFFF" and cpu_r_w = '0' else 
r_Vec(vecAddress)(7 downto 0)
when cpuAddress(31 downto 16) = X"FFFF" and cpu_r_w = '1' else 
ram_dq_o(7 downto 0)
when ram_oen = '0' and ram_cen = '0' and cpu_lds = '0' and cpuAddress < x"E00000" else
spi_DataIn
when (cpuAddress = X"F4000C" or cpuAddress = X"F4000D") and cpu_r_w = '1' and cpu_lds = '0' else
spi_DataOut
when (cpuAddress = X"F4000A" or cpuAddress = X"F4000B") and cpu_r_w = '1' and cpu_lds = '0' else
spi_ctrl
when (cpuAddress = X"F40008" or cpuAddress = X"F40009") and cpu_r_w = '1' and cpu_lds = '0' else
opl3_DataOut
when (cpuAddress = X"F40012" or cpuAddress = X"F40013") and cpu_r_w = '1' and cpu_lds = '0' else
opl3_ctl
when (cpuAddress = X"F40010" or cpuAddress = X"F40011") and cpu_r_w = '1' and cpu_lds = '0' else
rtc_data(55 downto 48)
when rtcCS = '1' and (cpuAddress = X"f30046" or cpuAddress = X"F30047") and cpu_r_w ='1' and cpu_lds = '0' else
rtc_data(39 downto 32)
when rtcCS = '1' and (cpuAddress = X"f30044" or cpuAddress = X"F30045") and cpu_r_w ='1' and cpu_lds = '0' else
rtc_data(23 downto 16)
when rtcCS = '1' and (cpuAddress = X"f30042" or cpuAddress = X"F30043") and cpu_r_w ='1' and cpu_lds = '0' else
rtc_data(7 downto 0)
when rtcCS = '1' and (cpuAddress = X"f30040" or cpuAddress = X"F30041") and cpu_r_w ='1' and cpu_lds = '0' else
sdEraseCount
when (cpuAddress = x"f40028" or cpuAddress = x"f40029") and cpu_r_w = '1' and cpu_lds = '0' else
sdCardDataOut
when (cpuAddress = x"f40026" or cpuAddress = x"f40027") and cpu_r_w = '1' and cpu_lds = '0' else
sdControl
when (cpuAddress = x"f40020" or cpuAddress = x"f40021") and cpu_r_w = '1' and cpu_lds = '0' else
sdAddress(23 downto 16)
when (cpuAddress = x"f40022" or cpuAddress = x"f40023")  and cpu_r_w = '1' and cpu_lds = '0' else 
sdAddress(7 downto 0)
when (cpuAddress = x"f40024" or cpuAddress = x"f40025") and cpu_r_w = '1' and cpu_lds = '0' else 
eth_data_in(7 downto 0)
when (cpuAddress = x"f40040" or cpuAddress = x"f40041") and cpu_r_w = '1' and cpu_lds = '0' else 
eth_data_out(7 downto 0)
when (cpuAddress = x"f40042" or cpuAddress = x"f40043") and cpu_r_w = '1' and cpu_lds = '0' else 
eth_ctl(7 downto 0)
when (cpuAddress = x"f40044" or cpuAddress = x"f40045") and cpu_r_w = '1' and cpu_lds = '0' else
eth_tx_free(7 downto 0)
when (cpuAddress = x"f40046" or cpuAddress = x"f40047") and cpu_r_w = '1' and cpu_lds = '0' else
eth_rx_count(7 downto 0)
when (cpuAddress = x"f40048" or cpuAddress = x"f40049") and cpu_r_w = '1' and cpu_lds = '0' else
per_reg_dataout(7 downto 0) 
when per_reg_req = '1' and cpu_r_w = '1' and cpu_lds = '0' else  
milliseconds(23 downto 16)
when timerCS = '1' and (cpuAddress = X"f30030" or cpuAddress = X"f30031") and cpu_r_w ='1' and cpu_lds = '0' else
milliseconds(7 downto 0)
when timerCS = '1' and (cpuAddress = X"f30032" or cpuAddress = X"f30033") and cpu_r_w ='1' and cpu_lds = '0' else
opa_i(55 downto 48) when (cpuAddress = x"f50000" or cpuAddress = X"f50001") and cpu_r_w = '1' and cpu_lds = '0' else
opa_i(39 downto 32) when (cpuAddress = x"f50002" or cpuAddress = X"f50003") and cpu_r_w = '1' and cpu_lds = '0' else
opa_i(23 downto 16) when (cpuAddress = x"f50004" or cpuAddress = X"f50005") and cpu_r_w = '1' and cpu_lds = '0' else
opa_i(7 downto 0) when (cpuAddress = x"f50006" or cpuAddress = X"f50007")   and cpu_r_w = '1' and cpu_lds = '0' else
opb_i(55 downto 48) when (cpuAddress = x"f50008" or cpuAddress = X"f50009") and cpu_r_w = '1' and cpu_lds = '0' else
opb_i(39 downto 32) when (cpuAddress = x"f5000a" or cpuAddress = X"f50000b") and cpu_r_w = '1' and cpu_lds = '0' else
opb_i(23 downto 16) when (cpuAddress = x"f5000c"or cpuAddress = X"f5000d") and cpu_r_w = '1' and cpu_lds = '0' else
opb_i(7 downto 0) when (cpuAddress = x"f5000e" or cpuAddress = X"f5000f") and cpu_r_w = '1' and cpu_lds = '0' else
result_o(55 downto 48) when (cpuAddress = x"f50010" or cpuAddress = X"f50011") and cpu_r_w = '1' and cpu_lds = '0' else
result_o(39 downto 32) when (cpuAddress = x"f50012" or cpuAddress = X"f50013") and cpu_r_w = '1'and cpu_lds = '0' else
result_o(23 downto 16) when (cpuAddress = x"f50014" or cpuAddress = X"f50015") and cpu_r_w = '1' and cpu_lds = '0' else
result_o(7 downto 0) when (cpuAddress = x"f50016" or cpuAddress = X"f50017") and cpu_r_w = '1'and cpu_lds = '0' else
fpu_ctl when (cpuAddress = x"f50018" or cpuAddress = x"f50019") and cpu_r_w = '1' and cpu_lds = '0' else
fpu_sts when (cpuAddress = x"f5001a" or cpuAddress = x"f5001b") and cpu_r_w = '1' and cpu_lds = '0' else
X"00" when cpu_lds = '1' ;

cpu_dtack <= 
not ram_ack when ram_cen = '0' else 
not rtc_ack when rtcCS = '1' else
NOT eth_ack_rx when (cpuAddress = x"f40042" or cpuAddress = x"f40043") else
per_reg_dtack when per_reg_req = '1' else
'0';
    
end;