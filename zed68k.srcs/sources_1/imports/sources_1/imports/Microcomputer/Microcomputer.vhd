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
		n_reset		: in std_logic;
		clk			: in std_logic;
		cpuClock	: in std_logic;
		vgaClock    : in std_logic;

		videoR0		: out std_logic;
		videoG0		: out std_logic;
		videoB0		: out std_logic;
		videoR1		: out std_logic;
		videoG1		: out std_logic;
		videoB1		: out std_logic;
		hSync			: out std_logic;
		vSync			: out std_logic;

		ps2Clk		: inout std_logic;
		ps2Data		: inout std_logic;

		sdCS			: out std_logic;
		sdMOSI		: out std_logic;
		sdMISO		: in std_logic;
		sdSCLK		: out std_logic;
		driveLED		: out std_logic :='1';
		
		rxd1			: in std_logic;
		txd1			: out std_logic;
		rts1			: out std_logic;
		cpuAddress	    : inout std_logic_vector(31 downto 0);
		cpuDataOut		: inout std_logic_vector(15 downto 0);
	    cpuDataIn		: inout std_logic_vector(15 downto 0);
	    memAddress		: inout std_logic_vector(15 downto 0);
	    cpu_as : inout std_logic; -- Address strobe
        cpu_uds : inout std_logic; -- upper data strobe
        cpu_lds : inout std_logic; -- lower data strobe
        cpu_r_w :  inout std_logic; -- read(high)/write(low)
        cpu_dtack : inout std_logic := '0' -- data transfer acknowledge
	);
end Microcomputer;

architecture struct of Microcomputer is

   signal reset : std_logic := '0';

	signal n_WR							: std_logic;
	signal n_RD							: std_logic;

	signal basRomData					: std_logic_vector(15 downto 0);
	signal internalRam1DataOut		: std_logic_vector(15 downto 0);
	signal internalRam2DataOut		: std_logic_vector(7 downto 0);
	signal interface1DataOut		: std_logic_vector(7 downto 0);
	signal interface2DataOut		: std_logic_vector(7 downto 0);
	signal sdCardDataOut				: std_logic_vector(7 downto 0);

	signal n_memWR						: std_logic :='1';
	signal n_memRD 					: std_logic :='1';

	signal n_ioWR						: std_logic :='1';
	signal n_ioRD 						: std_logic :='1';
	
	signal n_MREQ						: std_logic :='1';
	signal n_IORQ						: std_logic :='1';	

	signal n_int1						: std_logic :='1';	
	signal n_int2						: std_logic :='1';	
	
	signal n_externalRamCS			: std_logic :='1';
	signal n_internalRam1CS			: std_logic :='1';
	signal n_internalRam2CS			: std_logic :='1';
	signal n_basRom1CS					: std_logic :='1';
    signal n_basRom2CS					: std_logic :='1';
	signal n_interface1CS			: std_logic :='1';
	signal n_interface2CS			: std_logic :='1';
	signal n_sdCardCS					: std_logic :='1';

	signal serialClkCount			: std_logic_vector(15 downto 0);
	signal cpuClkCount				: std_logic_vector(5 downto 0); 
	signal sdClkCount					: std_logic_vector(5 downto 0); 	
	signal serialClock				: std_logic;
	signal sdClock						: std_logic;	
	signal topAddress               : std_logic_vector(7 downto 0);
	--CPM
    signal n_RomActive : std_logic := '0';

	
begin

-- ____________________________________________________________________________________
-- CPU CHOICE GOES HERE
    
cpu1 : entity work.TG68
   port map
	(
		clk => clk, --cpuClock,
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

-- ____________________________________________________________________________________
-- ROM GOES HERE
    
	rom1 : entity work.rom -- 8 
	generic map (
	   G_ADDR_BITS => 16,
	   G_INIT_FILE => "D:/code/zed-68k/roms/hello_0.hex"
	)
    port map(
        addr_i => memAddress,
        clk_i => clk,
        data_o => basRomData(15 downto 8)
    );
    
    rom2 : entity work.rom -- 8 
	generic map (
	   G_ADDR_BITS => 16,
	   G_INIT_FILE => "D:/code/zed-68k/roms/hello_1.hex"
	)
    port map(
        addr_i => memAddress,
        clk_i => clk,
        data_o => basRomData(7 downto 0)
    );
-- ____________________________________________________________________________________
-- RAM GOES HERE

    ram1 : entity work.ram --64k
    generic map (
      -- Number of bits in the address bus. The size of the memory will
      -- be 2**G_ADDR_BITS bytes.
      G_ADDR_BITS => 16
    )
   port map (
      clk_i => clk,

      -- Current address selected.
      addr_i => memAddress,

      -- Data contents at the selected address.
      -- Valid in same clock cycle.
      data_o  => internalRam1DataOut(15 downto 8),

      -- New data to (optionally) be written to the selected address.
      data_i => cpuDataOut(15 downto 8),

      -- '1' indicates we wish to perform a write at the selected address.
      wren_i => not(n_memWR and n_internalRam1CS)
   );

    ram2 : entity work.ram --64k
    generic map (
      -- Number of bits in the address bus. The size of the memory will
      -- be 2**G_ADDR_BITS bytes.
      G_ADDR_BITS => 16
    )
   port map (
      clk_i => clk,

      -- Current address selected.
      addr_i => memAddress,

      -- Data contents at the selected address.
      -- Valid in same clock cycle.
      data_o  => internalRam1DataOut(7 downto 0),

      -- New data to (optionally) be written to the selected address.
      data_i => cpuDataOut(7 downto 0),

      -- '1' indicates we wish to perform a write at the selected address.
      wren_i => not(n_memWR and n_internalRam2CS)
   );
-- ____________________________________________________________________________________
-- INPUT/OUTPUT DEVICES GO HERE	
io1 :  entity work.bufferedUART
port map(
clk => clk,
n_wr => n_interface1CS or clk or n_WR,
n_rd => n_interface1CS or clk or (not n_WR),
n_int => n_int1,
regSel => cpuAddress(0),
dataIn => cpuDataOut(7 downto 0),
dataOut => interface1DataOut,
rxClock => serialClock,
txClock => serialClock,
rxd => rxd1,
txd => txd1,
n_cts => '0',
n_dcd => '0',
n_rts => rts1
);

sd1 : entity work.sd_controller
port map(
sdCS => sdCS,
sdMOSI => sdMOSI,
sdMISO => sdMISO,
sdSCLK => sdSCLK,
n_wr => n_sdCardCS or clk or n_WR,
n_rd => n_sdCardCS or clk or (not n_WR),
n_reset => n_reset,
dataIn => cpuDataOut(7 downto 0),
dataOut => sdCardDataOut,
regAddr => cpuAddress(2 downto 0),
driveLED => driveLED,
clk => clk -- twice the spi clk
);
	
	
-- ____________________________________________________________________________________
-- MEMORY READ/WRITE LOGIC GOES HERE
n_memRD <= not(clk) nand n_WR;
n_memWR <= not(clk) nand (not n_WR);
-- ____________________________________________________________________________________
-- CHIP SELECTS GO HERE


--n_basRom1CS <= '0' when cpu_as = '0' and cpu_uds = '0' and cpuAddress(23 downto 21) = "101" else '1'; --A00000-A0FFFF
--n_basRom2CS <= '0' when cpu_as = '0' and cpu_lds = '0' and cpuAddress(23 downto 21) = "101" else '1'; 
n_basRom1CS <= '0' when cpu_as = '0' and cpu_uds = '0' and cpuAddress(16 downto 16) = "1" else '1'; --10000-1FFFF
n_basRom2CS <= '0' when cpu_as = '0' and cpu_lds = '0' and cpuAddress(16 downto 16) = "1" else '1'; 
n_interface1CS <= '0' when cpu_as = '0' and cpuAddress(23 downto 16) = "11110000" else '1'; -- f000000
n_interface2CS <= '0' when cpu_as = '0' and cpuAddress(23 downto 16) = "11110010" else '1'; -- f200000
n_sdCardCS <= '1'; -- '0' when cpuAddress(15 downto 3) = "1111111111011" else '1'; -- 8 bytes FFD8-FFDF
n_internalRam1CS <= not n_basRom1CS when cpu_as = '0' and cpu_uds = '0' else '1' ;
n_internalRam2CS <= not n_basRom2CS when cpu_as = '0' and cpu_lds = '0' else '1' ;
-- ____________________________________________________________________________________
-- BUS ISOLATION GOES HERE



memAddress <= std_logic_vector(to_unsigned(conv_integer(cpuAddress(15 downto 0)) / 2, memAddress'length));
    
cpuDataIn(15 downto 8) 
<= X"00"
when cpu_as = '0' and cpu_uds = '0' and (n_interface1CS = '0' or n_interface2CS = '0') else
basRomData(15 downto 8)
when cpu_as = '0' and n_basRom1CS = '0' and cpu_uds = '0' else
internalRam1DataOut(15 downto 8)
when cpu_as = '0' and n_internalRam1CS= '0' and cpu_uds = '0' else
X"00" when cpu_uds = '1';

cpuDataIn(7 downto 0)
<= interface1DataOut 
when cpu_as = '0' and n_interface1CS = '0' and cpu_lds = '0' else
interface2DataOut
when cpu_as = '0' and n_interface2CS = '0' and cpu_lds = '0' else 
basRomData(7 downto 0)
when cpu_as = '0' and n_basRom1CS = '0' and cpu_lds = '0' else 
internalRam1DataOut(7 downto 0)
when cpu_as = '0' and n_internalRam1CS = '0'  and cpu_lds = '0' else
X"00" when cpu_lds = '1';

cpu_dtack <=  '1' when cpu_uds='1' and cpu_lds='1' else '0';




-- Serial clock DDS
-- 50MHz master input clock:
-- Baud Increment
-- 115200 2416
-- 38400 805
-- 19200 403
-- 9600 201
-- 4800 101
-- 2400 50
-- SUB-CIRCUIT CLOCK SIGNALS
serialClock <= serialClkCount(15);

clock: process (clk)
begin

    if rising_edge(clk) then
        serialClkCount <= serialClkCount + 201;
    end if;

end process;
    
end;