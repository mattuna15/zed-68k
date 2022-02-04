-------------------------------------------------------------------------------
--
-- Project:	<Floating Point Unit Core>
--  	
-- Description: test bench for the FPU core
-------------------------------------------------------------------------------
--
--				100101011010011100100
--				110000111011100100000
--				100000111011000101101
--				100010111100101111001
--				110000111011101101001
--				010000001011101001010
--				110100111001001100001
--				110111010000001100111
--				110110111110001011101
--				101110110010111101000
--				100000010111000000000
--
-- 	Author:		 Jidan Al-eryani 
-- 	E-mail: 	 jidan@gmx.net
--
--  Copyright (C) 2006
--
--	This source file may be used and distributed without        
--	restriction provided that this copyright statement is not   
--	removed from the file and that any derivative work contains 
--	the original copyright notice and the associated disclaimer.
--                                                           
--		THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     
--	EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   
--	TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   
--	FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      
--	OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         
--	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    
--	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   
--	GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        
--	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  
--	LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  
--	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  
--	OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         
--	POSSIBILITY OF SUCH DAMAGE. 
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.math_real.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use std.textio.all;
use work.txt_util.all;

        -- fpu operations (fpu_op_i):
		-- ========================
		-- 000 = add, 
		-- 001 = substract, 
		-- 010 = multiply, 
		-- 011 = divide,
		-- 100 = square root
		-- 101 = unused
		-- 110 = unused
		-- 111 = unused
		
        -- Rounding Mode: 
        -- ==============
        -- 00 = round to nearest even(default), 
        -- 01 = round to zero, 
        -- 10 = round up, 
        -- 11 = round down


entity tb_fpu is
end tb_fpu;

architecture rtl of tb_fpu is

component fpu 
    port (
        clk_i       	: in std_logic;
        opa_i       	: in std_logic_vector(63 downto 0);   
        opb_i       	: in std_logic_vector(63 downto 0);
        fpu_op_i		: in std_logic_vector(2 downto 0);
        rmode_i 		: in std_logic_vector(1 downto 0);  
        output_o    	: out std_logic_vector(63 downto 0);
		ine_o 			: out std_logic;
        overflow_o  	: out std_logic;
        underflow_o 	: out std_logic;
        div_zero_o  	: out std_logic;
        inf_o			: out std_logic;
        zero_o			: out std_logic;
        qnan_o			: out std_logic;
        snan_o			: out std_logic;
        start_i	  		: in  std_logic;
        ready_o 		: out std_logic	
	);   
end component;


signal clk_i : std_logic:= '1';
signal opa_i, opb_i : std_logic_vector(63 downto 0);
signal fpu_op_i		: std_logic_vector(2 downto 0);
signal rmode_i : std_logic_vector(1 downto 0);
signal output_o : std_logic_vector(63 downto 0);
signal start_i, ready_o : std_logic ; 
signal ine_o, overflow_o, underflow_o, div_zero_o, inf_o, zero_o, qnan_o, snan_o, rd_en: std_logic;

signal locked: std_logic;

signal slv_out : std_logic_vector(31 downto 0);

constant CLK_PERIOD :time := 10ns; -- period of clk period


begin

--    -- instantiate fpu
--    i_fpu: fpu port map (
--			clk_i => clk_i,
--			opa_i => opa_i,
--			opb_i => opb_i,
--			fpu_op_i =>	fpu_op_i,
--			rmode_i => rmode_i,	
--			output_o => output_o,  
--			ine_o => ine_o,
--			overflow_o => overflow_o,
--			underflow_o => underflow_o,		
--        	div_zero_o => div_zero_o,
--        	inf_o => inf_o,
--        	zero_o => zero_o,		
--        	qnan_o => qnan_o, 		
--        	snan_o => snan_o,
--        	start_i => start_i,
--        	ready_o => ready_o);	
        	
    i_fpu: entity work.fpu_design_wrapper 
    port map (
			clk_in100 => clk_i,
			opa_i => opa_i,
			opb_i => opb_i,
			fpu_op_i =>	fpu_op_i,
			rmode_i => rmode_i,	
			result_o => output_o,   
			error => open,
        	start_i => start_i,
        	ready_o => ready_o,
        	rd_en => rd_en,
        	data_count_0 => open,
        	--power_down => '0',
        	fpu_locked => locked
        	);		
			

    ---------------------------------------------------------------------------
    -- toggle clock
    ---------------------------------------------------------------------------
    clk_i <= not(clk_i) after 5 ns;


    verify : process 

    begin

        wait until locked = '1';

		---------------------------------------------------------------------------------------------------------------------------------------------------
	
		start_i <= '0';
		--		  seeeeeeeefffffffffffffffffffffff
		-- 0 + x = x 
		wait for CLK_PERIOD; start_i <= '1'; 
		opa_i <= x"40061F9ADD667804";  
		opb_i <= x"3FF3C0C9539B8887"; 
		fpu_op_i <= "000";
		rmode_i <= "00";
		wait for CLK_PERIOD; start_i <= '0'; wait until ready_o='1';
		
		wait for CLK_PERIOD;
		rd_en <= '1';
		wait for CLK_PERIOD *2;
		--assert output_o="01000000010100111010001010110011";
		rd_en <= '0';
		wait for CLK_PERIOD;

		
				start_i <= '0';
		--		  seeeeeeeefffffffffffffffffffffff
		-- 0 + x = x 
		wait for CLK_PERIOD; start_i <= '1'; 
		opa_i <= x"40061F9ADD667804";  
		opb_i <= x"3FF3C0C9539B8887"; 
		fpu_op_i <= "001";
		rmode_i <= "00";
		wait for CLK_PERIOD; start_i <= '0'; wait until ready_o='1';
		
		wait for CLK_PERIOD;
		rd_en <= '1';
		wait for CLK_PERIOD *2;
		--assert output_o="01000000010100111010001010110011";
		rd_en <= '0';
		wait for CLK_PERIOD;

		
				start_i <= '0';
		--		  seeeeeeeefffffffffffffffffffffff
		-- 0 + x = x 
		wait for CLK_PERIOD; start_i <= '1'; 
		opa_i <= x"40061F9ADD667804";  
		opb_i <= x"3FF3C0C9539B8887"; 
		fpu_op_i <= "010";
		rmode_i <= "00";
		wait for CLK_PERIOD; start_i <= '0'; wait until ready_o='1';
		
		wait for CLK_PERIOD;
		rd_en <= '1';
		wait for CLK_PERIOD *2;
		--assert output_o="01000000010100111010001010110011";
		rd_en <= '0';
		wait for CLK_PERIOD;
			
				start_i <= '0';
		--		  seeeeeeeefffffffffffffffffffffff
		-- 0 + x = x 
		wait for CLK_PERIOD; start_i <= '1'; 
		opa_i <= x"40061F9ADD667804";  
		opb_i <= x"3FF3C0C9539B8887"; 
		fpu_op_i <= "011";
		rmode_i <= "00";
		wait for CLK_PERIOD; start_i <= '0'; wait until ready_o='1';
		
		wait for CLK_PERIOD;
		rd_en <= '1';
		wait for CLK_PERIOD *2;
		--assert output_o="01000000010100111010001010110011";
		rd_en <= '0';
		wait for CLK_PERIOD;
		
						start_i <= '0';
		--		  seeeeeeeefffffffffffffffffffffff
		-- 0 + x = x 
		wait for CLK_PERIOD; start_i <= '1'; 
		opa_i <= x"40061F9ADD667804";  
		opb_i <= (others => '0'); 
		fpu_op_i <= "100";
		rmode_i <= "00";
		wait for CLK_PERIOD; start_i <= '0'; wait until ready_o='1';
		
		wait for CLK_PERIOD;
		rd_en <= '1';
		wait for CLK_PERIOD *2;
		--assert output_o="01000000010100111010001010110011";
		rd_en <= '0';
		wait for CLK_PERIOD;
		
		
								start_i <= '0';
		--		  seeeeeeeefffffffffffffffffffffff
		-- 0 + x = x 
		wait for CLK_PERIOD; start_i <= '1'; 
		opa_i <= x"4016147B00000000";  
		opb_i <= (others => '0'); 
		fpu_op_i <= "101";
		rmode_i <= "00";
		wait for CLK_PERIOD; start_i <= '0'; wait until ready_o='1';
		
		wait for CLK_PERIOD;
		rd_en <= '1';
		wait for CLK_PERIOD *2;
		--assert output_o="01000000010100111010001010110011";
		rd_en <= '0';
		wait for CLK_PERIOD;
								
		start_i <= '0';
		--		  seeeeeeeefffffffffffffffffffffff
		-- 0 + x = x 
		wait for CLK_PERIOD; start_i <= '1'; 
		opa_i <= x"4002C28F5C28F5C3";  
		opb_i <= (others => '0'); 
		fpu_op_i <= "110";
		rmode_i <= "00";
		wait for CLK_PERIOD; start_i <= '0'; wait until ready_o='1';
		
		wait for CLK_PERIOD;
		rd_en <= '1';
		wait for CLK_PERIOD *2;
		--assert output_o="01000000010100111010001010110011";
		rd_en <= '0';
		wait for CLK_PERIOD;

        								start_i <= '0';
		----------------------------------------------------------------------------------------------------------------------------------------------------
		assert false
		report "Success!!!.......Yahoooooooooooooo"
		severity failure;	
				
    	wait;

    end process verify;

end rtl;