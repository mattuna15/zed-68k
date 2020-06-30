library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std_unsigned.all;

entity main_tb is
end main_tb;

architecture structural of main_tb is

   -- Clock
   signal main_clk  : std_logic;
   signal reset : std_logic := '0' ;
   signal start_up  : std_logic := '0';
   signal txd: std_logic := '0';

   signal cpuAddress : std_logic_vector(31 downto 0);
   signal		cpuDataOut		:  std_logic_vector(15 downto 0);
	signal    cpuDataIn		:  std_logic_vector(15 downto 0);
	
	    
    signal memAddress: std_logic_vector(15 downto 0) := (others => '0');
    signal	    cpu_as :  std_logic; -- Address strobe
    signal    cpu_uds :  std_logic; -- upper data strobe
    signal    cpu_lds :  std_logic; -- lower data strobe
    signal    cpu_r_w :   std_logic; -- read(high)/write(low)
     signal   cpu_dtack :  std_logic := '0'; -- data transfer acknowledge;
    
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

   reset_proc : process
   begin
   
    if start_up = '0' then
        reset <= '1', '0' after 10 ns;
        start_up <= '1';
    end if;
    wait for 1 ns;
   end process reset_proc;
   
   --------------------------------------------------
   -- Instantiate MAIN
   --------------------------------------------------

   main_inst : entity work.multicomp_wrapper

   port map (
        sys_clock => main_clk,
        reset => reset,
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
		sdCS	=> open,
		sdMOSI	=> open,
		sdMISO	=> '0',
		sdSCLK	=> open,
		driveLED => open,
		
		rxd1	=> '0',
		txd1	=> txd,
		rts1   => open,
		cpuAddress => cpuAddress,
		cpuDataOut => cpuDataOut,
		cpuDataIn => cpuDataIn,
		memAddress => memAddress,
		cpu_as => cpu_as, -- Address strobe
        cpu_uds => cpu_uds, -- upper data strobe
        cpu_lds => cpu_lds, -- lower data strobe
        cpu_r_w => cpu_r_w, -- read(high)/write(low)
        cpu_dtack => cpu_dtack -- data transfer acknowledge
   ); -- main_inst
   
end architecture structural;

