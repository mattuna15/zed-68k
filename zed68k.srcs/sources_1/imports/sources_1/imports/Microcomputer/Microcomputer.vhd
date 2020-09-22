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
        clk50       : in std_logic;
		cpu_as      : out std_logic; -- Address strobe
		
        sdCD		: in std_logic;
		sdCS			: out std_logic;
		sdMOSI		: out std_logic;
		sdMISO		: in std_logic;
		sdSCLK		: out std_logic;
		driveLED    : out std_logic;
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
      
      -- vga
      vga_addr              : out   std_logic_vector(15 downto 0);
      vga_wr_en             : out   std_logic;
      vga_rd_en             : out   std_logic;
      vga_wr_data           : out   std_logic_vector(7 downto 0);
      vga_rd_data           : in    std_logic_vector(7 downto 0);
      vga_irq               : in    std_logic;
     
     			-- UART
		uart_rxd : in std_logic;
		uart_txd : out std_logic;
		
		--ps2
		ps2k_clk_in : in std_logic;
		ps2k_dat_in : in std_logic;
		ps2m_clk_in : in std_logic;
		ps2m_dat_in : in std_logic
      
	);
	
end Microcomputer;

architecture struct of Microcomputer is

	signal basRomData					: std_logic_vector(15 downto 0);
    signal monRomData					: std_logic_vector(15 downto 0);
	signal internalRam1DataOut		: std_logic_vector(7 downto 0);
	signal internalRam2DataOut		: std_logic_vector(7 downto 0);

	signal n_interface2CS			: std_logic :='1';
	signal n_externalRamCS			: std_logic :='1';
	signal n_internalRam1CS			: std_logic :='1';
	signal n_internalRam2CS			: std_logic :='1';
	signal n_basRom1CS					: std_logic :='1';
    signal n_basRom2CS					: std_logic :='1';
    signal n_basRom3CS					: std_logic :='1';
    signal n_basRom4CS					: std_logic :='1';

	signal n_sdCardCS					: std_logic :='1';
    signal sdCardDataOut				: std_logic_vector(7 downto 0);
    signal sdStatus: std_logic_vector(7 downto 0) := (others => '0'); --f30009
    signal sdControl: std_logic_vector(7 downto 0); --f3000a
    
    signal sdAddress: std_logic_vector(31 downto 0) := (others => '0'); --f30000-2
    signal sd_rden : std_logic;
    signal sd_wren : std_logic;
    signal sd_ack  : std_logic;

	signal topAddress               : std_logic_vector(7 downto 0);
    
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
    signal audio_status :std_logic_vector(7 downto 0) := (others => '0');
    
    signal per_data_out: std_logic_vector(15 downto 0);
    signal per_reg_sel: std_logic;
    signal per_dtack: std_logic;
    
    signal uart_int :  std_logic;
	signal	timer_int :  std_logic;
	signal	ps2_int :  std_logic;
	signal	spi_int :  std_logic;

		-- PS/2 keyboard / mouse

	signal	ps2k_clk_out :  std_logic;
	signal	ps2k_dat_out :  std_logic;

	signal	ps2m_clk_out :  std_logic;
	signal	ps2m_dat_out :  std_logic;
	
begin
--interrupts

interrupts: entity work.interrupt_controller
	port map (
		clk => sys_clk,
		reset => n_reset,
		int1 => vga_irq,
		int2 => uart_int,
		int3 => timer_int,
		int4 => ps2_int,
		int5 => spi_int,
	    int6 => '0',
		int7 => '0',
		int_out => int_out,
		ack => int_ack
		);
		
peripherals: entity work.peripheral_controller
	generic map (
		sysclk_frequency => 1000, -- Sysclk frequency * 10
		spi_maxspeed => 4	-- lowest acceptable timer DIV7 value
	)
  port map (
		clk => sys_clk,
		reset=> n_reset,
		
		-- CPU interface

		reg_addr_in => cpuAddress(11 downto 0),
		reg_data_in => cpuDataIn(15 downto 0),
		reg_data_out => per_data_out,
		reg_rw => cpu_r_w,
		reg_uds => cpu_uds,
		reg_lds => cpu_lds,
		reg_dtack => per_dtack,	-- Needed for char ram access.
		reg_req => per_reg_sel,

		-- Interrupts
		
		uart_int => uart_int,
		timer_int => timer_int,
		ps2_int => ps2_int,
		spi_int => spi_int,

		-- UART
		uart_rxd => uart_rxd,
		uart_txd => uart_txd,

		-- PS/2 keyboard / mouse
		ps2k_clk_in => ps2k_clk_in,
		ps2k_dat_in => ps2k_dat_in,
		ps2k_clk_out => ps2k_clk_out,
		ps2k_dat_out => ps2k_dat_out,
		ps2m_clk_in => ps2m_clk_in,
		ps2m_dat_in => ps2m_dat_in,
		ps2m_clk_out => ps2m_clk_out,
		ps2m_dat_out => ps2m_dat_out,

		-- Misc
		-- gpio_out : out std_logic_vector(15 downto 0);
		-- gpio_in : in std_logic_vector(15 downto 0) := X"0000";
		
		gpio_dir =>  open,
		gpio_data => open,
		
		hex => open,

		bootrom_overlay => open,	-- Low page reads
		bootram_overlay => open  -- Low page writes
	);


--		spi_cs => sdCS,
--		miso => sdMISO,
--		mosi => sdMOSI,
--		spiclk_out => sdSCLK,

-- sdControl f4000a
-- 0 - din valid (a)
-- 1 - dout ack (a)
-- 2  - rden
-- 3  - wren

-- sdstatus f40009
-- 0 error
-- 1,2,3 - Error code
-- 4 - dout valid
-- 5 - Busy
-- 6,7 - card status

-- data f4000b

-- 32bit address - f40000 & f40002


sdcard: entity work.sd_controller 
    port map   (
	cs => sdCS,			-- To SD card
	mosi => sdMOSI,			-- To SD card
	miso => sdMISO,			-- From SD card
	sclk => sdSCLK,			-- To SD card
	card_present => not sdCD,	-- From socket - can be fixed to '1' if no switch is present
	card_write_prot => '0',	-- From socket - can be fixed to '0' if no switch is present, or '1' to make a Read-Only interface

	rd => sd_rden,				-- Trigger single block read
	rd_multiple => '0',		-- Trigger multiple block read
	dout => sdCardDataOut,	-- Data from SD card
	dout_avail => sdStatus(4),		-- Set when dout is valid
	dout_taken => sdControl(1),		-- Acknowledgement for dout
	
	wr => sd_wren,				-- Trigger single block write
	wr_multiple => '0',		-- Trigger multiple block write
	din => cpuDataOut(7 downto 0),	-- Data to SD card
	din_valid => sdControl(0),		-- Set when din is valid
	din_taken => sd_ack,		-- Ackowledgement for din
	
	addr => sdAddress,	-- Block address
	erase_count => x"00", -- For wr_multiple only

	sd_error => sdStatus(0),		-- '1' if an error occurs, reset on next RD or WR (just check for error code)
	sd_busy => sdStatus(5),		-- '0' if a RD or WR can be accepted
	sd_error_code => sdStatus (3 downto 1), -- See above, 000=No error
	
	
	reset => not n_reset,	-- System reset
	clk => clk50,		-- twice the SPI clk (max 50MHz)
	
	-- Optional debug outputs
	sd_type => sdStatus(7 downto 6),	-- Card status (see above)
	sd_fsm => open -- FSM state (see block at end of file)
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
-- RAM GOES HERE

ram1 : entity work.ram --64k
    generic map (
    G_INIT_FILE => "D:/code/zed-68k/roms/empty_1.hex",
      -- Number of bits in the address bus. The size of the memory will
      -- be 2**G_ADDR_BITS bytes.
      G_ADDR_BITS => 16
    )
   port map (
      clk_i => sys_clk,

      -- Current address selected.
      addr_i => memAddress,

      -- Data contents at the selected address.
      -- Valid in same clock cycle.
      data_o  => internalRam1DataOut,

      -- New data to (optionally) be written to the selected address.
      data_i => cpuDataOut(15 downto 8),

      -- '1' indicates we wish to perform a write at the selected address.
      wren_i => not(cpu_r_w or n_internalRam1CS)
   );

   
   ram2 : entity work.ram --64k
    generic map (
    G_INIT_FILE => "D:/code/zed-68k/roms/empty_2.hex",
      -- Number of bits in the address bus. The size of the memory will
      -- be 2**G_ADDR_BITS bytes.
      G_ADDR_BITS => 16
    )
   port map (
      clk_i => sys_clk,

      -- Current address selected.
      addr_i => memAddress,

      -- Data contents at the selected address.
      -- Valid in same clock cycle.
      data_o  => internalRam2DataOut,

      -- New data to (optionally) be written to the selected address.
      data_i => cpuDataOut(7 downto 0),

      -- '1' indicates we wish to perform a write at the selected address.
      wren_i => not(cpu_r_w or n_internalRam2CS)
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

--periph
per_reg_sel <= '1' when cpuAddress >= x"f30000" and cpuAddress <= x"f3ffff" else '0';

-- block ram
n_internalRam1CS <= '0' when  cpuAddress <= X"FFFF" 
                    and cpu_uds = '0' else '1' ; --4k at bottom
n_internalRam2CS <= '0' when  cpuAddress <= X"FFFF" 
                    and cpu_lds = '0' else '1' ; --4k at bottom
                    
               

-- RAM
ram_cen <= '0' when cpuAddress > X"FFFF"  and cpuAddress < X"A00000" and n_reset = '1' else '1'; --n_internalRam1CS = '1' andand 
ram_oen <= ram_cen or (not cpu_r_w); -- ram read
ram_wen <= ram_cen or cpu_r_w; -- ram write
ram_a <= cpuAddress(26 downto 0) when ram_cen ='0' else (others => '0'); -- address
ram_ub <= cpu_uds;
ram_lb <= cpu_lds;
ram_dq_i <= cpuDataOut when ram_wen = '0' else (others => '0') ;

-- VGA
vga_addr <= vgaAddress when n_interface2CS = '0';
vga_wr_en <= not cpu_r_w when n_interface2CS = '0' and cpu_lds='0' else '0';
vga_rd_en <= cpu_r_w when n_interface2CS = '0' and cpu_lds='0' else '0';
vga_wr_data <= cpuDataOut(7 downto 0) when n_interface2CS = '0' and vga_wr_en = '1' ;

--terminal
serialTxData <= cpuDataOut(7 downto 0) when tx_serialWrite_en = '1';

-- sd card

n_sdCardCS <= '0' when cpuAddress >= x"f40000" and cpuAddress <= x"f4ffff" else '1';
sdAddress(31 downto 16) <= cpuDataOut when cpuAddress = x"f40000" and cpu_r_w = '0';
sdAddress(15 downto 0) <= cpuDataOut when cpuAddress = x"f40002" and cpu_r_w = '0';
sdControl <= cpuDataOut(7 downto 0) when cpuAddress = x"f4000b" and cpu_r_w = '0' and cpu_lds = '0';
sd_rden <= sdControl(2);
sd_wren <= sdControl(3);
driveLED <= sdStatus(5);

-- ____________________________________________________________________________________
-- BUS ISOLATION GOES HERE
 
cpuDataIn(15 downto 8) 
<= 
X"00"
when n_interface2CS = '0' and vga_rd_en = '1' else
r_Vec(vecAddress)(15 downto 8)
when cpuAddress(31 downto 16) = X"FFFF" and cpu_r_w = '1' else
X"00"
when cpuAddress(31 downto 16) = X"FFFF" and cpu_r_w = '0'  else
monRomData(15 downto 8)
when n_basRom1CS = '0' else
basRomData(15 downto 8)
when n_basRom3CS = '0' else
internalRam1DataOut
when n_internalRam1CS= '0' else
ram_dq_o(15 downto 8)
when ram_oen = '0' and ram_cen = '0' and cpu_uds = '0' else
per_data_out(15 downto 8) 
when per_reg_sel = '1' and cpuAddress >= x"f30000" and cpuAddress <= x"f3ffff" and cpu_uds = '0' else
sdAddress(31 downto 24)
when cpuAddress = x"f40000" and cpu_r_w = '1' and cpu_uds = '0' else 
sdAddress(15 downto 8)
when cpuAddress = x"f40002" and cpu_r_w = '1' and cpu_uds = '0' else 
x"00"
when cpuAddress = x"f4000d" and cpu_r_w = '1' and cpu_uds = '0' else
x"00"
when cpuAddress = x"f4000b" and cpu_r_w = '1' and cpu_uds = '0' else
x"00"
when cpuAddress = x"f40009" and cpu_r_w = '1' and cpu_uds = '0' else
X"00" when cpu_uds = '1';

cpuDataIn(7 downto 0)
<= 
vga_rd_data 
when n_interface2CS = '0' and vga_rd_en = '1' else
monRomData(7 downto 0)
when n_basRom2CS = '0' else 
basRomData(7 downto 0)
when n_basRom4CS = '0' else 
internalRam2DataOut
when n_internalRam2CS = '0' else
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
serialRxData 
when rx_serialRead_en = '1' else 
ram_dq_o(7 downto 0)
when ram_oen = '0' and ram_cen = '0' and cpu_lds = '0' and cpuAddress < x"A00000" else
per_data_out(7 downto 0) 
when per_reg_sel = '1' and cpuAddress >= x"f30000" and cpuAddress <= x"f3ffff" and cpu_lds = '0' else 
sdCardDataOut
when cpuAddress = x"f4000d" and cpu_r_w = '1' and cpu_lds = '0' else
sdControl
when cpuAddress = x"f4000b" and cpu_r_w = '1' and cpu_lds = '0' else
sdStatus
when cpuAddress = x"f40009" and cpu_r_w = '1' and cpu_lds = '0' else
sdAddress(23 downto 16)
when cpuAddress = x"f40000" and cpu_r_w = '1' and cpu_lds = '0' else 
sdAddress(7 downto 0)
when cpuAddress = x"f40002" and cpu_r_w = '1' and cpu_lds = '0' else 
X"00" when cpu_lds = '1' ;

cpu_dtack <= 
not ram_ack when ram_cen = '0' else
sd_ack when
cpuAddress = x"f4000d" and cpu_r_w = '0' else
per_dtack 
when per_reg_sel = '1' and cpuAddress >= x"f30000" and cpuAddress <= x"f3ffff" 
else '0';

    
end;