------------------------------------------------------------------------
----                                                                ----
---- MC68000 compatible IP Core					                    ----
----                                                                ----
---- This file is part of the SUSKA ATARI clone project.            ----
---- http://www.experiment-s.de                                     ----
----                                                                ----
---- Description:                                                   ----
---- This model provides an opcode and bus timing compatible ip     ----
---- core compared to Motorola's MC68000 microprocessor.            ----
----                                                                ----
---- This file contains the 68Ks shifter unit.                      ----
----                                                                ----
----                                                                ----
---- Description:                                                   ----
---- This module performs the shifting operations ASL, ASR, LSL,    ----
---- LSR, ROL, ROR, ROXL and ROXR as also the bit manipulation      ----
---- and test operations BCHG, BCLR, BSET and BTST.                 ----
---- The timing of the core is as follows:                          ----
---- All bit manipulation operations are performed by concurrent    ----
---- statement modelling which results in immediate bit process-    ----
---- ing. Thus, the result is valid one clock cycle after the       ----
---- settings for the operands are stable.                          ----
---- The shift and rotate operations start with SHIFTER_LOAD.       ----
---- The data processing time is depending on the selected number   ----
---- of bits and is indicated by the SHFT_BUSY flag. During         ----
---- SHFT_BUSY is asserted, the data calculation is in progress.    ----
---- The execution time for these operations is n clock             ----
---- cycles +2 where n is the desired number of shifts or rotates.  ----
----                                                                ----
----                                                                ----
---- Author(s):                                                     ----
---- - Wolfgang Foerster, wf@experiment-s.de; wf@inventronik.de     ----
----                                                                ----
------------------------------------------------------------------------
----                                                                ----
---- Copyright (C) 2019 Wolfgang Foerster. All rights reserved.     ----
----                                                                ----
---- Licensed under the Apache License, Version 2.0 (the "License") ----
---- you may not use this file except in compliance with the        ----
---- License. You may obtain a copy of the License at               ----
----                                                                ----
----     http://www.apache.org/licenses/LICENSE-2.0                 ----
----                                                                ----
---- Unless required by applicable law or agreed to in writing,     ----
---- software distributed under the License is distributed on an    ----
---- "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,   ----
---- either express or implied. See the License for the specific    ----
---- language governing permissions and limitations under the       ----
---- License.                                                       ----
----                                                                ----
---- Enjoy.                                                         ----
----                                                                ----
------------------------------------------------------------------------
-- 
-- Revision History
-- 
-- Revision 2K6B  2006/12/24 WF
--   Initial Release.
-- Revision 2K7A  2007/05/31 WF
--   Updated all modules.
-- Revision 2K7B  2007/12/24 WF
--   See the 68K00 top level file.
-- Revision 2K8A  2008/07/14 WF
--   See the 68K00 top level file.
-- Revision 2K11A  2011/06/20 WF
--   Cleaned up the condition code logic.
--   Removed the signal SHFT_BREAK from logic and entity.
-- Revision 2K15B  20151224 WF
--   Replaced the several data types from bit to std_logic.
-- Revision 2K19A 20190419 WF
--   Due to the availablability of the new 68K10/00 ip core which is under the
--     CERN open hardware license (CERN OHL), this core is switched from  
--     GPL-2.0 to Apache License, Version 2.0
-- 

use work.wf68k00ip_pkg.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity WF68K00IP_SHIFTER is
	port (
		CLK				: in std_logic;
		RESETn			: in std_logic;

		DATA_IN			: in std_logic_vector(31 downto 0); -- Operand data.
		DATA_OUT		: out std_logic_vector(31 downto 0); -- Shifted operand.

		OP				: in OP_68K00;
		
		OP_SIZE			: in OP_SIZETYPE; -- The operand's size.
		BIT_POS			: in std_logic_vector(4 downto 0); -- Bit position control.
		CNT_NR			: in std_logic_vector(5 downto 0); -- Count control.
		
		-- Progress controls:
		SHIFTER_LOAD	: in bit; -- Strobe of 1 clock pulse.
		SHFT_BUSY		: out bit;
		
		-- The FLAGS:
		XNZVC_IN		: in std_logic_vector(4 downto 0);
		XNZVC_OUT		: out std_logic_vector(4 downto 0)
		);
end entity WF68K00IP_SHIFTER;
	
architecture BEHAVIOR of WF68K00IP_SHIFTER is
type SHIFT_STATES is (IDLE, RUN);
signal SHIFT_STATE	: SHIFT_STATES;
signal BIT_OP		: std_logic_vector(31 downto 0);
signal SHFT_OP		: std_logic_vector(31 downto 0);
signal SHFT_EN		: bit;
signal X_FLAG		: std_logic;
begin
	-- Output multiplexer:
	with OP select
		DATA_OUT <= BIT_OP when BCHG | BCLR | BSET | BTST,
					SHFT_OP when others; -- Valid for ASL | ASR | LSL | LSR | ROTL | ROTR | ROXL | ROXR.

	BIT_PROC: process(BIT_POS, OP, DATA_IN)
	-- Bit manipulation operations.
	variable BIT_POSITION	: integer range 0 to 31;
	begin
		BIT_POSITION := Conv_Integer(BIT_POS);
		--
		BIT_OP <= DATA_IN; -- The default is the unmanipulated data.
		--
		case OP is
			when BCHG =>
				BIT_OP(BIT_POSITION) <= not DATA_IN(BIT_POSITION);
			when BCLR =>
				BIT_OP(BIT_POSITION) <= '0';
			when BSET =>
				BIT_OP(BIT_POSITION) <= '1';
			when others => 
				BIT_OP <= DATA_IN; -- Dummy, no result required for BTST.
		end case;
	end process BIT_PROC;

	SHIFTER: process(RESETn, CLK)
	begin
		if RESETn = '0' then
			SHFT_OP <= (others => '0');
		elsif CLK = '1' and CLK' event then
			if SHIFTER_LOAD = '1' then -- Load data in the shifter unit.
				SHFT_OP <= DATA_IN; -- Load data for the shift or rotate operations.
			elsif SHFT_EN = '1' then -- Shift and rotate operations:
				case OP is
					when ASL =>
						if OP_SIZE = LONG then
							SHFT_OP <= SHFT_OP(30 downto 0) & '0';
						elsif OP_SIZE = WORD then
							SHFT_OP <= x"0000" & SHFT_OP(14 downto 0) & '0';
						else -- OP_SIZE = BYTE.
							SHFT_OP <= x"000000" & SHFT_OP(6 downto 0) & '0';
						end if;
					when ASR =>
						if OP_SIZE = LONG then
							SHFT_OP <= SHFT_OP(31) & SHFT_OP(31 downto 1);
						elsif OP_SIZE = WORD then
							SHFT_OP <= x"0000" & SHFT_OP(15) & SHFT_OP(15 downto 1);
						else -- OP_SIZE = BYTE.
							SHFT_OP <= x"000000" & SHFT_OP(7) & SHFT_OP(7 downto 1);
						end if;
					when LSL =>
						if OP_SIZE = LONG then
							SHFT_OP <= SHFT_OP(30 downto 0) & '0';
						elsif OP_SIZE = WORD then
							SHFT_OP <= x"0000" & SHFT_OP(14 downto 0) & '0';
						else -- OP_SIZE = BYTE.
							SHFT_OP <= x"000000" & SHFT_OP(6 downto 0) & '0';
						end if;
					when LSR =>
						if OP_SIZE = LONG then
							SHFT_OP <= '0' & SHFT_OP(31 downto 1);
						elsif OP_SIZE = WORD then
							SHFT_OP <= x"0000" & '0' & SHFT_OP(15 downto 1);
						else -- OP_SIZE = BYTE.
							SHFT_OP <= x"000000" & '0' & SHFT_OP(7 downto 1);
						end if;
					when ROTL =>
						if OP_SIZE = LONG then
							SHFT_OP <= SHFT_OP(30 downto 0) & SHFT_OP(31);
						elsif OP_SIZE = WORD then
							SHFT_OP <= x"0000" & SHFT_OP(14 downto 0) & SHFT_OP(15);
						else -- OP_SIZE = BYTE.
							SHFT_OP <= x"000000" & SHFT_OP(6 downto 0) & SHFT_OP(7);
						end if;
						-- X not affected;
					when ROTR =>
						if OP_SIZE = LONG then
							SHFT_OP <= SHFT_OP(0) & SHFT_OP(31 downto 1);
						elsif OP_SIZE = WORD then
							SHFT_OP <= x"0000" & SHFT_OP(0) & SHFT_OP(15 downto 1);
						else -- OP_SIZE = BYTE.
							SHFT_OP <= x"000000" & SHFT_OP(0) & SHFT_OP(7 downto 1);
						end if;
						-- X not affected;
					when ROXL =>
						if OP_SIZE = LONG then
							SHFT_OP <= SHFT_OP(30 downto 0) & X_FLAG;
						elsif OP_SIZE = WORD then
							SHFT_OP <= x"0000" & SHFT_OP(14 downto 0) & X_FLAG;
						else -- OP_SIZE = BYTE.
							SHFT_OP <= x"000000" & SHFT_OP(6 downto 0) & X_FLAG;
						end if;
					when ROXR =>
						if OP_SIZE = LONG then
							SHFT_OP <= X_FLAG & SHFT_OP(31 downto 1);
						elsif OP_SIZE = WORD then
							SHFT_OP <= x"0000" & X_FLAG & SHFT_OP(15 downto 1);
						else -- OP_SIZE = BYTE.
							SHFT_OP <= x"000000" & X_FLAG & SHFT_OP(7 downto 1);
						end if;
					when others => null; -- Unaffected, forbidden.
				end case;
			end if;
		end if;
	end process SHIFTER;

	P_SHFT_CTRL: process(RESETn, CLK, OP)
	-- The variable shift or rotate length requires a control
	-- to achieve the correct OPERAND manipulation. This
	-- process controls the shift process and asserts the
	-- SHFT_BUSY flag during shift or rotation.
	variable BIT_CNT	: std_logic_vector(5 downto 0);
	begin
		if RESETn = '0' then
			SHIFT_STATE <= IDLE;
			BIT_CNT := (others => '0');
			SHFT_EN <= '0';
			SHFT_BUSY <= '0';
		elsif CLK = '1' and CLK' event then
			if SHIFT_STATE = IDLE then
				if SHIFTER_LOAD = '1' and CNT_NR /= "000000" then
					SHIFT_STATE <= RUN;
					BIT_CNT := CNT_NR;
					SHFT_EN <= '1';
					SHFT_BUSY <= '1';
				else
					SHIFT_STATE <= IDLE;
					BIT_CNT := (others => '0');
					SHFT_EN <= '0';
					SHFT_BUSY <= '0';
				end if;
			elsif SHIFT_STATE = RUN then
				if BIT_CNT = "000001" then
					SHIFT_STATE <= IDLE;
					BIT_CNT := CNT_NR;
					SHFT_EN <= '0';
					SHFT_BUSY <= '0';
				else
					SHIFT_STATE <= RUN;
					BIT_CNT := BIT_CNT - '1';
					SHFT_EN <= '1';
					SHFT_BUSY <= '1';
				end if;
			end if;
		end if;
	end process P_SHFT_CTRL;

	COND_CODES: process(BIT_POS, OP, XNZVC_IN, DATA_IN, OP_SIZE, SHFT_OP, X_FLAG, CNT_NR, RESETn, CLK)
	-- This process provides the flags for the shifter and the bit operations.
	-- The flags for the shifter are valid after the shift operation, when the
	-- SHFT_BUSY flag is not asserted. The flags of the bit operations are
	-- valid immediately due to the one clock cycle process time.
	variable BIT_POSITION	: integer range 0 to 31;
	variable N_FLAG         : std_logic;
	variable Z_FLAG         : std_logic;
	variable V_FLAG			: std_logic;
	variable C_FLAG			: std_logic;
	begin
		BIT_POSITION := Conv_Integer(BIT_POS); -- Valid during the bit manipulation operations:
		--
		-- Extended flag:
		if RESETn = '0' then
			X_FLAG <= '0';
		elsif CLK = '1' and CLK' event then
            if SHIFTER_LOAD = '1' or CNT_NR = "000000" then
                X_FLAG <= XNZVC_IN(4);
            elsif SHFT_EN = '1' then
                case OP is
                    when ROTL | ROTR => 
                        X_FLAG <= XNZVC_IN(4); -- Unaffected.
                    when ASL | LSL | ROXL =>
                        case OP_SIZE is
                            when LONG =>
                                X_FLAG <= SHFT_OP(31);
                            when WORD =>
                                X_FLAG <= SHFT_OP(15);
                            when BYTE =>
                                X_FLAG <= SHFT_OP(7);
                        end case;
                    when others => -- ASR, LSR, ROXR.
                        X_FLAG <= SHFT_OP(0);
                end case;
            end if;
        end if;

        -- Negative flag:
        case OP_SIZE is
            when LONG => 
                N_FLAG := SHFT_OP(31);
            when WORD => 
                N_FLAG := SHFT_OP(15);
            when others => 
                N_FLAG := SHFT_OP(7); -- Byte.
        end case;

        -- Zero flag:
        if OP_SIZE = LONG and SHFT_OP = x"00000000" then
            Z_FLAG := '1';
        elsif OP_SIZE = WORD and SHFT_OP(15 downto 0) = x"0000" then
            Z_FLAG := '1';
        elsif OP_SIZE = BYTE and SHFT_OP(7 downto 0) = x"00" then
            Z_FLAG := '1';
        else
            Z_FLAG := '0';
        end if;

        -- Overflow flag:
        if RESETn = '0' then
            -- This process provides a detection of any toggling of the most significant
            -- bit of the shifter unit during the ASL shift process. For all other shift
            -- operations, the V flag is always zero.
            V_FLAG := '0';
        elsif CLK = '1' and CLK' event then
            if SHIFTER_LOAD = '1' or CNT_NR = "000000" then
                V_FLAG := '0';
            elsif SHFT_EN = '1' then
                case OP is
                    when ASL => -- ASR MSB is always unchanged.
                        if OP_SIZE = LONG then
                            V_FLAG := (SHFT_OP(31) xor SHFT_OP(30)) or V_FLAG;
                        elsif OP_SIZE = WORD then
                            V_FLAG := (SHFT_OP(15) xor SHFT_OP(14)) or V_FLAG;
                        else -- OP_SIZE = BYTE.
                            V_FLAG := (SHFT_OP(7) xor SHFT_OP(6)) or V_FLAG;
                        end if;
                when others =>
                    V_FLAG := '0';
                end case;
            end if;
        end if;

        -- Carry Flag:
        if RESETn = '0' then
            C_FLAG := '0';
        elsif CLK = '1' and CLK' event then
            if (OP = ROXL or OP = ROXR) and CNT_NR = "000000" then
                C_FLAG := XNZVC_IN(4);
            elsif CNT_NR = "000000" then
                C_FLAG := '0';
            else
                case OP is
                    when ASL | LSL | ROTL | ROXL =>
                        case OP_SIZE is
                            when LONG =>
                                C_FLAG := SHFT_OP(31);
                            when WORD =>
                                C_FLAG := SHFT_OP(15);
                            when BYTE =>
                                C_FLAG := SHFT_OP(7);
                        end case;
                    when others => -- ASR, LSR, ROTR, ROXR
                        C_FLAG := SHFT_OP(0);
                end case;
            end if;
        end if;

		case OP is
			when BCHG | BCLR | BSET | BTST =>
                XNZVC_OUT <= XNZVC_IN(4 downto 3) & not DATA_IN(BIT_POSITION) & XNZVC_IN(1 downto 0);
			when others => -- ASL, ASR, LSL, LSR, TOL, ROR, ROXL, ROXR.
                XNZVC_OUT <= X_FLAG & N_FLAG & Z_FLAG & V_FLAG & C_FLAG;
		end case;
	end process COND_CODES;
end BEHAVIOR;
