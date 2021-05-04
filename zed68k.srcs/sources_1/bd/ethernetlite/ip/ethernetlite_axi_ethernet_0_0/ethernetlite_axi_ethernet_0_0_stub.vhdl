-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Tue May  4 10:56:05 2021
-- Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/code/zed-68k/zed68k.srcs/sources_1/bd/ethernetlite/ip/ethernetlite_axi_ethernet_0_0/ethernetlite_axi_ethernet_0_0_stub.vhdl
-- Design      : ethernetlite_axi_ethernet_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35ticsg324-1L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ethernetlite_axi_ethernet_0_0 is
  Port ( 
    address : in STD_LOGIC_VECTOR ( 31 downto 0 );
    wr_data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    wr_byte_mask : in STD_LOGIC_VECTOR ( 3 downto 0 );
    i_cen : in STD_LOGIC;
    i_wren : in STD_LOGIC;
    i_valid_p : in STD_LOGIC;
    rd_data : out STD_LOGIC_VECTOR ( 31 downto 0 );
    o_ready_p : out STD_LOGIC;
    wr_ack_p : out STD_LOGIC;
    o_valid_p : out STD_LOGIC;
    sys_resetn : in STD_LOGIC;
    sys_clock : in STD_LOGIC;
    ui_clk : in STD_LOGIC;
    ui_clk_sync_rst : in STD_LOGIC;
    s_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awvalid : out STD_LOGIC;
    s_axi_awready : in STD_LOGIC;
    s_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wlast : out STD_LOGIC;
    s_axi_wvalid : out STD_LOGIC;
    s_axi_wready : in STD_LOGIC;
    s_axi_bready : out STD_LOGIC;
    s_axi_bid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : in STD_LOGIC;
    s_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arvalid : out STD_LOGIC;
    s_axi_arready : in STD_LOGIC;
    s_axi_rready : out STD_LOGIC;
    s_axi_rid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : in STD_LOGIC;
    s_axi_rvalid : in STD_LOGIC;
    init_calib_complete : in STD_LOGIC
  );

end ethernetlite_axi_ethernet_0_0;

architecture stub of ethernetlite_axi_ethernet_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "address[31:0],wr_data[31:0],wr_byte_mask[3:0],i_cen,i_wren,i_valid_p,rd_data[31:0],o_ready_p,wr_ack_p,o_valid_p,sys_resetn,sys_clock,ui_clk,ui_clk_sync_rst,s_axi_awaddr[31:0],s_axi_awlen[7:0],s_axi_awsize[2:0],s_axi_awburst[1:0],s_axi_awvalid,s_axi_awready,s_axi_wdata[31:0],s_axi_wstrb[3:0],s_axi_wlast,s_axi_wvalid,s_axi_wready,s_axi_bready,s_axi_bid[3:0],s_axi_bresp[1:0],s_axi_bvalid,s_axi_araddr[31:0],s_axi_arlen[7:0],s_axi_arsize[2:0],s_axi_arburst[1:0],s_axi_arvalid,s_axi_arready,s_axi_rready,s_axi_rid[3:0],s_axi_rdata[31:0],s_axi_rresp[1:0],s_axi_rlast,s_axi_rvalid,init_calib_complete";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "axi_ethernet,Vivado 2020.1";
begin
end;
