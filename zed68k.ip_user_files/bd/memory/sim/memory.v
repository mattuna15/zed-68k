//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
//Date        : Tue Oct 12 19:51:16 2021
//Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
//Command     : generate_target memory.bd
//Design      : memory
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* HW_HANDOFF = "memory.hwdef" *) (* core_generation_info = "memory,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=memory,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=5,numReposBlks=5,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,da_board_cnt=1,da_clkrst_cnt=3,synth_mode=OOC_per_IP}" *) 
module memory
   (S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arid,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arsize,
    S_AXI_aruser,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awid,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awsize,
    S_AXI_awuser,
    S_AXI_awvalid,
    S_AXI_bid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rid,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid,
    clk_ref_i,
    ddr3_addr,
    ddr3_ba,
    ddr3_cas_n,
    ddr3_ck_n,
    ddr3_ck_p,
    ddr3_cke,
    ddr3_cs_n,
    ddr3_dm,
    ddr3_dq,
    ddr3_dqs_n,
    ddr3_dqs_p,
    ddr3_odt,
    ddr3_ras_n,
    ddr3_reset_n,
    ddr3_we_n,
    init_calib_complete,
    sys_clk_i,
    sys_rst,
    ui_clk,
    ui_clk_sync_rst);
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARADDR" *) (* x_interface_parameter = "XIL_INTERFACENAME S_AXI, ADDR_WIDTH 32, ARUSER_WIDTH 32, AWUSER_WIDTH 32, BUSER_WIDTH 0, CLK_DOMAIN memory_mig_7series_0_2_ui_clk, DATA_WIDTH 32, FREQ_HZ 83333333, HAS_BRESP 1, HAS_BURST 1, HAS_CACHE 1, HAS_LOCK 1, HAS_PROT 1, HAS_QOS 1, HAS_REGION 0, HAS_RRESP 1, HAS_WSTRB 1, ID_WIDTH 1, INSERT_VIP 0, MAX_BURST_LENGTH 256, NUM_READ_OUTSTANDING 2, NUM_READ_THREADS 1, NUM_WRITE_OUTSTANDING 2, NUM_WRITE_THREADS 1, PHASE 0, PROTOCOL AXI4, READ_WRITE_MODE READ_WRITE, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 1, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0" *) input [31:0]S_AXI_araddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARBURST" *) input [1:0]S_AXI_arburst;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARCACHE" *) input [3:0]S_AXI_arcache;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARID" *) input [0:0]S_AXI_arid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARLEN" *) input [7:0]S_AXI_arlen;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARLOCK" *) input S_AXI_arlock;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARPROT" *) input [2:0]S_AXI_arprot;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARQOS" *) input [3:0]S_AXI_arqos;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARREADY" *) output S_AXI_arready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARSIZE" *) input [2:0]S_AXI_arsize;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARUSER" *) input [31:0]S_AXI_aruser;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARVALID" *) input S_AXI_arvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWADDR" *) input [31:0]S_AXI_awaddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWBURST" *) input [1:0]S_AXI_awburst;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWCACHE" *) input [3:0]S_AXI_awcache;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWID" *) input [0:0]S_AXI_awid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWLEN" *) input [7:0]S_AXI_awlen;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWLOCK" *) input S_AXI_awlock;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWPROT" *) input [2:0]S_AXI_awprot;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWQOS" *) input [3:0]S_AXI_awqos;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWREADY" *) output S_AXI_awready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWSIZE" *) input [2:0]S_AXI_awsize;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWUSER" *) input [31:0]S_AXI_awuser;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWVALID" *) input S_AXI_awvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI BID" *) output [0:0]S_AXI_bid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI BREADY" *) input S_AXI_bready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI BRESP" *) output [1:0]S_AXI_bresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI BVALID" *) output S_AXI_bvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RDATA" *) output [31:0]S_AXI_rdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RID" *) output [0:0]S_AXI_rid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RLAST" *) output S_AXI_rlast;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RREADY" *) input S_AXI_rready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RRESP" *) output [1:0]S_AXI_rresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RVALID" *) output S_AXI_rvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WDATA" *) input [31:0]S_AXI_wdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WLAST" *) input S_AXI_wlast;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WREADY" *) output S_AXI_wready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WSTRB" *) input [3:0]S_AXI_wstrb;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WVALID" *) input S_AXI_wvalid;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 CLK.CLK_REF_I CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME CLK.CLK_REF_I, CLK_DOMAIN memory_clk_ref_i, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input clk_ref_i;
  (* x_interface_info = "xilinx.com:interface:ddrx:1.0 ddr3 ADDR" *) (* x_interface_parameter = "XIL_INTERFACENAME ddr3, AXI_ARBITRATION_SCHEME TDM, BURST_LENGTH 8, CAN_DEBUG false, CAS_LATENCY 11, CAS_WRITE_LATENCY 11, CS_ENABLED true, DATA_MASK_ENABLED true, DATA_WIDTH 8, MEMORY_TYPE COMPONENTS, MEM_ADDR_MAP ROW_COLUMN_BANK, SLOT Single, TIMEPERIOD_PS 1250" *) output [13:0]ddr3_addr;
  (* x_interface_info = "xilinx.com:interface:ddrx:1.0 ddr3 BA" *) output [2:0]ddr3_ba;
  (* x_interface_info = "xilinx.com:interface:ddrx:1.0 ddr3 CAS_N" *) output ddr3_cas_n;
  (* x_interface_info = "xilinx.com:interface:ddrx:1.0 ddr3 CK_N" *) output [0:0]ddr3_ck_n;
  (* x_interface_info = "xilinx.com:interface:ddrx:1.0 ddr3 CK_P" *) output [0:0]ddr3_ck_p;
  (* x_interface_info = "xilinx.com:interface:ddrx:1.0 ddr3 CKE" *) output [0:0]ddr3_cke;
  (* x_interface_info = "xilinx.com:interface:ddrx:1.0 ddr3 CS_N" *) output [0:0]ddr3_cs_n;
  (* x_interface_info = "xilinx.com:interface:ddrx:1.0 ddr3 DM" *) output [1:0]ddr3_dm;
  (* x_interface_info = "xilinx.com:interface:ddrx:1.0 ddr3 DQ" *) inout [15:0]ddr3_dq;
  (* x_interface_info = "xilinx.com:interface:ddrx:1.0 ddr3 DQS_N" *) inout [1:0]ddr3_dqs_n;
  (* x_interface_info = "xilinx.com:interface:ddrx:1.0 ddr3 DQS_P" *) inout [1:0]ddr3_dqs_p;
  (* x_interface_info = "xilinx.com:interface:ddrx:1.0 ddr3 ODT" *) output [0:0]ddr3_odt;
  (* x_interface_info = "xilinx.com:interface:ddrx:1.0 ddr3 RAS_N" *) output ddr3_ras_n;
  (* x_interface_info = "xilinx.com:interface:ddrx:1.0 ddr3 RESET_N" *) output ddr3_reset_n;
  (* x_interface_info = "xilinx.com:interface:ddrx:1.0 ddr3 WE_N" *) output ddr3_we_n;
  output [0:0]init_calib_complete;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 CLK.SYS_CLK_I CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME CLK.SYS_CLK_I, CLK_DOMAIN memory_sys_clk_i, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input sys_clk_i;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 RST.SYS_RST RST" *) (* x_interface_parameter = "XIL_INTERFACENAME RST.SYS_RST, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input sys_rst;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 CLK.UI_CLK CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME CLK.UI_CLK, ASSOCIATED_BUSIF S_AXI, CLK_DOMAIN memory_mig_7series_0_2_ui_clk, FREQ_HZ 83333333, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0" *) output ui_clk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 RST.UI_CLK_SYNC_RST RST" *) (* x_interface_parameter = "XIL_INTERFACENAME RST.UI_CLK_SYNC_RST, INSERT_VIP 0, POLARITY ACTIVE_HIGH" *) output ui_clk_sync_rst;

  wire [31:0]S0_AXI_GEN_0_1_ARADDR;
  wire [1:0]S0_AXI_GEN_0_1_ARBURST;
  wire [3:0]S0_AXI_GEN_0_1_ARCACHE;
  wire [0:0]S0_AXI_GEN_0_1_ARID;
  wire [7:0]S0_AXI_GEN_0_1_ARLEN;
  wire S0_AXI_GEN_0_1_ARLOCK;
  wire [2:0]S0_AXI_GEN_0_1_ARPROT;
  wire [3:0]S0_AXI_GEN_0_1_ARQOS;
  wire S0_AXI_GEN_0_1_ARREADY;
  wire [2:0]S0_AXI_GEN_0_1_ARSIZE;
  wire [31:0]S0_AXI_GEN_0_1_ARUSER;
  wire S0_AXI_GEN_0_1_ARVALID;
  wire [31:0]S0_AXI_GEN_0_1_AWADDR;
  wire [1:0]S0_AXI_GEN_0_1_AWBURST;
  wire [3:0]S0_AXI_GEN_0_1_AWCACHE;
  wire [0:0]S0_AXI_GEN_0_1_AWID;
  wire [7:0]S0_AXI_GEN_0_1_AWLEN;
  wire S0_AXI_GEN_0_1_AWLOCK;
  wire [2:0]S0_AXI_GEN_0_1_AWPROT;
  wire [3:0]S0_AXI_GEN_0_1_AWQOS;
  wire S0_AXI_GEN_0_1_AWREADY;
  wire [2:0]S0_AXI_GEN_0_1_AWSIZE;
  wire [31:0]S0_AXI_GEN_0_1_AWUSER;
  wire S0_AXI_GEN_0_1_AWVALID;
  wire [0:0]S0_AXI_GEN_0_1_BID;
  wire S0_AXI_GEN_0_1_BREADY;
  wire [1:0]S0_AXI_GEN_0_1_BRESP;
  wire S0_AXI_GEN_0_1_BVALID;
  wire [31:0]S0_AXI_GEN_0_1_RDATA;
  wire [0:0]S0_AXI_GEN_0_1_RID;
  wire S0_AXI_GEN_0_1_RLAST;
  wire S0_AXI_GEN_0_1_RREADY;
  wire [1:0]S0_AXI_GEN_0_1_RRESP;
  wire S0_AXI_GEN_0_1_RVALID;
  wire [31:0]S0_AXI_GEN_0_1_WDATA;
  wire S0_AXI_GEN_0_1_WLAST;
  wire S0_AXI_GEN_0_1_WREADY;
  wire [3:0]S0_AXI_GEN_0_1_WSTRB;
  wire S0_AXI_GEN_0_1_WVALID;
  wire clk_ref_i_1;
  wire [13:0]mig_7series_0_DDR3_ADDR;
  wire [2:0]mig_7series_0_DDR3_BA;
  wire mig_7series_0_DDR3_CAS_N;
  wire [0:0]mig_7series_0_DDR3_CKE;
  wire [0:0]mig_7series_0_DDR3_CK_N;
  wire [0:0]mig_7series_0_DDR3_CK_P;
  wire [0:0]mig_7series_0_DDR3_CS_N;
  wire [1:0]mig_7series_0_DDR3_DM;
  wire [15:0]mig_7series_0_DDR3_DQ;
  wire [1:0]mig_7series_0_DDR3_DQS_N;
  wire [1:0]mig_7series_0_DDR3_DQS_P;
  wire [0:0]mig_7series_0_DDR3_ODT;
  wire mig_7series_0_DDR3_RAS_N;
  wire mig_7series_0_DDR3_RESET_N;
  wire mig_7series_0_DDR3_WE_N;
  wire mig_7series_0_init_calib_complete;
  wire mig_7series_0_mmcm_locked;
  wire mig_7series_0_ui_clk;
  wire mig_7series_0_ui_clk_sync_rst;
  wire [0:0]proc_sys_reset_0_peripheral_aresetn;
  wire sys_clk_i_1;
  wire sys_rst_0_1;
  wire system_cache_0_Initializing;
  wire [31:0]system_cache_0_M0_AXI_ARADDR;
  wire [1:0]system_cache_0_M0_AXI_ARBURST;
  wire [3:0]system_cache_0_M0_AXI_ARCACHE;
  wire [0:0]system_cache_0_M0_AXI_ARID;
  wire [7:0]system_cache_0_M0_AXI_ARLEN;
  wire system_cache_0_M0_AXI_ARLOCK;
  wire [2:0]system_cache_0_M0_AXI_ARPROT;
  wire [3:0]system_cache_0_M0_AXI_ARQOS;
  wire system_cache_0_M0_AXI_ARREADY;
  wire [2:0]system_cache_0_M0_AXI_ARSIZE;
  wire system_cache_0_M0_AXI_ARVALID;
  wire [31:0]system_cache_0_M0_AXI_AWADDR;
  wire [1:0]system_cache_0_M0_AXI_AWBURST;
  wire [3:0]system_cache_0_M0_AXI_AWCACHE;
  wire [0:0]system_cache_0_M0_AXI_AWID;
  wire [7:0]system_cache_0_M0_AXI_AWLEN;
  wire system_cache_0_M0_AXI_AWLOCK;
  wire [2:0]system_cache_0_M0_AXI_AWPROT;
  wire [3:0]system_cache_0_M0_AXI_AWQOS;
  wire system_cache_0_M0_AXI_AWREADY;
  wire [2:0]system_cache_0_M0_AXI_AWSIZE;
  wire system_cache_0_M0_AXI_AWVALID;
  wire [0:0]system_cache_0_M0_AXI_BID;
  wire system_cache_0_M0_AXI_BREADY;
  wire [1:0]system_cache_0_M0_AXI_BRESP;
  wire system_cache_0_M0_AXI_BVALID;
  wire [31:0]system_cache_0_M0_AXI_RDATA;
  wire [0:0]system_cache_0_M0_AXI_RID;
  wire system_cache_0_M0_AXI_RLAST;
  wire system_cache_0_M0_AXI_RREADY;
  wire [1:0]system_cache_0_M0_AXI_RRESP;
  wire system_cache_0_M0_AXI_RVALID;
  wire [31:0]system_cache_0_M0_AXI_WDATA;
  wire system_cache_0_M0_AXI_WLAST;
  wire system_cache_0_M0_AXI_WREADY;
  wire [3:0]system_cache_0_M0_AXI_WSTRB;
  wire system_cache_0_M0_AXI_WVALID;
  wire [0:0]util_vector_logic_0_Res;
  wire [0:0]util_vector_logic_1_Res;

  assign S0_AXI_GEN_0_1_ARADDR = S_AXI_araddr[31:0];
  assign S0_AXI_GEN_0_1_ARBURST = S_AXI_arburst[1:0];
  assign S0_AXI_GEN_0_1_ARCACHE = S_AXI_arcache[3:0];
  assign S0_AXI_GEN_0_1_ARID = S_AXI_arid[0];
  assign S0_AXI_GEN_0_1_ARLEN = S_AXI_arlen[7:0];
  assign S0_AXI_GEN_0_1_ARLOCK = S_AXI_arlock;
  assign S0_AXI_GEN_0_1_ARPROT = S_AXI_arprot[2:0];
  assign S0_AXI_GEN_0_1_ARQOS = S_AXI_arqos[3:0];
  assign S0_AXI_GEN_0_1_ARSIZE = S_AXI_arsize[2:0];
  assign S0_AXI_GEN_0_1_ARUSER = S_AXI_aruser[31:0];
  assign S0_AXI_GEN_0_1_ARVALID = S_AXI_arvalid;
  assign S0_AXI_GEN_0_1_AWADDR = S_AXI_awaddr[31:0];
  assign S0_AXI_GEN_0_1_AWBURST = S_AXI_awburst[1:0];
  assign S0_AXI_GEN_0_1_AWCACHE = S_AXI_awcache[3:0];
  assign S0_AXI_GEN_0_1_AWID = S_AXI_awid[0];
  assign S0_AXI_GEN_0_1_AWLEN = S_AXI_awlen[7:0];
  assign S0_AXI_GEN_0_1_AWLOCK = S_AXI_awlock;
  assign S0_AXI_GEN_0_1_AWPROT = S_AXI_awprot[2:0];
  assign S0_AXI_GEN_0_1_AWQOS = S_AXI_awqos[3:0];
  assign S0_AXI_GEN_0_1_AWSIZE = S_AXI_awsize[2:0];
  assign S0_AXI_GEN_0_1_AWUSER = S_AXI_awuser[31:0];
  assign S0_AXI_GEN_0_1_AWVALID = S_AXI_awvalid;
  assign S0_AXI_GEN_0_1_BREADY = S_AXI_bready;
  assign S0_AXI_GEN_0_1_RREADY = S_AXI_rready;
  assign S0_AXI_GEN_0_1_WDATA = S_AXI_wdata[31:0];
  assign S0_AXI_GEN_0_1_WLAST = S_AXI_wlast;
  assign S0_AXI_GEN_0_1_WSTRB = S_AXI_wstrb[3:0];
  assign S0_AXI_GEN_0_1_WVALID = S_AXI_wvalid;
  assign S_AXI_arready = S0_AXI_GEN_0_1_ARREADY;
  assign S_AXI_awready = S0_AXI_GEN_0_1_AWREADY;
  assign S_AXI_bid[0] = S0_AXI_GEN_0_1_BID;
  assign S_AXI_bresp[1:0] = S0_AXI_GEN_0_1_BRESP;
  assign S_AXI_bvalid = S0_AXI_GEN_0_1_BVALID;
  assign S_AXI_rdata[31:0] = S0_AXI_GEN_0_1_RDATA;
  assign S_AXI_rid[0] = S0_AXI_GEN_0_1_RID;
  assign S_AXI_rlast = S0_AXI_GEN_0_1_RLAST;
  assign S_AXI_rresp[1:0] = S0_AXI_GEN_0_1_RRESP;
  assign S_AXI_rvalid = S0_AXI_GEN_0_1_RVALID;
  assign S_AXI_wready = S0_AXI_GEN_0_1_WREADY;
  assign clk_ref_i_1 = clk_ref_i;
  assign ddr3_addr[13:0] = mig_7series_0_DDR3_ADDR;
  assign ddr3_ba[2:0] = mig_7series_0_DDR3_BA;
  assign ddr3_cas_n = mig_7series_0_DDR3_CAS_N;
  assign ddr3_ck_n[0] = mig_7series_0_DDR3_CK_N;
  assign ddr3_ck_p[0] = mig_7series_0_DDR3_CK_P;
  assign ddr3_cke[0] = mig_7series_0_DDR3_CKE;
  assign ddr3_cs_n[0] = mig_7series_0_DDR3_CS_N;
  assign ddr3_dm[1:0] = mig_7series_0_DDR3_DM;
  assign ddr3_odt[0] = mig_7series_0_DDR3_ODT;
  assign ddr3_ras_n = mig_7series_0_DDR3_RAS_N;
  assign ddr3_reset_n = mig_7series_0_DDR3_RESET_N;
  assign ddr3_we_n = mig_7series_0_DDR3_WE_N;
  assign init_calib_complete[0] = util_vector_logic_0_Res;
  assign sys_clk_i_1 = sys_clk_i;
  assign sys_rst_0_1 = sys_rst;
  assign ui_clk = mig_7series_0_ui_clk;
  assign ui_clk_sync_rst = mig_7series_0_ui_clk_sync_rst;
  memory_mig_7series_0_2 mig_7series_0
       (.aresetn(proc_sys_reset_0_peripheral_aresetn),
        .clk_ref_i(clk_ref_i_1),
        .ddr3_addr(mig_7series_0_DDR3_ADDR),
        .ddr3_ba(mig_7series_0_DDR3_BA),
        .ddr3_cas_n(mig_7series_0_DDR3_CAS_N),
        .ddr3_ck_n(mig_7series_0_DDR3_CK_N),
        .ddr3_ck_p(mig_7series_0_DDR3_CK_P),
        .ddr3_cke(mig_7series_0_DDR3_CKE),
        .ddr3_cs_n(mig_7series_0_DDR3_CS_N),
        .ddr3_dm(mig_7series_0_DDR3_DM),
        .ddr3_dq(ddr3_dq[15:0]),
        .ddr3_dqs_n(ddr3_dqs_n[1:0]),
        .ddr3_dqs_p(ddr3_dqs_p[1:0]),
        .ddr3_odt(mig_7series_0_DDR3_ODT),
        .ddr3_ras_n(mig_7series_0_DDR3_RAS_N),
        .ddr3_reset_n(mig_7series_0_DDR3_RESET_N),
        .ddr3_we_n(mig_7series_0_DDR3_WE_N),
        .init_calib_complete(mig_7series_0_init_calib_complete),
        .mmcm_locked(mig_7series_0_mmcm_locked),
        .s_axi_araddr(system_cache_0_M0_AXI_ARADDR[27:0]),
        .s_axi_arburst(system_cache_0_M0_AXI_ARBURST),
        .s_axi_arcache(system_cache_0_M0_AXI_ARCACHE),
        .s_axi_arid(system_cache_0_M0_AXI_ARID),
        .s_axi_arlen(system_cache_0_M0_AXI_ARLEN),
        .s_axi_arlock(system_cache_0_M0_AXI_ARLOCK),
        .s_axi_arprot(system_cache_0_M0_AXI_ARPROT),
        .s_axi_arqos(system_cache_0_M0_AXI_ARQOS),
        .s_axi_arready(system_cache_0_M0_AXI_ARREADY),
        .s_axi_arsize(system_cache_0_M0_AXI_ARSIZE),
        .s_axi_arvalid(system_cache_0_M0_AXI_ARVALID),
        .s_axi_awaddr(system_cache_0_M0_AXI_AWADDR[27:0]),
        .s_axi_awburst(system_cache_0_M0_AXI_AWBURST),
        .s_axi_awcache(system_cache_0_M0_AXI_AWCACHE),
        .s_axi_awid(system_cache_0_M0_AXI_AWID),
        .s_axi_awlen(system_cache_0_M0_AXI_AWLEN),
        .s_axi_awlock(system_cache_0_M0_AXI_AWLOCK),
        .s_axi_awprot(system_cache_0_M0_AXI_AWPROT),
        .s_axi_awqos(system_cache_0_M0_AXI_AWQOS),
        .s_axi_awready(system_cache_0_M0_AXI_AWREADY),
        .s_axi_awsize(system_cache_0_M0_AXI_AWSIZE),
        .s_axi_awvalid(system_cache_0_M0_AXI_AWVALID),
        .s_axi_bid(system_cache_0_M0_AXI_BID),
        .s_axi_bready(system_cache_0_M0_AXI_BREADY),
        .s_axi_bresp(system_cache_0_M0_AXI_BRESP),
        .s_axi_bvalid(system_cache_0_M0_AXI_BVALID),
        .s_axi_rdata(system_cache_0_M0_AXI_RDATA),
        .s_axi_rid(system_cache_0_M0_AXI_RID),
        .s_axi_rlast(system_cache_0_M0_AXI_RLAST),
        .s_axi_rready(system_cache_0_M0_AXI_RREADY),
        .s_axi_rresp(system_cache_0_M0_AXI_RRESP),
        .s_axi_rvalid(system_cache_0_M0_AXI_RVALID),
        .s_axi_wdata(system_cache_0_M0_AXI_WDATA),
        .s_axi_wlast(system_cache_0_M0_AXI_WLAST),
        .s_axi_wready(system_cache_0_M0_AXI_WREADY),
        .s_axi_wstrb(system_cache_0_M0_AXI_WSTRB),
        .s_axi_wvalid(system_cache_0_M0_AXI_WVALID),
        .sys_clk_i(sys_clk_i_1),
        .sys_rst(sys_rst_0_1),
        .ui_clk(mig_7series_0_ui_clk),
        .ui_clk_sync_rst(mig_7series_0_ui_clk_sync_rst));
  memory_proc_sys_reset_0_0 proc_sys_reset_0
       (.aux_reset_in(1'b1),
        .dcm_locked(mig_7series_0_mmcm_locked),
        .ext_reset_in(sys_rst_0_1),
        .mb_debug_sys_rst(1'b0),
        .peripheral_aresetn(proc_sys_reset_0_peripheral_aresetn),
        .slowest_sync_clk(mig_7series_0_ui_clk));
  memory_system_cache_0_0 system_cache_0
       (.ACLK(mig_7series_0_ui_clk),
        .ARESETN(proc_sys_reset_0_peripheral_aresetn),
        .Initializing(system_cache_0_Initializing),
        .M0_AXI_ARADDR(system_cache_0_M0_AXI_ARADDR),
        .M0_AXI_ARBURST(system_cache_0_M0_AXI_ARBURST),
        .M0_AXI_ARCACHE(system_cache_0_M0_AXI_ARCACHE),
        .M0_AXI_ARID(system_cache_0_M0_AXI_ARID),
        .M0_AXI_ARLEN(system_cache_0_M0_AXI_ARLEN),
        .M0_AXI_ARLOCK(system_cache_0_M0_AXI_ARLOCK),
        .M0_AXI_ARPROT(system_cache_0_M0_AXI_ARPROT),
        .M0_AXI_ARQOS(system_cache_0_M0_AXI_ARQOS),
        .M0_AXI_ARREADY(system_cache_0_M0_AXI_ARREADY),
        .M0_AXI_ARSIZE(system_cache_0_M0_AXI_ARSIZE),
        .M0_AXI_ARVALID(system_cache_0_M0_AXI_ARVALID),
        .M0_AXI_AWADDR(system_cache_0_M0_AXI_AWADDR),
        .M0_AXI_AWBURST(system_cache_0_M0_AXI_AWBURST),
        .M0_AXI_AWCACHE(system_cache_0_M0_AXI_AWCACHE),
        .M0_AXI_AWID(system_cache_0_M0_AXI_AWID),
        .M0_AXI_AWLEN(system_cache_0_M0_AXI_AWLEN),
        .M0_AXI_AWLOCK(system_cache_0_M0_AXI_AWLOCK),
        .M0_AXI_AWPROT(system_cache_0_M0_AXI_AWPROT),
        .M0_AXI_AWQOS(system_cache_0_M0_AXI_AWQOS),
        .M0_AXI_AWREADY(system_cache_0_M0_AXI_AWREADY),
        .M0_AXI_AWSIZE(system_cache_0_M0_AXI_AWSIZE),
        .M0_AXI_AWVALID(system_cache_0_M0_AXI_AWVALID),
        .M0_AXI_BID(system_cache_0_M0_AXI_BID),
        .M0_AXI_BREADY(system_cache_0_M0_AXI_BREADY),
        .M0_AXI_BRESP(system_cache_0_M0_AXI_BRESP),
        .M0_AXI_BVALID(system_cache_0_M0_AXI_BVALID),
        .M0_AXI_RDATA(system_cache_0_M0_AXI_RDATA),
        .M0_AXI_RID(system_cache_0_M0_AXI_RID),
        .M0_AXI_RLAST(system_cache_0_M0_AXI_RLAST),
        .M0_AXI_RREADY(system_cache_0_M0_AXI_RREADY),
        .M0_AXI_RRESP(system_cache_0_M0_AXI_RRESP),
        .M0_AXI_RVALID(system_cache_0_M0_AXI_RVALID),
        .M0_AXI_WDATA(system_cache_0_M0_AXI_WDATA),
        .M0_AXI_WLAST(system_cache_0_M0_AXI_WLAST),
        .M0_AXI_WREADY(system_cache_0_M0_AXI_WREADY),
        .M0_AXI_WSTRB(system_cache_0_M0_AXI_WSTRB),
        .M0_AXI_WVALID(system_cache_0_M0_AXI_WVALID),
        .S0_AXI_GEN_ARADDR(S0_AXI_GEN_0_1_ARADDR),
        .S0_AXI_GEN_ARBURST(S0_AXI_GEN_0_1_ARBURST),
        .S0_AXI_GEN_ARCACHE(S0_AXI_GEN_0_1_ARCACHE),
        .S0_AXI_GEN_ARID(S0_AXI_GEN_0_1_ARID),
        .S0_AXI_GEN_ARLEN(S0_AXI_GEN_0_1_ARLEN),
        .S0_AXI_GEN_ARLOCK(S0_AXI_GEN_0_1_ARLOCK),
        .S0_AXI_GEN_ARPROT(S0_AXI_GEN_0_1_ARPROT),
        .S0_AXI_GEN_ARQOS(S0_AXI_GEN_0_1_ARQOS),
        .S0_AXI_GEN_ARREADY(S0_AXI_GEN_0_1_ARREADY),
        .S0_AXI_GEN_ARSIZE(S0_AXI_GEN_0_1_ARSIZE),
        .S0_AXI_GEN_ARUSER(S0_AXI_GEN_0_1_ARUSER),
        .S0_AXI_GEN_ARVALID(S0_AXI_GEN_0_1_ARVALID),
        .S0_AXI_GEN_AWADDR(S0_AXI_GEN_0_1_AWADDR),
        .S0_AXI_GEN_AWBURST(S0_AXI_GEN_0_1_AWBURST),
        .S0_AXI_GEN_AWCACHE(S0_AXI_GEN_0_1_AWCACHE),
        .S0_AXI_GEN_AWID(S0_AXI_GEN_0_1_AWID),
        .S0_AXI_GEN_AWLEN(S0_AXI_GEN_0_1_AWLEN),
        .S0_AXI_GEN_AWLOCK(S0_AXI_GEN_0_1_AWLOCK),
        .S0_AXI_GEN_AWPROT(S0_AXI_GEN_0_1_AWPROT),
        .S0_AXI_GEN_AWQOS(S0_AXI_GEN_0_1_AWQOS),
        .S0_AXI_GEN_AWREADY(S0_AXI_GEN_0_1_AWREADY),
        .S0_AXI_GEN_AWSIZE(S0_AXI_GEN_0_1_AWSIZE),
        .S0_AXI_GEN_AWUSER(S0_AXI_GEN_0_1_AWUSER),
        .S0_AXI_GEN_AWVALID(S0_AXI_GEN_0_1_AWVALID),
        .S0_AXI_GEN_BID(S0_AXI_GEN_0_1_BID),
        .S0_AXI_GEN_BREADY(S0_AXI_GEN_0_1_BREADY),
        .S0_AXI_GEN_BRESP(S0_AXI_GEN_0_1_BRESP),
        .S0_AXI_GEN_BVALID(S0_AXI_GEN_0_1_BVALID),
        .S0_AXI_GEN_RDATA(S0_AXI_GEN_0_1_RDATA),
        .S0_AXI_GEN_RID(S0_AXI_GEN_0_1_RID),
        .S0_AXI_GEN_RLAST(S0_AXI_GEN_0_1_RLAST),
        .S0_AXI_GEN_RREADY(S0_AXI_GEN_0_1_RREADY),
        .S0_AXI_GEN_RRESP(S0_AXI_GEN_0_1_RRESP),
        .S0_AXI_GEN_RVALID(S0_AXI_GEN_0_1_RVALID),
        .S0_AXI_GEN_WDATA(S0_AXI_GEN_0_1_WDATA),
        .S0_AXI_GEN_WLAST(S0_AXI_GEN_0_1_WLAST),
        .S0_AXI_GEN_WREADY(S0_AXI_GEN_0_1_WREADY),
        .S0_AXI_GEN_WSTRB(S0_AXI_GEN_0_1_WSTRB),
        .S0_AXI_GEN_WVALID(S0_AXI_GEN_0_1_WVALID));
  memory_util_vector_logic_0_0 util_vector_logic_0
       (.Op1(util_vector_logic_1_Res),
        .Op2(mig_7series_0_init_calib_complete),
        .Res(util_vector_logic_0_Res));
  memory_util_vector_logic_1_0 util_vector_logic_1
       (.Op1(system_cache_0_Initializing),
        .Res(util_vector_logic_1_Res));
endmodule
