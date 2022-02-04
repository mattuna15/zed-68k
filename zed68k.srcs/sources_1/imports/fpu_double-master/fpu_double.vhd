---------------------------------------------------------------------
----                                                             ----
----  FPU                                                        ----
----  Floating Point Unit (Double precision)                     ----
----                                                             ----
----  Author: David Lundgren                                     ----
----          davidklun@gmail.com                                ----
----                                                             ----
---------------------------------------------------------------------
----                                                             ----
---- Copyright (C) 2009 David Lundgren                           ----
----                  davidklun@gmail.com                        ----
----                                                             ----
---- This source file may be used and distributed without        ----
---- restriction provided that this copyright statement is not   ----
---- removed from the file and that any derivative work contains ----
---- the original copyright notice and the associated disclaimer.----
----                                                             ----
----     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ----
---- EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ----
---- TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ----
---- FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ----
---- OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ----
---- INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ----
---- (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ----
---- GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ----
---- BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ----
---- LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ----
---- (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ----
---- OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ----
---- POSSIBILITY OF SUCH DAMAGE.                                 ----
----                                                             ----
---------------------------------------------------------------------
	
	LIBRARY ieee;
use ieee.std_logic_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.numeric_std.all;
	library work;	  
	
	ENTITY fpu_double IS

   PORT( 
      clk, rst, enable : IN     std_logic;
      rmode : IN     std_logic_vector (1 DOWNTO 0);
      fpu_op : IN     std_logic_vector (2 DOWNTO 0);
      opa, opb : IN     std_logic_vector (63 DOWNTO 0);
      out_fp_reg: OUT    std_logic_vector (63 DOWNTO 0);
      idle, valid : OUT  std_logic
   );

	END fpu_double;
	
-- FPU Operations (fpu_op):
--========================
--	0 = add
--	1 = sub
--	2 = mul
--	3 = div
--  4 = sqrt
--  5 = sgl - dbl
--  6 = dbl - sgl

--Rounding Modes (rmode):
--=======================
--	0 = round_nearest_even
--	1 = round_to_zero
--	2 = round_up
--	3 = round_down  

	architecture rtl of fpu_double is
	
	signal  opa_reg : std_logic_vector(63 downto 0);
	signal  opb_reg : std_logic_vector(63 downto 0);
	signal  fpu_op_reg : std_logic_vector(2 downto 0);
	signal  rmode_reg : std_logic_vector(1 downto 0);
	signal	enable_reg : std_logic;
	signal	enable_reg_1 : std_logic; -- high for one clock cycle
	signal	enable_reg_2 : std_logic; -- high for one clock cycle		 
	signal	enable_reg_3 : std_logic; -- high for two clock cycles
	signal	op_enable : std_logic;	  
	
	signal	add_enable : std_logic; 
	signal	sub_enable : std_logic; 
	signal	mul_enable : std_logic; 
	signal	div_enable : std_logic;    
	
	signal	mul_out : std_logic_vector(55 downto 0);
	signal	div_out : std_logic_vector(55 downto 0);
	signal in_progress : std_logic;
	
	signal out_add : std_logic_vector(63 downto 0);
    signal out_sub : std_logic_vector(63 downto 0);
	signal out_mul : std_logic_vector(63 downto 0);
    signal out_div, out_fp : std_logic_vector(63 downto 0);
	
	signal add_ready, sub_ready, mul_ready, div_ready, out_valid : std_logic;
	
	signal out_sqrt : std_logic_vector(63 downto 0);
	signal sqrt_enable, sqrt_ready : std_logic;
	
	signal out_sgldbl : std_logic_vector(63 downto 0);
	signal sgldbl_enable, sgldbl_ready : std_logic;
	
	signal out_dblsgl : std_logic_vector(31 downto 0);
	signal dblsgl_enable, dblsgl_ready : std_logic;
	
	signal reset_n : std_logic;
	
	begin
				
    idle <= not in_progress;
    valid <= out_valid;
    reset_n <= not rst;
    out_fp_reg <= out_fp when valid = '1';
    
    i_fpu_add : entity work.fpaddsub 
    Port map ( 
        clock_i => clk,
        reset_n => reset_n,
        op_a => opa_reg, 
        op_b => opb_reg,
        mode => '0',
        result => out_add,
        valid_i => add_enable,
        ready_o => add_ready
    
    );
    
    i_fpu_sub : entity work.fpaddsub 
    Port map ( 
        clock_i => clk,
        reset_n => reset_n,
        op_a => opa_reg, 
        op_b => opb_reg,
        mode => '1',
        result => out_sub,
        valid_i => sub_enable,
        ready_o => sub_ready
    
    );
    
    i_fpu_mul : entity work.fpmult 
    Port map ( 
        clock_i => clk,
        reset_n => reset_n,
        op_a => opa_reg, 
        op_b => opb_reg,

        result => out_mul,
        valid_i => mul_enable,
        ready_o => mul_ready
    
    );
		
    i_fpu_div : entity work.fpdiv 
    Port map ( 
        clock_i => clk,
        reset_n => reset_n,
        op_a => opa_reg, 
        op_b => opb_reg,

        result => out_div,
        valid_i => div_enable,
        ready_o => div_ready
    
    );
		
    i_fpu_sqrt : entity work.fpsqrt 
    Port map ( 
        clock_i => clk,
        reset_n => reset_n,
        op_a => opa_reg, 
        result => out_sqrt,
        valid_i => sqrt_enable,
        ready_o => sqrt_ready
    );
	
	process
	begin
	wait until clk'event and clk = '1';
		if (rst = '1') then
			add_enable <= '0';
			sub_enable <= '0';
			mul_enable <= '0';
			div_enable <= '0';
		    sqrt_enable <= '0';
		else 
			if fpu_op_reg = "000" and op_enable = '1' and enable_reg_3 = '1' then
				add_enable <= '1';
			else
				add_enable <= '0';
			end if;
			if fpu_op_reg = "001" and op_enable = '1' and enable_reg_3 = '1' then
				sub_enable <= '1';
			else
				sub_enable <= '0';
			end if;
			if fpu_op_reg = "010" and op_enable = '1' and enable_reg_3 = '1'then
				mul_enable <= '1';
			else
				mul_enable <= '0';
			end if;
			if fpu_op_reg = "100" and op_enable = '1' and enable_reg_3 = '1' then
				sqrt_enable <= '1';
			else
				sqrt_enable <= '0';
			end if;
		  if fpu_op_reg = "101" and op_enable = '1' and enable_reg_3 = '1' then
				sgldbl_enable <= '1';
			else
				sgldbl_enable <= '0';
			end if;
			if fpu_op_reg = "110" and op_enable = '1' and enable_reg_3 = '1' then
				dblsgl_enable <= '1';
			else
				dblsgl_enable <= '0';
			end if;
			if fpu_op_reg = "011" and op_enable = '1' and enable_reg_3 = '1' then
				div_enable <= '1';
			else
				div_enable <= '0';
			end if;  -- div_enable needs to be high for two clock cycles
			
		end if;
	end process;
	
	process
	begin
	wait until clk'event and clk = '1';
		if (rst = '1') then
			enable_reg <= '0';
			enable_reg_1 <= '0';
			enable_reg_2 <= '0';	   
			enable_reg_3 <= '0';
		else
			enable_reg <= enable;
			if enable = '1' and enable_reg = '0' then
				enable_reg_1 <= '1';
			else
				enable_reg_1 <= '0';
			end if;
			enable_reg_2 <= enable_reg_1;
			if enable_reg_1 = '1' or enable_reg_2 = '1' then   
				enable_reg_3 <= '1';
			else
				enable_reg_3 <= '0';
			end if;
		end if; 
	end process;
			
	process
	begin
	wait until clk'event and clk = '1';
		if (rst = '1') then
			opa_reg <= (others =>'0');
			opb_reg <= (others =>'0');
			fpu_op_reg <= (others =>'0'); 
			rmode_reg <= (others =>'0');
			op_enable <= '0';
		elsif (enable_reg_1 = '1') then
			opa_reg <= opa;
			opb_reg <= opb;
			fpu_op_reg <= fpu_op; 
			rmode_reg <= rmode;
			op_enable <= '1';
		elsif enable_reg_3 = '1' then
		    op_enable <= '0';
		end if; 
	end process;
	
	process 
	begin
	
	wait until clk'event and clk = '1';
		if (rst = '1') then
            in_progress <= '0';
            out_valid <= '0';
		elsif (enable_reg_1 = '1') then
            in_progress <= '1';
            out_valid <= '0';
		elsif (fpu_op_reg = "000" and add_ready = '1'  and in_progress = '1' )
		      or (fpu_op_reg = "001" and sub_ready = '1'  and in_progress = '1'  )
		      or (fpu_op_reg = "010" and mul_ready = '1'  and in_progress = '1'  )  
		      or (fpu_op_reg = "011" and div_ready = '1'  and in_progress = '1'  ) 
		      or (fpu_op_reg = "100" and sqrt_ready = '1' and in_progress = '1'  ) then
           if fpu_op_reg = "000" then
	           out_fp <= out_add;
	       elsif fpu_op_reg = "001" then
	           out_fp <= out_sub;
	       elsif fpu_op_reg = "010" then
	           out_fp <= out_mul;
	       elsif fpu_op_reg = "011" then
	           out_fp <= out_div;
	       elsif fpu_op_reg = "100" then
	           out_fp <= out_sqrt;
	       end if;
	       
	       out_valid <= '1';
	    elsif out_valid = '1'  then
	       in_progress <= '0';
		end if; 
	end process;

end rtl;
