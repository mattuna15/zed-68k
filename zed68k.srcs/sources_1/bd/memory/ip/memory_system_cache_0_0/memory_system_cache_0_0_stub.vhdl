-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Tue Oct 12 19:59:06 2021
-- Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/code/zed-68k/zed68k.srcs/sources_1/bd/memory/ip/memory_system_cache_0_0/memory_system_cache_0_0_stub.vhdl
-- Design      : memory_system_cache_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity memory_system_cache_0_0 is
  Port ( 
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC;
    Initializing : out STD_LOGIC;
    S0_AXI_GEN_AWID : in STD_LOGIC_VECTOR ( 0 to 0 );
    S0_AXI_GEN_AWADDR : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S0_AXI_GEN_AWLEN : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S0_AXI_GEN_AWSIZE : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S0_AXI_GEN_AWBURST : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S0_AXI_GEN_AWLOCK : in STD_LOGIC;
    S0_AXI_GEN_AWCACHE : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S0_AXI_GEN_AWPROT : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S0_AXI_GEN_AWQOS : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S0_AXI_GEN_AWVALID : in STD_LOGIC;
    S0_AXI_GEN_AWREADY : out STD_LOGIC;
    S0_AXI_GEN_AWUSER : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S0_AXI_GEN_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S0_AXI_GEN_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S0_AXI_GEN_WLAST : in STD_LOGIC;
    S0_AXI_GEN_WVALID : in STD_LOGIC;
    S0_AXI_GEN_WREADY : out STD_LOGIC;
    S0_AXI_GEN_BRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S0_AXI_GEN_BID : out STD_LOGIC_VECTOR ( 0 to 0 );
    S0_AXI_GEN_BVALID : out STD_LOGIC;
    S0_AXI_GEN_BREADY : in STD_LOGIC;
    S0_AXI_GEN_ARID : in STD_LOGIC_VECTOR ( 0 to 0 );
    S0_AXI_GEN_ARADDR : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S0_AXI_GEN_ARLEN : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S0_AXI_GEN_ARSIZE : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S0_AXI_GEN_ARBURST : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S0_AXI_GEN_ARLOCK : in STD_LOGIC;
    S0_AXI_GEN_ARCACHE : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S0_AXI_GEN_ARPROT : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S0_AXI_GEN_ARQOS : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S0_AXI_GEN_ARVALID : in STD_LOGIC;
    S0_AXI_GEN_ARREADY : out STD_LOGIC;
    S0_AXI_GEN_ARUSER : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S0_AXI_GEN_RID : out STD_LOGIC_VECTOR ( 0 to 0 );
    S0_AXI_GEN_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S0_AXI_GEN_RRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S0_AXI_GEN_RLAST : out STD_LOGIC;
    S0_AXI_GEN_RVALID : out STD_LOGIC;
    S0_AXI_GEN_RREADY : in STD_LOGIC;
    M0_AXI_AWID : out STD_LOGIC_VECTOR ( 0 to 0 );
    M0_AXI_AWADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M0_AXI_AWLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M0_AXI_AWSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M0_AXI_AWBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M0_AXI_AWLOCK : out STD_LOGIC;
    M0_AXI_AWCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M0_AXI_AWPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M0_AXI_AWQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M0_AXI_AWVALID : out STD_LOGIC;
    M0_AXI_AWREADY : in STD_LOGIC;
    M0_AXI_WDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M0_AXI_WSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M0_AXI_WLAST : out STD_LOGIC;
    M0_AXI_WVALID : out STD_LOGIC;
    M0_AXI_WREADY : in STD_LOGIC;
    M0_AXI_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M0_AXI_BID : in STD_LOGIC_VECTOR ( 0 to 0 );
    M0_AXI_BVALID : in STD_LOGIC;
    M0_AXI_BREADY : out STD_LOGIC;
    M0_AXI_ARID : out STD_LOGIC_VECTOR ( 0 to 0 );
    M0_AXI_ARADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M0_AXI_ARLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M0_AXI_ARSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M0_AXI_ARBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M0_AXI_ARLOCK : out STD_LOGIC;
    M0_AXI_ARCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M0_AXI_ARPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M0_AXI_ARQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M0_AXI_ARVALID : out STD_LOGIC;
    M0_AXI_ARREADY : in STD_LOGIC;
    M0_AXI_RID : in STD_LOGIC_VECTOR ( 0 to 0 );
    M0_AXI_RDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M0_AXI_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M0_AXI_RLAST : in STD_LOGIC;
    M0_AXI_RVALID : in STD_LOGIC;
    M0_AXI_RREADY : out STD_LOGIC
  );

end memory_system_cache_0_0;

architecture stub of memory_system_cache_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "ACLK,ARESETN,Initializing,S0_AXI_GEN_AWID[0:0],S0_AXI_GEN_AWADDR[31:0],S0_AXI_GEN_AWLEN[7:0],S0_AXI_GEN_AWSIZE[2:0],S0_AXI_GEN_AWBURST[1:0],S0_AXI_GEN_AWLOCK,S0_AXI_GEN_AWCACHE[3:0],S0_AXI_GEN_AWPROT[2:0],S0_AXI_GEN_AWQOS[3:0],S0_AXI_GEN_AWVALID,S0_AXI_GEN_AWREADY,S0_AXI_GEN_AWUSER[31:0],S0_AXI_GEN_WDATA[31:0],S0_AXI_GEN_WSTRB[3:0],S0_AXI_GEN_WLAST,S0_AXI_GEN_WVALID,S0_AXI_GEN_WREADY,S0_AXI_GEN_BRESP[1:0],S0_AXI_GEN_BID[0:0],S0_AXI_GEN_BVALID,S0_AXI_GEN_BREADY,S0_AXI_GEN_ARID[0:0],S0_AXI_GEN_ARADDR[31:0],S0_AXI_GEN_ARLEN[7:0],S0_AXI_GEN_ARSIZE[2:0],S0_AXI_GEN_ARBURST[1:0],S0_AXI_GEN_ARLOCK,S0_AXI_GEN_ARCACHE[3:0],S0_AXI_GEN_ARPROT[2:0],S0_AXI_GEN_ARQOS[3:0],S0_AXI_GEN_ARVALID,S0_AXI_GEN_ARREADY,S0_AXI_GEN_ARUSER[31:0],S0_AXI_GEN_RID[0:0],S0_AXI_GEN_RDATA[31:0],S0_AXI_GEN_RRESP[1:0],S0_AXI_GEN_RLAST,S0_AXI_GEN_RVALID,S0_AXI_GEN_RREADY,M0_AXI_AWID[0:0],M0_AXI_AWADDR[31:0],M0_AXI_AWLEN[7:0],M0_AXI_AWSIZE[2:0],M0_AXI_AWBURST[1:0],M0_AXI_AWLOCK,M0_AXI_AWCACHE[3:0],M0_AXI_AWPROT[2:0],M0_AXI_AWQOS[3:0],M0_AXI_AWVALID,M0_AXI_AWREADY,M0_AXI_WDATA[31:0],M0_AXI_WSTRB[3:0],M0_AXI_WLAST,M0_AXI_WVALID,M0_AXI_WREADY,M0_AXI_BRESP[1:0],M0_AXI_BID[0:0],M0_AXI_BVALID,M0_AXI_BREADY,M0_AXI_ARID[0:0],M0_AXI_ARADDR[31:0],M0_AXI_ARLEN[7:0],M0_AXI_ARSIZE[2:0],M0_AXI_ARBURST[1:0],M0_AXI_ARLOCK,M0_AXI_ARCACHE[3:0],M0_AXI_ARPROT[2:0],M0_AXI_ARQOS[3:0],M0_AXI_ARVALID,M0_AXI_ARREADY,M0_AXI_RID[0:0],M0_AXI_RDATA[31:0],M0_AXI_RRESP[1:0],M0_AXI_RLAST,M0_AXI_RVALID,M0_AXI_RREADY";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "system_cache,Vivado 2020.1";
begin
end;
