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
	use ieee.numeric_std.all;
	use ieee.std_logic_unsigned.all;

entity KeyboardMC is

	port (
		n_reset	: in std_logic;
		clk    	: in  std_logic;
		n_wr		: in  std_logic;
		n_rd		: in  std_logic;
		dataOut	: out std_logic_vector(7 downto 0);
		n_int		: out std_logic; 
		n_rts		: out std_logic :='0';
		regsel      : in std_logic;
		
		-- Keyboard signals
		ps2Clk	: inout std_logic;
		ps2Data	: inout std_logic;
 
		-- FN keys passed out as general signals (momentary and toggled versions)
		FNkeys	: out std_logic_vector(12 downto 0);
		FNtoggledKeys	: out std_logic_vector(12 downto 0)
 );
end KeyboardMC;

architecture rtl of KeyboardMC is

	signal	FNkeysSig	: std_logic_vector(12 downto 0) := (others => '0');
	signal	FNtoggledKeysSig	: std_logic_vector(12 downto 0) := (others => '0');

	signal	kbWatchdogTimer : integer range 0 to 50000000 :=0;
	signal	kbWriteTimer : integer range 0 to 50000000 :=0;

	signal	n_int_internal   : std_logic := '1';
	signal	statusReg : std_logic_vector(7 downto 0) := (others => '0'); 
	signal	controlReg : std_logic_vector(7 downto 0) := "00000000";
	 
	type		kbBuffArray is array (0 to 7) of std_logic_vector(6 downto 0);
	signal	kbBuffer : kbBuffArray;

	signal	kbInPointer: integer range 0 to 15 :=0;
	signal	kbReadPointer: integer range 0 to 15 :=0;
	signal	kbBuffCount: integer range 0 to 15 :=0;



	signal	ps2Byte: std_logic_vector(7 DOWNTO 0); 
	signal	ps2PreviousByte: std_logic_vector(7 DOWNTO 0); 
	signal	ps2ConvertedByte: std_logic_vector(6 DOWNTO 0); 
	signal	ps2ClkCount : integer range 0 to 10 :=0;
	signal	ps2WriteClkCount : integer range 0 to 20 :=0;
	signal	ps2WriteByte: std_logic_vector(7 DOWNTO 0) := x"FF"; 
	signal	ps2WriteByte2: std_logic_vector(7 DOWNTO 0):= x"FF"; 
	signal	ps2PrevClk: std_logic := '1';
	signal 	ps2ClkFilter : integer range 0 to 50; 
	signal 	ps2ClkFiltered : std_logic := '1';

	signal	ps2Shift: std_logic := '0';
	signal	ps2Ctrl: std_logic := '0';
	signal	ps2Caps: std_logic := '0';
	signal	ps2Num: std_logic := '0';
	signal	ps2Scroll: std_logic := '0';

	signal	ps2DataOut: std_logic := '1';
	signal	ps2ClkOut: std_logic := '1';
	signal	n_kbWR: std_logic := '1';
	signal	kbWRParity: std_logic := '0';
	
	type		kbDataArray is array (0 to 131) of std_logic_vector(6 downto 0);

	-- UK KEYBOARD MAPPING (except for shift-3 = "#")
	
	--Original 8-bit HEX values
--	constant kbUnshifted : kbDataArray :=
--	(
--	--0     1     2     3     4     5     6     7     8     9     A     B     C     D     E     F
--	x"00",x"19",x"00",x"00",x"13",x"11",x"12",x"1C",x"00",x"1A",x"18",x"16",x"00",x"09",x"60",x"00", -- 0
--	x"00",x"00",x"00",x"00",x"00",x"71",x"31",x"00",x"00",x"00",x"7A",x"73",x"61",x"77",x"32",x"00", -- 1
--	x"00",x"63",x"78",x"64",x"65",x"34",x"33",x"00",x"00",x"20",x"76",x"66",x"74",x"72",x"35",x"00", -- 2
--	x"00",x"6E",x"62",x"68",x"67",x"79",x"36",x"00",x"00",x"00",x"6D",x"6A",x"75",x"37",x"38",x"00", -- 3
--	x"00",x"2C",x"6B",x"69",x"6F",x"30",x"39",x"00",x"00",x"2E",x"2F",x"6C",x"3B",x"70",x"2D",x"00", -- 4
--	x"00",x"00",x"27",x"00",x"5B",x"3D",x"00",x"00",x"00",x"00",x"0D",x"5D",x"00",x"00",x"00",x"00", -- 5
--	x"00",x"00",x"00",x"00",x"00",x"00",x"08",x"00",x"00",x"31",x"00",x"34",x"37",x"00",x"00",x"00", -- 6
--	x"30",x"2E",x"32",x"35",x"36",x"38",x"03",x"00",x"1B",x"2B",x"33",x"2D",x"2A",x"39",x"00",x"00", -- 7
--	x"00",x"00",x"00",x"17"
--	);
--	constant kbShifted : kbDataArray :=
--	(
--	--0     1     2     3     4     5     6     7     8     9     A     B     C     D     E     F
--	x"00",x"19",x"00",x"00",x"13",x"11",x"12",x"1C",x"00",x"1A",x"18",x"16",x"00",x"09",x"00",x"00", -- 0
--	x"00",x"00",x"00",x"00",x"00",x"51",x"21",x"00",x"00",x"00",x"5A",x"53",x"41",x"57",x"22",x"00", -- 1
--	x"00",x"43",x"58",x"44",x"45",x"24",x"23",x"00",x"00",x"20",x"56",x"46",x"54",x"52",x"25",x"00", -- 2
--	x"00",x"4E",x"42",x"48",x"47",x"59",x"5E",x"00",x"00",x"00",x"4D",x"4A",x"55",x"26",x"2A",x"00", -- 3
--	x"00",x"3C",x"4B",x"49",x"4F",x"29",x"28",x"00",x"00",x"3E",x"3F",x"4C",x"3A",x"50",x"5F",x"00", -- 4
--	x"00",x"00",x"40",x"00",x"7B",x"2B",x"00",x"00",x"00",x"00",x"0D",x"7D",x"00",x"00",x"00",x"00", -- 5
--	x"00",x"00",x"00",x"00",x"00",x"00",x"08",x"00",x"00",x"31",x"00",x"34",x"37",x"00",x"00",x"00", -- 6
--	x"30",x"2E",x"32",x"35",x"36",x"38",x"0C",x"00",x"1B",x"2B",x"33",x"2D",x"2A",x"39",x"00",x"00", -- 7
--	x"00",x"00",x"00",x"17"
--	);

	-- 7 bits to reduce logic count
	constant kbUnshifted : kbDataArray :=
	(
	--  0         1         2         3         4         5         6         7         8         9         A         B         C         D         E         F
	"0000000","0011001","0000000","0000000","0010011","0010001","0010010","0011100","0000000","0011010","0011000","0010110","0000000","0001001","1100000","0000000", -- 0
	"0000000","0000000","0000000","0000000","0000000","1110001","0110001","0000000","0000000","0000000","1111010","1110011","1100001","1110111","0110010","0000000", -- 1
	"0000000","1100011","1111000","1100100","1100101","0110100","0110011","0000000","0000000","0100000","1110110","1100110","1110100","1110010","0110101","0000000", -- 2
	"0000000","1101110","1100010","1101000","1100111","1111001","0110110","0000000","0000000","0000000","1101101","1101010","1110101","0110111","0111000","0000000", -- 3
	"0000000","0101100","1101011","1101001","1101111","0110000","0111001","0000000","0000000","0101110","0101111","1101100","0111011","1110000","0101101","0000000", -- 4
	"0000000","0000000","0100111","0000000","1011011","0111101","0000000","0000000","0000000","0000000","0001101","1011101","0000000","0000000","0000000","0000000", -- 5
	"0000000","0000000","0000000","0000000","0000000","0000000","0001000","0000000","0000000","0110001","0000000","0110100","0110111","0000000","0000000","0000000", -- 6
	"0110000","0101110","0110010","0110101","0110110","0111000","0000011","0000000","0011011","0101011","0110011","0101101","0101010","0111001","0000000","0000000", -- 7
	"0000000","0000000","0000000","0010111"
	);
	constant kbShifted : kbDataArray :=
	(
	--  0         1         2         3         4         5         6         7         8         9         A         B         C         D         E         F
	"0000000","0011001","0000000","0000000","0010011","0010001","0010010","0011100","0000000","0011010","0011000","0010110","0000000","0001001","0000000","0000000", -- 0
	"0000000","0000000","0000000","0000000","0000000","1010001","0100001","0000000","0000000","0000000","1011010","1010011","1000001","1010111","1000000","0000000", -- 1
	"0000000","1000011","1011000","1000100","1000101","0100100","0100011","0000000","0000000","0100000","1010110","1000110","1010100","1010010","0100101","0000000", -- 2
	"0000000","1001110","1000010","1001000","1000111","1011001","1011110","0000000","0000000","0000000","1001101","1001010","1010101","0100110","0101010","0000000", -- 3
	"0000000","0111100","1001011","1001001","1001111","0101001","0101000","0000000","0000000","0111110","0111111","1001100","0111010","1010000","1011111","0000000", -- 4
	"0000000","0000000","0100010","0000000","1111011","0101011","0000000","0000000","0000000","0000000","0001101","1111101","0000000","0000000","0000000","0000000", -- 5
	"0000000","0000000","0000000","0000000","0000000","0000000","0001000","0000000","0000000","0110001","0000000","0110100","0110111","0000000","0000000","0000000", -- 6
	"0110000","0101110","0110010","0110101","0110110","0111000","0001100","0000000","0011011","0101011","0110011","0101101","0101010","0111001","0000000","0000000", -- 7
	"0000000","0000000","0000000","0010111"
	);

	
begin


	FNkeys <= FNkeysSig;
	FNtoggledKeys <= FNtoggledKeysSig;	


	-- minimal 6850 compatibility
	statusReg(0) <= '0' when kbInPointer=kbReadPointer else '1';
	statusReg(1) <= '1'; -- when dispByteWritten=dispByteSent else '0';
	statusReg(2) <= '0'; --n_dcd;
	statusReg(3) <= '0'; --n_cts;
	statusReg(7) <= not(n_int_internal);
	  
	-- interrupt mask
	n_int <= not n_int_internal;
	n_int_internal <= '0' when (kbInPointer /= kbReadPointer) and controlReg(7)='1'
	         else '0' when controlReg(6)='0' and controlReg(5)='1'
				else '1';

	kbBuffCount <= 0 + kbInPointer - kbReadPointer when kbInPointer >= kbReadPointer
		else 8 + kbInPointer - kbReadPointer;
	n_rts <= '1' when kbBuffCount > 4 else '0';	

	process( n_rd )
	begin
		if falling_edge(n_rd) then -- Standard CPU - present data on leading edge of rd
			if regSel='1' then
				dataOut <= '0' & kbBuffer(kbReadPointer);
				if kbInPointer /= kbReadPointer then
					if kbReadPointer < 7 then
						kbReadPointer <= kbReadPointer+1;
					else
						kbReadPointer <= 0;
					end if;
				end if;
			else
				dataOut <= statusReg;
			end if;
		end if;
	end process;

	-- PROCESS DATA FROM PS2 KEYBOARD

	ps2Data <= ps2DataOut when ps2DataOut='0' else 'Z';
	ps2Clk <= ps2ClkOut when ps2ClkOut='0' else 'Z';

	-- PS2 clock de-glitcher - important because the FPGA is very sensistive
	-- Filtered clock will not switch low to high until there is 50 more high samples than lows
	-- hysteresis will then not switch high to low until there is 50 more low samples than highs.
	-- Introduces a minor (1uS) delay with 50MHz clock

	process (clk)
	begin
		if falling_edge(clk) then
			if ps2Clk = '1' and ps2ClkFilter=50 then
				ps2ClkFiltered <= '1';
			end if;
			if ps2Clk = '1' and ps2ClkFilter /= 50 then
				ps2ClkFilter <= ps2ClkFilter+1;
			end if;
			if ps2Clk = '0' and ps2ClkFilter=0 then
				ps2ClkFiltered <= '0';
			end if;
			if ps2Clk = '0' and ps2ClkFilter/=0 then
				ps2ClkFilter <= ps2ClkFilter-1;
			end if;
		end if;
	end process;
	
	process( clk )
	-- 11 bits
	-- start(0) b0 b1 b2 b3 b4 b5 b6 b7 parity(odd) stop(1)
	begin
		if falling_edge(clk) then

			ps2PrevClk <= ps2ClkFiltered;

			if n_kbWR = '0' and kbWriteTimer<25000 then
				ps2WriteClkCount<= 0;
				kbWRParity <= '1';
				kbWriteTimer<=kbWriteTimer+1;
				-- wait
			elsif n_kbWR = '0' and kbWriteTimer<50000 then
				ps2ClkOut <= '0';
				kbWriteTimer<=kbWriteTimer+1;
			elsif n_kbWR = '0' and kbWriteTimer<75000 then
				ps2DataOut <= '0';
				kbWriteTimer<=kbWriteTimer+1;
			elsif n_kbWR = '0' and kbWriteTimer=75000 then
				ps2ClkOut <= '1';
				kbWriteTimer<=kbWriteTimer+1;
			elsif n_kbWR = '0' and kbWriteTimer<76000 then
				kbWriteTimer<=kbWriteTimer+1;
			elsif  n_kbWR = '1' and ps2PrevClk = '1' and ps2ClkFiltered='0' then -- start of high-to-low cleaned ps2 clock
				kbWatchdogTimer<=0;
				if ps2ClkCount=0 then -- start
					ps2Byte <= (others =>'0');
					ps2ClkCount<=ps2ClkCount+1;
				elsif ps2ClkCount<9 then -- data
					ps2Byte <= ps2Data & ps2Byte(7 downto 1);
					ps2ClkCount<=ps2ClkCount+1;
				elsif ps2ClkCount=9 then -- parity - use this time to decode
					if (ps2Byte<132) then
						if ps2Shift='0' then
							ps2ConvertedByte <= kbUnshifted (to_integer(unsigned(ps2Byte)));
						else
							ps2ConvertedByte <= kbShifted (to_integer(unsigned(ps2Byte)));
						end if;
					else
						ps2ConvertedByte <= (others => '0');
					end if;
					ps2ClkCount<=ps2ClkCount+1;
				else -- stop bit - use this time to store
					-- F-keys
					if ps2ConvertedByte>x"10" and ps2ConvertedByte<x"1D" then
						if ps2PreviousByte /= x"F0" then
							FNtoggledKeysSig(to_integer(unsigned(ps2ConvertedByte))-16#10#) <= FNtoggledKeysSig(to_integer(unsigned(ps2ConvertedByte))-16#10#);
							FNKeysSig(to_integer(unsigned(ps2ConvertedByte))-16#10#) <= '1';
						else
							FNKeysSig(to_integer(unsigned(ps2ConvertedByte))-16#10#) <= '0';
						end if;
					-- SHIFT
					elsif ps2Byte = x"12" or ps2Byte=x"59" then
						if ps2PreviousByte /= x"F0" then
							ps2Shift <= '1';
						else
							ps2Shift <= '0';
						end if;
					-- CTRL
					elsif ps2Byte = x"14" then
						if ps2PreviousByte /= x"F0" then
							ps2Ctrl <= '1';
						else
							ps2Ctrl <= '0';
						end if;
					-- SCROLL, CAPS AND NUM
					elsif ps2Byte = x"AA" then
							ps2WriteByte <= x"ED";
							ps2WriteByte2(0) <= ps2Scroll;
							ps2WriteByte2(1) <= ps2Num;
							ps2WriteByte2(2) <= ps2Caps;
							ps2WriteByte2(7 downto 3) <= "00000";
							n_kbWR <= '0';
							kbWriteTimer<=0;
					elsif ps2Byte = x"7E" then
						if ps2PreviousByte /= x"F0" then
							ps2Scroll <= not ps2Scroll;
							ps2WriteByte <= x"ED";
							ps2WriteByte2(0) <= not ps2Scroll;
							ps2WriteByte2(1) <= ps2Num;
							ps2WriteByte2(2) <= ps2Caps;
							ps2WriteByte2(7 downto 3) <= "00000";
							n_kbWR <= '0';
							kbWriteTimer<=0;
						end if;
					elsif ps2Byte = x"77" then
						if ps2PreviousByte /= x"F0" then
							ps2Num <= not ps2Num;
							ps2WriteByte <= x"ED";
							ps2WriteByte2(0) <= ps2Scroll;
							ps2WriteByte2(1) <= not ps2Num;
							ps2WriteByte2(2) <= ps2Caps;
							ps2WriteByte2(7 downto 3) <= "00000";
							n_kbWR <= '0';
							kbWriteTimer<=0;
						end if;
					elsif ps2Byte = x"58" then
						if ps2PreviousByte /= x"F0" then
							ps2Caps <= not ps2Caps;
							ps2WriteByte <= x"ED";
							ps2WriteByte2(0) <= ps2Scroll;
							ps2WriteByte2(1) <= ps2Num;
							ps2WriteByte2(2) <= not ps2Caps;
							ps2WriteByte2(7 downto 3) <= "00000";
							n_kbWR <= '0';
							kbWriteTimer<=0;
						end if;
					-- ACK
					elsif ps2Byte = x"FA" then
						if ps2WriteByte /= x"FF" then
							n_kbWR <= '0';
							kbWriteTimer<=0;
						end if;
					-- ASCII CHARACTER
					elsif (ps2PreviousByte /= x"F0") and (ps2ConvertedByte /= x"00") then
						if ps2PreviousByte = x"E0" and ps2Byte = x"71" then -- DELETE
							kbBuffer(kbInPointer) <= "1111111"; -- 7F
						elsif ps2Ctrl = '1' then
							kbBuffer(kbInPointer) <= "00" & ps2ConvertedByte(4 downto 0);
						elsif ps2ConvertedByte > x"40" and ps2ConvertedByte < x"5B" and ps2Caps='1' then
							kbBuffer(kbInPointer) <= ps2ConvertedByte or "0100000";
						elsif ps2ConvertedByte > x"60" and ps2ConvertedByte < x"7B" and ps2Caps='1' then
							kbBuffer(kbInPointer) <= ps2ConvertedByte and "1011111";
						else
							kbBuffer(kbInPointer) <= ps2ConvertedByte;
						end if;
						if kbInPointer < 7 then
							kbInPointer <= kbInPointer+1;
						else
							kbInPointer <= 0;
						end if;
					end if;
					ps2PreviousByte<=ps2Byte;
					ps2ClkCount<=0;
				end if;

			-- write to keyboard
			elsif  n_kbWR = '0' and ps2PrevClk = '1' and  ps2ClkFiltered='0' then -- start of high-to-low cleaned ps2 clock
				kbWatchdogTimer<=0;
				if ps2WriteClkCount <8 then
					if (ps2WriteByte(ps2WriteClkCount)='1') then
						ps2DataOut <= '1';
						kbWRParity <= not kbWRParity;
					else
						ps2DataOut <= '0';
					end if;
					ps2WriteClkCount<=ps2WriteClkCount+1;
				elsif ps2WriteClkCount = 8 then
					ps2DataOut <= kbWRParity;
					ps2WriteClkCount<=ps2WriteClkCount+1;
				elsif ps2WriteClkCount = 9 then
					ps2WriteClkCount<=ps2WriteClkCount+1;
					ps2DataOut <= '1';
				elsif ps2WriteClkCount = 10 then
					ps2WriteByte <= ps2WriteByte2;
					ps2WriteByte2 <= x"FF";
					n_kbWR<= '1';
					ps2WriteClkCount <= 0;
					ps2DataOut <= '1';

				end if;
			else
				-- COMMUNICATION ERROR
				-- if no edge then increment the timer
				-- if a large time has elapsed since the last pulse was read then
				-- re-sync the keyboard
				if kbWatchdogTimer>30000000 then
					kbWatchdogTimer<=0;
					ps2ClkCount<=0;
					if n_kbWR = '0' then
							ps2WriteByte <= x"ED";
							ps2WriteByte2(0) <= ps2Scroll;
							ps2WriteByte2(1) <= ps2Num;
							ps2WriteByte2(2) <= ps2Caps;
							ps2WriteByte2(7 downto 3) <= "00000";
							kbWriteTimer<=0;
					end if;
				else
					kbWatchdogTimer<=kbWatchdogTimer+1;				
				end if;
			end if;

		end if;
	end process;
	
	
 end rtl;
