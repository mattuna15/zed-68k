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
---- The following operations are additionally supported by this    ----
---- core:                                                          ----
----   - LINK (long).                                               ----
----   - MOVE FROM CCR.                                             ----
----   - MULS, MULU: all operation modes word and long.             ----
----   - DIVS, DIVU: all operation modes word and long.             ----
----   - DIVSL, DIVUL.                                              ----
----   - Direct addressing mode enhancements for TST etc.           ----
----   - PC relative addressing modes for operations like TST.      ----
----                                                                ----
---- This file is the top level file of the ip core.                ----
----                                                                ----
----                                                                ----
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
-- Revision 2K8B  2008/12/24 WF
--   Initial Release.
-- Revision 2K15B  2051224 WF
--   Replaced data type bit with std_logic.
-- Revision 2K19A 20190419 WF
--   Due to the availablability of the new 68K10/00 ip core which is under the
--     CERN open hardware license (CERN OHL), this core is switched from  
--     GPL-2.0 to Apache License, Version 2.0
-- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity WF68K00IP_TOP is
	port (
		CLK			: in std_logic;
		RESET_COREn	: in std_logic; -- Core reset.
		
		-- Address and data:
		ADR		: out std_logic_vector(23 downto 1);
		DATA	: inout std_logic_vector(15 downto 0);

		-- System control:
		BERRn	: in std_logic;
		RESETn	: inout std_logic; -- Open drain.
		HALTn	: inout std_logic; -- Open drain.
		
		-- Processor status:
		FC		: out std_logic_vector(2 downto 0);
		
		-- Interrupt control:
		AVECn	: in std_logic; -- Originally 68Ks use VPAn.
		IPLn	: in std_logic_vector(2 downto 0);
		
		-- Aynchronous bus control:
		DTACKn	: in std_logic;
		ASn		: out std_logic;
		RWn		: out std_logic;
		UDSn	: out std_logic;
		LDSn	: out std_logic;
		
		-- Synchronous peripheral control:
		E		: out std_logic;
		VMAn	: out std_logic;
		VPAn	: in std_logic;
		
		-- Bus arstd_logicration control:
		BRn		: in std_logic;
		BGn		: out std_logic;
		BGACKn	: in std_logic
	);
end entity WF68K00IP_TOP;
	
architecture STRUCTURE of WF68K00IP_TOP is
component WF68K00IP_TOP_SOC -- CPU.
    port (
        CLK				: in std_logic;
        RESET_COREn		: in std_logic; -- Core reset.
        ADR_OUT			: out std_logic_vector(23 downto 1);
        ADR_EN			: out std_logic;
        DATA_IN			: in std_logic_vector(15 downto 0);
        DATA_OUT		: out std_logic_vector(15 downto 0);
        DATA_EN			: out std_logic;
        BERRn			: in std_logic;
        RESET_INn		: in std_logic;
        RESET_OUT_EN	: out std_logic; -- Open drain.
        HALT_INn		: in std_logic;
        HALT_OUT_EN		: out std_logic; -- Open drain.
        FC_OUT			: out std_logic_vector(2 downto 0);
        FC_OUT_EN		: out std_logic;
        AVECn			: in std_logic;
        IPLn			: in std_logic_vector(2 downto 0);
        DTACKn			: in std_logic;
        AS_OUTn			: out std_logic;
        AS_OUT_EN		: out std_logic;
        RWn_OUT			: out std_logic;
        RW_OUT_EN		: out std_logic;
        UDS_OUTn		: out std_logic;
        UDS_OUT_EN		: out std_logic;
        LDS_OUTn		: out std_logic;
        LDS_OUT_EN		: out std_logic;
        E				: out std_logic;
        VMA_OUTn		: out std_logic;
        VMA_OUT_EN		: out std_logic;
        VPAn			: in std_logic;
        BRn				: in std_logic;
        BGn				: out std_logic;
        BGACKn			: in std_logic
        );
end component WF68K00IP_TOP_SOC;
signal RESET_EN     : std_logic;
signal HALT_EN      : std_logic;
signal ADR_EN       : std_logic;
signal ADR_OUT      : std_logic_vector(23 downto 1);
signal DATA_EN      : std_logic;
signal DATA_OUT     : std_logic_vector(15 downto 0);
signal FC_EN        : std_logic;
signal FC_OUT       : std_logic_vector(2 downto 0);
signal AS_OUTn      : std_logic;
signal AS_EN        : std_logic;
signal RWn_OUT      : std_logic;
signal RW_EN        : std_logic;
signal UDS_OUTn     : std_logic;
signal UDS_EN       : std_logic;
signal LDS_OUTn     : std_logic;
signal LDS_EN       : std_logic;
signal VMA_OUTn     : std_logic;
signal VMA_EN       : std_logic;
signal AVEC_In      : std_logic;
begin
    ADR <= ADR_OUT when ADR_EN = '1' else (others => 'Z');
    DATA <= DATA_OUT when DATA_EN = '1' else (others => 'Z');

    AVEC_In <= AVECn and VPAn; -- Wired or, use respective weak pull ups.

	-- Open drain outputs:
	RESETn <= '0' when RESET_EN = '1' else 'Z';
	HALTn <= '0' when HALT_EN = '1' else 'Z';

	-- Bus controls:
	ASn	<= AS_OUTn when AS_EN = '1' else 'Z';
	UDSn <= UDS_OUTn when UDS_EN = '1' else 'Z';
	LDSn <= LDS_OUTn when LDS_EN = '1' else 'Z';
	RWn <= RWn_OUT when RW_EN = '1' else 'Z';
	VMAn <= VMA_OUTn when VMA_EN = '1' else 'Z';

	-- The function code:
	FC <= FC_OUT when FC_EN = '1' else (others => 'Z');

    I_68K00: WF68K00IP_TOP_SOC
        port map(
            CLK             => CLK,
            RESET_COREn     => RESET_COREn,
            ADR_OUT         => ADR_OUT,
            ADR_EN          => ADR_EN,
            DATA_IN         => DATA,
            DATA_OUT        => DATA_OUT,
            DATA_EN         => DATA_EN,
            BERRn           => BERRn,
            RESET_INn       => RESETn,
            RESET_OUT_EN    => RESET_EN,
            HALT_INn        => HALTn,
            HALT_OUT_EN     => HALT_EN,
            FC_OUT          => FC_OUT,
            FC_OUT_EN       => FC_EN,
            AVECn           => AVEC_In,
            IPLn            => IPLn,
            DTACKn          => DTACKn,
            AS_OUTn         => AS_OUTn,
            AS_OUT_EN       => AS_EN,
            RWn_OUT         => RWn_OUT,
            RW_OUT_EN       => RW_EN,
            UDS_OUTn        => UDS_OUTn,
            UDS_OUT_EN      => UDS_EN,
            LDS_OUTn        => LDS_OUTn,
            LDS_OUT_EN      => LDS_EN,
            E               => E,
            VMA_OUTn        => VMA_OUTn,
            VMA_OUT_EN      => VMA_EN,
            VPAn            => VPAn,
            BRn             => BRn,
            BGn             => BGn,
            BGACKn          => BGACKn
            );
end STRUCTURE;
