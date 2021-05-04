// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Tue May  4 10:56:05 2021
// Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/code/zed-68k/zed68k.srcs/sources_1/bd/ethernetlite/ip/ethernetlite_axi_ethernet_0_0/ethernetlite_axi_ethernet_0_0_sim_netlist.v
// Design      : ethernetlite_axi_ethernet_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "ethernetlite_axi_ethernet_0_0,axi_ethernet,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "axi_ethernet,Vivado 2020.1" *) 
(* NotValidForBitStream *)
module ethernetlite_axi_ethernet_0_0
   (address,
    wr_data,
    wr_byte_mask,
    i_cen,
    i_wren,
    i_valid_p,
    rd_data,
    o_ready_p,
    wr_ack_p,
    o_valid_p,
    sys_resetn,
    sys_clock,
    ui_clk,
    ui_clk_sync_rst,
    s_axi_awaddr,
    s_axi_awlen,
    s_axi_awsize,
    s_axi_awburst,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wlast,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bready,
    s_axi_bid,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_araddr,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rready,
    s_axi_rid,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rlast,
    s_axi_rvalid,
    init_calib_complete);
  input [31:0]address;
  input [31:0]wr_data;
  input [3:0]wr_byte_mask;
  input i_cen;
  input i_wren;
  input i_valid_p;
  output [31:0]rd_data;
  output o_ready_p;
  output wr_ack_p;
  output o_valid_p;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 sys_resetn RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME sys_resetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input sys_resetn;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 sys_clock CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME sys_clock, ASSOCIATED_RESET sys_resetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN ethernetlite_sys_clock_0, INSERT_VIP 0" *) input sys_clock;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ui_clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ui_clk, ASSOCIATED_RESET ui_clk_sync_rst, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN ethernetlite_sys_clock_0, INSERT_VIP 0" *) input ui_clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ui_clk_sync_rst RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ui_clk_sync_rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input ui_clk_sync_rst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWADDR" *) output [31:0]s_axi_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWLEN" *) output [7:0]s_axi_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWSIZE" *) output [2:0]s_axi_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWBURST" *) output [1:0]s_axi_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWVALID" *) output s_axi_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWREADY" *) input s_axi_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WDATA" *) output [31:0]s_axi_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WSTRB" *) output [3:0]s_axi_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WLAST" *) output s_axi_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WVALID" *) output s_axi_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WREADY" *) input s_axi_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BREADY" *) output s_axi_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BID" *) input [3:0]s_axi_bid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BRESP" *) input [1:0]s_axi_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BVALID" *) input s_axi_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARADDR" *) output [31:0]s_axi_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARLEN" *) output [7:0]s_axi_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARSIZE" *) output [2:0]s_axi_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARBURST" *) output [1:0]s_axi_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARVALID" *) output s_axi_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARREADY" *) input s_axi_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RREADY" *) output s_axi_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RID" *) input [3:0]s_axi_rid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) input [31:0]s_axi_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RRESP" *) input [1:0]s_axi_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RLAST" *) input s_axi_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RVALID" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 100000000, ID_WIDTH 4, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.000, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input s_axi_rvalid;
  input init_calib_complete;

  wire \<const0> ;
  wire \<const1> ;
  wire [31:0]address;
  wire i_cen;
  wire i_valid_p;
  wire i_wren;
  wire init_calib_complete;
  wire o_ready_p;
  wire o_valid_p;
  wire [31:0]rd_data;
  wire [31:0]s_axi_araddr;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire [31:0]s_axi_awaddr;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire [1:0]s_axi_bresp;
  wire s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire s_axi_rready;
  wire [1:0]s_axi_rresp;
  wire s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire s_axi_wlast;
  wire s_axi_wready;
  wire [3:0]s_axi_wstrb;
  wire s_axi_wvalid;
  wire sys_clock;
  wire ui_clk;
  wire ui_clk_sync_rst;
  wire wr_ack_p;
  wire [3:0]wr_byte_mask;
  wire [31:0]wr_data;

  assign s_axi_arburst[1] = \<const0> ;
  assign s_axi_arburst[0] = \<const0> ;
  assign s_axi_arlen[7] = \<const0> ;
  assign s_axi_arlen[6] = \<const0> ;
  assign s_axi_arlen[5] = \<const0> ;
  assign s_axi_arlen[4] = \<const0> ;
  assign s_axi_arlen[3] = \<const0> ;
  assign s_axi_arlen[2] = \<const0> ;
  assign s_axi_arlen[1] = \<const0> ;
  assign s_axi_arlen[0] = \<const0> ;
  assign s_axi_arsize[2] = \<const0> ;
  assign s_axi_arsize[1] = \<const0> ;
  assign s_axi_arsize[0] = \<const1> ;
  assign s_axi_awburst[1] = \<const0> ;
  assign s_axi_awburst[0] = \<const0> ;
  assign s_axi_awlen[7] = \<const0> ;
  assign s_axi_awlen[6] = \<const0> ;
  assign s_axi_awlen[5] = \<const0> ;
  assign s_axi_awlen[4] = \<const0> ;
  assign s_axi_awlen[3] = \<const0> ;
  assign s_axi_awlen[2] = \<const0> ;
  assign s_axi_awlen[1] = \<const0> ;
  assign s_axi_awlen[0] = \<const0> ;
  assign s_axi_awsize[2] = \<const0> ;
  assign s_axi_awsize[1] = \<const1> ;
  assign s_axi_awsize[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  ethernetlite_axi_ethernet_0_0_axi_ethernet inst
       (.address(address),
        .i_cen(i_cen),
        .i_valid_p(i_valid_p),
        .i_wren(i_wren),
        .init_calib_complete(init_calib_complete),
        .o_ready_p(o_ready_p),
        .o_valid_p(o_valid_p),
        .rd_data(rd_data),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_arready(s_axi_arready),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awready(s_axi_awready),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bresp(s_axi_bresp),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rready(s_axi_rready),
        .s_axi_rresp(s_axi_rresp),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wlast(s_axi_wlast),
        .s_axi_wready(s_axi_wready),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wvalid(s_axi_wvalid),
        .sys_clock(sys_clock),
        .ui_clk(ui_clk),
        .ui_clk_sync_rst(ui_clk_sync_rst),
        .wr_ack_p(wr_ack_p),
        .wr_byte_mask(wr_byte_mask),
        .wr_data(wr_data));
endmodule

(* ORIG_REF_NAME = "Signal_CrossDomain" *) 
module ethernetlite_axi_ethernet_0_0_Signal_CrossDomain
   (o_ready_p,
    o_ready,
    sys_clock);
  output o_ready_p;
  input o_ready;
  input sys_clock;

  wire \SyncA_clkB_reg_n_0_[0] ;
  wire o_ready;
  wire o_ready_p;
  wire sys_clock;

  FDRE \SyncA_clkB_reg[0] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(o_ready),
        .Q(\SyncA_clkB_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \SyncA_clkB_reg[1] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\SyncA_clkB_reg_n_0_[0] ),
        .Q(o_ready_p),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "Signal_CrossDomain" *) 
module ethernetlite_axi_ethernet_0_0_Signal_CrossDomain_0
   (o_valid_p,
    o_valid,
    sys_clock);
  output o_valid_p;
  input o_valid;
  input sys_clock;

  wire \SyncA_clkB_reg_n_0_[0] ;
  wire o_valid;
  wire o_valid_p;
  wire sys_clock;

  FDRE \SyncA_clkB_reg[0] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(o_valid),
        .Q(\SyncA_clkB_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \SyncA_clkB_reg[1] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\SyncA_clkB_reg_n_0_[0] ),
        .Q(o_valid_p),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "Signal_CrossDomain" *) 
module ethernetlite_axi_ethernet_0_0_Signal_CrossDomain_1
   (E,
    i_cen_0,
    D,
    \state_reg[6] ,
    i_valid_p,
    ui_clk,
    i_cen,
    i_wren,
    \s_axi_araddr_reg[0] ,
    Q,
    s_axi_rvalid,
    \state_reg[1] ,
    \state_reg[1]_0 ,
    \state_reg[1]_1 ,
    s_axi_awready,
    \state_reg[5] ,
    \state_reg[1]_2 ,
    \state_reg[1]_3 ,
    \state_reg[2] ,
    \state_reg[0] ,
    \state_reg[0]_0 ,
    \state_reg[0]_1 ,
    s_axi_wready,
    \state_reg[0]_2 ,
    s_axi_bvalid,
    \state_reg[3] ,
    \state_reg[4] ,
    \state_reg[7] ,
    \state_reg[5]_0 ,
    \state_reg[5]_1 ,
    \state_reg[5]_2 ,
    \state_reg[5]_3 ,
    \state_reg[5]_4 ,
    \state_reg[6]_0 ,
    \state_reg[6]_1 ,
    out,
    o_ready_reg,
    o_ready);
  output [0:0]E;
  output [0:0]i_cen_0;
  output [7:0]D;
  output \state_reg[6] ;
  input i_valid_p;
  input ui_clk;
  input i_cen;
  input i_wren;
  input \s_axi_araddr_reg[0] ;
  input [7:0]Q;
  input s_axi_rvalid;
  input \state_reg[1] ;
  input \state_reg[1]_0 ;
  input \state_reg[1]_1 ;
  input s_axi_awready;
  input \state_reg[5] ;
  input \state_reg[1]_2 ;
  input \state_reg[1]_3 ;
  input \state_reg[2] ;
  input \state_reg[0] ;
  input \state_reg[0]_0 ;
  input \state_reg[0]_1 ;
  input s_axi_wready;
  input \state_reg[0]_2 ;
  input s_axi_bvalid;
  input \state_reg[3] ;
  input \state_reg[4] ;
  input \state_reg[7] ;
  input \state_reg[5]_0 ;
  input \state_reg[5]_1 ;
  input \state_reg[5]_2 ;
  input \state_reg[5]_3 ;
  input \state_reg[5]_4 ;
  input \state_reg[6]_0 ;
  input \state_reg[6]_1 ;
  input [0:0]out;
  input o_ready_reg;
  input o_ready;

  wire [7:0]D;
  wire [0:0]E;
  wire [7:0]Q;
  wire SyncA_clkB;
  wire i_cen;
  wire [0:0]i_cen_0;
  wire i_valid;
  wire i_valid_p;
  wire i_wren;
  wire o_ready;
  wire o_ready_reg;
  wire [0:0]out;
  wire \s_axi_araddr_reg[0] ;
  wire s_axi_awready;
  wire s_axi_bvalid;
  wire s_axi_rvalid;
  wire s_axi_wready;
  wire \state[0]_i_4_n_0 ;
  wire \state[1]_i_2_n_0 ;
  wire \state[1]_i_5_n_0 ;
  wire \state[2]_i_2_n_0 ;
  wire \state[5]_i_4_n_0 ;
  wire \state[5]_i_5_n_0 ;
  wire \state[6]_i_10_n_0 ;
  wire \state[6]_i_5_n_0 ;
  wire \state[7]_i_4_n_0 ;
  wire \state[7]_i_9_n_0 ;
  wire \state_reg[0] ;
  wire \state_reg[0]_0 ;
  wire \state_reg[0]_1 ;
  wire \state_reg[0]_2 ;
  wire \state_reg[1] ;
  wire \state_reg[1]_0 ;
  wire \state_reg[1]_1 ;
  wire \state_reg[1]_2 ;
  wire \state_reg[1]_3 ;
  wire \state_reg[2] ;
  wire \state_reg[3] ;
  wire \state_reg[4] ;
  wire \state_reg[5] ;
  wire \state_reg[5]_0 ;
  wire \state_reg[5]_1 ;
  wire \state_reg[5]_2 ;
  wire \state_reg[5]_3 ;
  wire \state_reg[5]_4 ;
  wire \state_reg[6] ;
  wire \state_reg[6]_0 ;
  wire \state_reg[6]_1 ;
  wire \state_reg[7] ;
  wire ui_clk;

  FDRE \SyncA_clkB_reg[0] 
       (.C(ui_clk),
        .CE(1'b1),
        .D(i_valid_p),
        .Q(SyncA_clkB),
        .R(1'b0));
  FDRE \SyncA_clkB_reg[1] 
       (.C(ui_clk),
        .CE(1'b1),
        .D(SyncA_clkB),
        .Q(i_valid),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hFBFFFB00)) 
    o_ready_i_1
       (.I0(out),
        .I1(i_valid),
        .I2(i_cen),
        .I3(o_ready_reg),
        .I4(o_ready),
        .O(\state_reg[6] ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h0040)) 
    \s_axi_araddr[31]_i_1 
       (.I0(i_cen),
        .I1(i_valid),
        .I2(i_wren),
        .I3(\s_axi_araddr_reg[0] ),
        .O(E));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h0004)) 
    \s_axi_awaddr[31]_i_1 
       (.I0(i_cen),
        .I1(i_valid),
        .I2(i_wren),
        .I3(\s_axi_araddr_reg[0] ),
        .O(i_cen_0));
  LUT5 #(
    .INIT(32'hFF00F8F8)) 
    \state[0]_i_1 
       (.I0(\state_reg[0] ),
        .I1(\state_reg[0]_0 ),
        .I2(\state[0]_i_4_n_0 ),
        .I3(\state_reg[0]_1 ),
        .I4(\state_reg[1] ),
        .O(D[0]));
  LUT6 #(
    .INIT(64'hCC11CC11003000FC)) 
    \state[0]_i_4 
       (.I0(\state[7]_i_9_n_0 ),
        .I1(Q[0]),
        .I2(s_axi_wready),
        .I3(\state_reg[0]_2 ),
        .I4(s_axi_bvalid),
        .I5(\state_reg[0]_0 ),
        .O(\state[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFCAA00AA0CAA00AA)) 
    \state[1]_i_1 
       (.I0(\state[1]_i_2_n_0 ),
        .I1(Q[1]),
        .I2(s_axi_rvalid),
        .I3(\state_reg[1] ),
        .I4(\state_reg[1]_0 ),
        .I5(\state_reg[1]_1 ),
        .O(D[1]));
  LUT6 #(
    .INIT(64'hEFE0FFFFEFE0F0F0)) 
    \state[1]_i_2 
       (.I0(s_axi_awready),
        .I1(Q[1]),
        .I2(\state_reg[5] ),
        .I3(\state_reg[1]_2 ),
        .I4(\state_reg[1]_3 ),
        .I5(\state[1]_i_5_n_0 ),
        .O(\state[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'hBA8A)) 
    \state[1]_i_5 
       (.I0(Q[1]),
        .I1(i_cen),
        .I2(i_valid),
        .I3(i_wren),
        .O(\state[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000F000FEF4FEF4)) 
    \state[2]_i_2 
       (.I0(\state[7]_i_9_n_0 ),
        .I1(i_wren),
        .I2(\state_reg[1]_3 ),
        .I3(Q[2]),
        .I4(s_axi_awready),
        .I5(\state_reg[5] ),
        .O(\state[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h2000FFFF20002000)) 
    \state[3]_i_1 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(Q[3]),
        .I3(\state[7]_i_4_n_0 ),
        .I4(\state_reg[3] ),
        .I5(\state_reg[1] ),
        .O(D[3]));
  LUT6 #(
    .INIT(64'h08C80808C8C8C8C8)) 
    \state[4]_i_1 
       (.I0(\state[7]_i_4_n_0 ),
        .I1(Q[4]),
        .I2(\state_reg[1] ),
        .I3(s_axi_rvalid),
        .I4(\state_reg[1]_0 ),
        .I5(\state_reg[4] ),
        .O(D[4]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \state[5]_i_1 
       (.I0(\state_reg[5]_0 ),
        .I1(\state_reg[1] ),
        .I2(\state_reg[5]_1 ),
        .I3(\state_reg[5] ),
        .I4(\state[5]_i_4_n_0 ),
        .O(D[5]));
  LUT6 #(
    .INIT(64'hB888FFFFB8880000)) 
    \state[5]_i_4 
       (.I0(\state_reg[5]_2 ),
        .I1(\state_reg[5]_3 ),
        .I2(\state_reg[5]_4 ),
        .I3(Q[5]),
        .I4(\state_reg[1]_3 ),
        .I5(\state[5]_i_5_n_0 ),
        .O(\state[5]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hA2)) 
    \state[5]_i_5 
       (.I0(Q[5]),
        .I1(i_valid),
        .I2(i_cen),
        .O(\state[5]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \state[6]_i_1 
       (.I0(\state_reg[6]_0 ),
        .I1(\state_reg[1] ),
        .I2(\state_reg[6]_1 ),
        .I3(\state_reg[5] ),
        .I4(\state[6]_i_5_n_0 ),
        .O(D[6]));
  LUT3 #(
    .INIT(8'hA2)) 
    \state[6]_i_10 
       (.I0(Q[6]),
        .I1(i_valid),
        .I2(i_cen),
        .O(\state[6]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hB888FFFFB8880000)) 
    \state[6]_i_5 
       (.I0(\state_reg[5]_2 ),
        .I1(\state_reg[5]_3 ),
        .I2(\state_reg[5]_4 ),
        .I3(Q[5]),
        .I4(\state_reg[1]_3 ),
        .I5(\state[6]_i_10_n_0 ),
        .O(\state[6]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h08C80808C8C8C8C8)) 
    \state[7]_i_2 
       (.I0(\state[7]_i_4_n_0 ),
        .I1(Q[7]),
        .I2(\state_reg[1] ),
        .I3(s_axi_rvalid),
        .I4(\state_reg[1]_0 ),
        .I5(\state_reg[4] ),
        .O(D[7]));
  LUT6 #(
    .INIT(64'hC00CCF0CAAAAAAAA)) 
    \state[7]_i_4 
       (.I0(\state_reg[7] ),
        .I1(\state[7]_i_9_n_0 ),
        .I2(Q[0]),
        .I3(\state_reg[0]_2 ),
        .I4(s_axi_awready),
        .I5(\state_reg[0]_0 ),
        .O(\state[7]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \state[7]_i_9 
       (.I0(i_cen),
        .I1(i_valid),
        .O(\state[7]_i_9_n_0 ));
  MUXF7 \state_reg[2]_i_1 
       (.I0(\state[2]_i_2_n_0 ),
        .I1(\state_reg[2] ),
        .O(D[2]),
        .S(\state_reg[1] ));
endmodule

(* ORIG_REF_NAME = "Signal_CrossDomain" *) 
module ethernetlite_axi_ethernet_0_0_Signal_CrossDomain_2
   (wr_ack_p,
    wr_ack,
    sys_clock);
  output wr_ack_p;
  input wr_ack;
  input sys_clock;

  wire \SyncA_clkB_reg_n_0_[0] ;
  wire sys_clock;
  wire wr_ack;
  wire wr_ack_p;

  FDRE \SyncA_clkB_reg[0] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(wr_ack),
        .Q(\SyncA_clkB_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \SyncA_clkB_reg[1] 
       (.C(sys_clock),
        .CE(1'b1),
        .D(\SyncA_clkB_reg_n_0_[0] ),
        .Q(wr_ack_p),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "axi_ethernet" *) 
module ethernetlite_axi_ethernet_0_0_axi_ethernet
   (rd_data,
    s_axi_awaddr,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_araddr,
    wr_ack_p,
    o_ready_p,
    o_valid_p,
    s_axi_awvalid,
    s_axi_wvalid,
    s_axi_bready,
    s_axi_arvalid,
    s_axi_rready,
    s_axi_wlast,
    s_axi_rvalid,
    s_axi_arready,
    ui_clk,
    s_axi_rdata,
    address,
    wr_data,
    wr_byte_mask,
    i_valid_p,
    sys_clock,
    i_cen,
    i_wren,
    ui_clk_sync_rst,
    init_calib_complete,
    s_axi_awready,
    s_axi_wready,
    s_axi_bvalid,
    s_axi_rresp,
    s_axi_bresp);
  output [31:0]rd_data;
  output [31:0]s_axi_awaddr;
  output [31:0]s_axi_wdata;
  output [3:0]s_axi_wstrb;
  output [31:0]s_axi_araddr;
  output wr_ack_p;
  output o_ready_p;
  output o_valid_p;
  output s_axi_awvalid;
  output s_axi_wvalid;
  output s_axi_bready;
  output s_axi_arvalid;
  output s_axi_rready;
  output s_axi_wlast;
  input s_axi_rvalid;
  input s_axi_arready;
  input ui_clk;
  input [31:0]s_axi_rdata;
  input [31:0]address;
  input [31:0]wr_data;
  input [3:0]wr_byte_mask;
  input i_valid_p;
  input sys_clock;
  input i_cen;
  input i_wren;
  input ui_clk_sync_rst;
  input init_calib_complete;
  input s_axi_awready;
  input s_axi_wready;
  input s_axi_bvalid;
  input [1:0]s_axi_rresp;
  input [1:0]s_axi_bresp;

  wire [31:0]address;
  wire i_cen;
  wire i_valid_p;
  wire i_wren;
  wire init_calib_complete;
  wire o_ready;
  wire o_ready_i_2_n_0;
  wire o_ready_p;
  wire o_valid;
  wire o_valid_i_1_n_0;
  wire o_valid_i_2_n_0;
  wire o_valid_p;
  wire [7:0]p_0_in__0;
  wire [31:0]rd_data;
  wire \rd_data[31]_i_2_n_0 ;
  wire \rd_data[31]_i_3_n_0 ;
  wire [31:0]s_axi_araddr;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire s_axi_arvalid_i_1_n_0;
  wire s_axi_arvalid_i_2_n_0;
  wire [31:0]s_axi_awaddr;
  wire \s_axi_awaddr[31]_i_2_n_0 ;
  wire \s_axi_awaddr[31]_i_3_n_0 ;
  wire \s_axi_awaddr[31]_i_4_n_0 ;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire s_axi_awvalid0;
  wire s_axi_awvalid_i_1_n_0;
  wire s_axi_awvalid_i_2_n_0;
  wire s_axi_bready;
  wire s_axi_bready_i_1_n_0;
  wire s_axi_bready_i_2_n_0;
  wire [1:0]s_axi_bresp;
  wire s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire s_axi_rready;
  wire s_axi_rready_i_1_n_0;
  wire s_axi_rready_i_2_n_0;
  wire s_axi_rready_i_3_n_0;
  wire [1:0]s_axi_rresp;
  wire s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire s_axi_wlast;
  wire s_axi_wlast_i_1_n_0;
  wire s_axi_wready;
  wire [3:0]s_axi_wstrb;
  wire s_axi_wvalid;
  wire s_axi_wvalid_i_1_n_0;
  (* DONT_TOUCH *) wire [7:0]state;
  wire \state[0]_i_2_n_0 ;
  wire \state[0]_i_3_n_0 ;
  wire \state[0]_i_5_n_0 ;
  wire \state[1]_i_3_n_0 ;
  wire \state[1]_i_4_n_0 ;
  wire \state[2]_i_3_n_0 ;
  wire \state[3]_i_2_n_0 ;
  wire \state[5]_i_2_n_0 ;
  wire \state[5]_i_3_n_0 ;
  wire \state[6]_i_2_n_0 ;
  wire \state[6]_i_3_n_0 ;
  wire \state[6]_i_4_n_0 ;
  wire \state[6]_i_6_n_0 ;
  wire \state[6]_i_7_n_0 ;
  wire \state[6]_i_8_n_0 ;
  wire \state[6]_i_9_n_0 ;
  wire \state[7]_i_10_n_0 ;
  wire \state[7]_i_1_n_0 ;
  wire \state[7]_i_3_n_0 ;
  wire \state[7]_i_5_n_0 ;
  wire \state[7]_i_6_n_0 ;
  wire \state[7]_i_7_n_0 ;
  wire \state[7]_i_8_n_0 ;
  wire sys_clock;
  wire ui_clk;
  wire ui_clk_sync_rst;
  wire valid_inp_n_0;
  wire valid_inp_n_1;
  wire valid_inp_n_10;
  wire wr_ack;
  wire wr_ack_i_1_n_0;
  wire wr_ack_i_2_n_0;
  wire wr_ack_i_3_n_0;
  wire wr_ack_p;
  wire [3:0]wr_byte_mask;
  wire [31:0]wr_data;

  LUT6 #(
    .INIT(64'h0000000010000001)) 
    o_ready_i_2
       (.I0(state[1]),
        .I1(state[3]),
        .I2(state[2]),
        .I3(state[5]),
        .I4(state[6]),
        .I5(wr_ack_i_3_n_0),
        .O(o_ready_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    o_ready_reg
       (.C(ui_clk),
        .CE(1'b1),
        .D(valid_inp_n_10),
        .Q(o_ready),
        .R(s_axi_awvalid0));
  LUT4 #(
    .INIT(16'h2F20)) 
    o_valid_i_1
       (.I0(state[3]),
        .I1(state[6]),
        .I2(o_valid_i_2_n_0),
        .I3(o_valid),
        .O(o_valid_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000000001000081)) 
    o_valid_i_2
       (.I0(state[6]),
        .I1(state[2]),
        .I2(state[5]),
        .I3(state[1]),
        .I4(state[3]),
        .I5(wr_ack_i_3_n_0),
        .O(o_valid_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    o_valid_reg
       (.C(ui_clk),
        .CE(1'b1),
        .D(o_valid_i_1_n_0),
        .Q(o_valid),
        .R(s_axi_awvalid0));
  ethernetlite_axi_ethernet_0_0_Signal_CrossDomain oready
       (.o_ready(o_ready),
        .o_ready_p(o_ready_p),
        .sys_clock(sys_clock));
  ethernetlite_axi_ethernet_0_0_Signal_CrossDomain_0 ovalid
       (.o_valid(o_valid),
        .o_valid_p(o_valid_p),
        .sys_clock(sys_clock));
  LUT2 #(
    .INIT(4'h2)) 
    \rd_data[31]_i_1 
       (.I0(ui_clk_sync_rst),
        .I1(init_calib_complete),
        .O(s_axi_awvalid0));
  LUT5 #(
    .INIT(32'h00000020)) 
    \rd_data[31]_i_2 
       (.I0(state[3]),
        .I1(state[2]),
        .I2(state[1]),
        .I3(state[0]),
        .I4(\rd_data[31]_i_3_n_0 ),
        .O(\rd_data[31]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \rd_data[31]_i_3 
       (.I0(state[7]),
        .I1(state[6]),
        .I2(state[5]),
        .I3(state[4]),
        .O(\rd_data[31]_i_3_n_0 ));
  FDRE \rd_data_reg[0] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[0]),
        .Q(rd_data[0]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[10] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[10]),
        .Q(rd_data[10]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[11] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[11]),
        .Q(rd_data[11]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[12] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[12]),
        .Q(rd_data[12]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[13] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[13]),
        .Q(rd_data[13]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[14] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[14]),
        .Q(rd_data[14]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[15] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[15]),
        .Q(rd_data[15]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[16] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[16]),
        .Q(rd_data[16]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[17] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[17]),
        .Q(rd_data[17]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[18] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[18]),
        .Q(rd_data[18]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[19] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[19]),
        .Q(rd_data[19]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[1] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[1]),
        .Q(rd_data[1]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[20] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[20]),
        .Q(rd_data[20]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[21] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[21]),
        .Q(rd_data[21]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[22] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[22]),
        .Q(rd_data[22]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[23] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[23]),
        .Q(rd_data[23]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[24] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[24]),
        .Q(rd_data[24]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[25] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[25]),
        .Q(rd_data[25]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[26] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[26]),
        .Q(rd_data[26]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[27] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[27]),
        .Q(rd_data[27]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[28] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[28]),
        .Q(rd_data[28]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[29] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[29]),
        .Q(rd_data[29]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[2] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[2]),
        .Q(rd_data[2]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[30] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[30]),
        .Q(rd_data[30]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[31] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[31]),
        .Q(rd_data[31]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[3] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[3]),
        .Q(rd_data[3]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[4] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[4]),
        .Q(rd_data[4]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[5] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[5]),
        .Q(rd_data[5]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[6] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[6]),
        .Q(rd_data[6]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[7] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[7]),
        .Q(rd_data[7]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[8] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[8]),
        .Q(rd_data[8]),
        .R(s_axi_awvalid0));
  FDRE \rd_data_reg[9] 
       (.C(ui_clk),
        .CE(\rd_data[31]_i_2_n_0 ),
        .D(s_axi_rdata[9]),
        .Q(rd_data[9]),
        .R(s_axi_awvalid0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[0] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[0]),
        .Q(s_axi_araddr[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[10] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[10]),
        .Q(s_axi_araddr[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[11] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[11]),
        .Q(s_axi_araddr[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[12] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[12]),
        .Q(s_axi_araddr[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[13] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[13]),
        .Q(s_axi_araddr[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[14] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[14]),
        .Q(s_axi_araddr[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[15] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[15]),
        .Q(s_axi_araddr[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[16] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[16]),
        .Q(s_axi_araddr[16]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[17] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[17]),
        .Q(s_axi_araddr[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[18] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[18]),
        .Q(s_axi_araddr[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[19] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[19]),
        .Q(s_axi_araddr[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[1] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[1]),
        .Q(s_axi_araddr[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[20] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[20]),
        .Q(s_axi_araddr[20]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[21] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[21]),
        .Q(s_axi_araddr[21]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[22] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[22]),
        .Q(s_axi_araddr[22]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[23] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[23]),
        .Q(s_axi_araddr[23]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[24] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[24]),
        .Q(s_axi_araddr[24]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[25] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[25]),
        .Q(s_axi_araddr[25]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[26] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[26]),
        .Q(s_axi_araddr[26]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[27] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[27]),
        .Q(s_axi_araddr[27]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[28] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[28]),
        .Q(s_axi_araddr[28]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[29] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[29]),
        .Q(s_axi_araddr[29]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[2] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[2]),
        .Q(s_axi_araddr[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[30] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[30]),
        .Q(s_axi_araddr[30]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[31] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[31]),
        .Q(s_axi_araddr[31]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[3] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[3]),
        .Q(s_axi_araddr[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[4] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[4]),
        .Q(s_axi_araddr[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[5] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[5]),
        .Q(s_axi_araddr[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[6] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[6]),
        .Q(s_axi_araddr[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[7] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[7]),
        .Q(s_axi_araddr[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[8] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[8]),
        .Q(s_axi_araddr[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_araddr_reg[9] 
       (.C(ui_clk),
        .CE(valid_inp_n_0),
        .D(address[9]),
        .Q(s_axi_araddr[9]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h74)) 
    s_axi_arvalid_i_1
       (.I0(state[3]),
        .I1(s_axi_arvalid_i_2_n_0),
        .I2(s_axi_arvalid),
        .O(s_axi_arvalid_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000000050000008)) 
    s_axi_arvalid_i_2
       (.I0(state[3]),
        .I1(s_axi_arready),
        .I2(state[2]),
        .I3(state[0]),
        .I4(state[1]),
        .I5(\rd_data[31]_i_3_n_0 ),
        .O(s_axi_arvalid_i_2_n_0));
  FDRE s_axi_arvalid_reg
       (.C(ui_clk),
        .CE(1'b1),
        .D(s_axi_arvalid_i_1_n_0),
        .Q(s_axi_arvalid),
        .R(s_axi_awvalid0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \s_axi_awaddr[31]_i_2 
       (.I0(\s_axi_awaddr[31]_i_3_n_0 ),
        .I1(s_axi_awvalid0),
        .I2(\s_axi_awaddr[31]_i_4_n_0 ),
        .I3(state[3]),
        .I4(state[2]),
        .I5(state[7]),
        .O(\s_axi_awaddr[31]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hFE)) 
    \s_axi_awaddr[31]_i_3 
       (.I0(state[4]),
        .I1(state[5]),
        .I2(state[6]),
        .O(\s_axi_awaddr[31]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \s_axi_awaddr[31]_i_4 
       (.I0(state[1]),
        .I1(state[0]),
        .O(\s_axi_awaddr[31]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[0] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[0]),
        .Q(s_axi_awaddr[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[10] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[10]),
        .Q(s_axi_awaddr[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[11] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[11]),
        .Q(s_axi_awaddr[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[12] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[12]),
        .Q(s_axi_awaddr[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[13] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[13]),
        .Q(s_axi_awaddr[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[14] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[14]),
        .Q(s_axi_awaddr[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[15] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[15]),
        .Q(s_axi_awaddr[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[16] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[16]),
        .Q(s_axi_awaddr[16]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[17] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[17]),
        .Q(s_axi_awaddr[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[18] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[18]),
        .Q(s_axi_awaddr[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[19] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[19]),
        .Q(s_axi_awaddr[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[1] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[1]),
        .Q(s_axi_awaddr[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[20] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[20]),
        .Q(s_axi_awaddr[20]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[21] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[21]),
        .Q(s_axi_awaddr[21]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[22] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[22]),
        .Q(s_axi_awaddr[22]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[23] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[23]),
        .Q(s_axi_awaddr[23]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[24] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[24]),
        .Q(s_axi_awaddr[24]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[25] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[25]),
        .Q(s_axi_awaddr[25]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[26] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[26]),
        .Q(s_axi_awaddr[26]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[27] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[27]),
        .Q(s_axi_awaddr[27]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[28] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[28]),
        .Q(s_axi_awaddr[28]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[29] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[29]),
        .Q(s_axi_awaddr[29]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[2] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[2]),
        .Q(s_axi_awaddr[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[30] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[30]),
        .Q(s_axi_awaddr[30]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[31] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[31]),
        .Q(s_axi_awaddr[31]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[3] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[3]),
        .Q(s_axi_awaddr[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[4] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[4]),
        .Q(s_axi_awaddr[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[5] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[5]),
        .Q(s_axi_awaddr[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[6] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[6]),
        .Q(s_axi_awaddr[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[7] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[7]),
        .Q(s_axi_awaddr[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[8] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[8]),
        .Q(s_axi_awaddr[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_awaddr_reg[9] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(address[9]),
        .Q(s_axi_awaddr[9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFFDFFF00000088)) 
    s_axi_awvalid_i_1
       (.I0(s_axi_awvalid_i_2_n_0),
        .I1(state[0]),
        .I2(s_axi_awready),
        .I3(state[1]),
        .I4(state[2]),
        .I5(s_axi_awvalid),
        .O(s_axi_awvalid_i_1_n_0));
  LUT5 #(
    .INIT(32'h00000001)) 
    s_axi_awvalid_i_2
       (.I0(state[3]),
        .I1(state[4]),
        .I2(state[5]),
        .I3(state[6]),
        .I4(state[7]),
        .O(s_axi_awvalid_i_2_n_0));
  FDRE s_axi_awvalid_reg
       (.C(ui_clk),
        .CE(1'b1),
        .D(s_axi_awvalid_i_1_n_0),
        .Q(s_axi_awvalid),
        .R(s_axi_awvalid0));
  LUT6 #(
    .INIT(64'hFFFFEFEF00000400)) 
    s_axi_bready_i_1
       (.I0(s_axi_bready_i_2_n_0),
        .I1(state[0]),
        .I2(state[1]),
        .I3(s_axi_bvalid),
        .I4(\rd_data[31]_i_3_n_0 ),
        .I5(s_axi_bready),
        .O(s_axi_bready_i_1_n_0));
  LUT2 #(
    .INIT(4'hB)) 
    s_axi_bready_i_2
       (.I0(state[3]),
        .I1(state[2]),
        .O(s_axi_bready_i_2_n_0));
  FDRE s_axi_bready_reg
       (.C(ui_clk),
        .CE(1'b1),
        .D(s_axi_bready_i_1_n_0),
        .Q(s_axi_bready),
        .R(s_axi_awvalid0));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    s_axi_rready_i_1
       (.I0(state[6]),
        .I1(s_axi_rvalid),
        .I2(state[1]),
        .I3(s_axi_rready_i_2_n_0),
        .I4(s_axi_rready),
        .O(s_axi_rready_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000000000641100)) 
    s_axi_rready_i_2
       (.I0(state[0]),
        .I1(state[1]),
        .I2(s_axi_rvalid),
        .I3(state[2]),
        .I4(state[3]),
        .I5(s_axi_rready_i_3_n_0),
        .O(s_axi_rready_i_2_n_0));
  LUT5 #(
    .INIT(32'hFFFFFFBD)) 
    s_axi_rready_i_3
       (.I0(state[3]),
        .I1(state[5]),
        .I2(state[6]),
        .I3(state[7]),
        .I4(state[4]),
        .O(s_axi_rready_i_3_n_0));
  FDRE s_axi_rready_reg
       (.C(ui_clk),
        .CE(1'b1),
        .D(s_axi_rready_i_1_n_0),
        .Q(s_axi_rready),
        .R(s_axi_awvalid0));
  FDRE \s_axi_wdata_reg[0] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[0]),
        .Q(s_axi_wdata[0]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[10] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[10]),
        .Q(s_axi_wdata[10]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[11] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[11]),
        .Q(s_axi_wdata[11]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[12] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[12]),
        .Q(s_axi_wdata[12]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[13] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[13]),
        .Q(s_axi_wdata[13]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[14] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[14]),
        .Q(s_axi_wdata[14]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[15] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[15]),
        .Q(s_axi_wdata[15]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[16] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[16]),
        .Q(s_axi_wdata[16]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[17] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[17]),
        .Q(s_axi_wdata[17]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[18] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[18]),
        .Q(s_axi_wdata[18]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[19] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[19]),
        .Q(s_axi_wdata[19]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[1] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[1]),
        .Q(s_axi_wdata[1]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[20] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[20]),
        .Q(s_axi_wdata[20]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[21] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[21]),
        .Q(s_axi_wdata[21]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[22] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[22]),
        .Q(s_axi_wdata[22]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[23] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[23]),
        .Q(s_axi_wdata[23]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[24] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[24]),
        .Q(s_axi_wdata[24]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[25] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[25]),
        .Q(s_axi_wdata[25]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[26] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[26]),
        .Q(s_axi_wdata[26]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[27] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[27]),
        .Q(s_axi_wdata[27]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[28] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[28]),
        .Q(s_axi_wdata[28]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[29] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[29]),
        .Q(s_axi_wdata[29]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[2] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[2]),
        .Q(s_axi_wdata[2]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[30] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[30]),
        .Q(s_axi_wdata[30]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[31] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[31]),
        .Q(s_axi_wdata[31]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[3] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[3]),
        .Q(s_axi_wdata[3]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[4] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[4]),
        .Q(s_axi_wdata[4]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[5] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[5]),
        .Q(s_axi_wdata[5]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[6] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[6]),
        .Q(s_axi_wdata[6]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[7] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[7]),
        .Q(s_axi_wdata[7]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[8] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[8]),
        .Q(s_axi_wdata[8]),
        .R(1'b0));
  FDRE \s_axi_wdata_reg[9] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_data[9]),
        .Q(s_axi_wdata[9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000040)) 
    s_axi_wlast_i_1
       (.I0(state[2]),
        .I1(state[0]),
        .I2(state[1]),
        .I3(state[3]),
        .I4(\rd_data[31]_i_3_n_0 ),
        .I5(s_axi_wlast),
        .O(s_axi_wlast_i_1_n_0));
  FDRE s_axi_wlast_reg
       (.C(ui_clk),
        .CE(1'b1),
        .D(s_axi_wlast_i_1_n_0),
        .Q(s_axi_wlast),
        .R(s_axi_awvalid0));
  FDRE \s_axi_wstrb_reg[0] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_byte_mask[0]),
        .Q(s_axi_wstrb[0]),
        .R(1'b0));
  FDRE \s_axi_wstrb_reg[1] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_byte_mask[1]),
        .Q(s_axi_wstrb[1]),
        .R(1'b0));
  FDRE \s_axi_wstrb_reg[2] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_byte_mask[2]),
        .Q(s_axi_wstrb[2]),
        .R(1'b0));
  FDRE \s_axi_wstrb_reg[3] 
       (.C(ui_clk),
        .CE(valid_inp_n_1),
        .D(wr_byte_mask[3]),
        .Q(s_axi_wstrb[3]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFF7FFFF0000A000)) 
    s_axi_wvalid_i_1
       (.I0(s_axi_awvalid_i_2_n_0),
        .I1(s_axi_wready),
        .I2(state[1]),
        .I3(state[0]),
        .I4(state[2]),
        .I5(s_axi_wvalid),
        .O(s_axi_wvalid_i_1_n_0));
  FDRE s_axi_wvalid_reg
       (.C(ui_clk),
        .CE(1'b1),
        .D(s_axi_wvalid_i_1_n_0),
        .Q(s_axi_wvalid),
        .R(s_axi_awvalid0));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h00A8)) 
    \state[0]_i_2 
       (.I0(s_axi_awready),
        .I1(state[1]),
        .I2(state[6]),
        .I3(state[0]),
        .O(\state[0]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hF0C5CFCF)) 
    \state[0]_i_3 
       (.I0(state[3]),
        .I1(state[5]),
        .I2(state[2]),
        .I3(state[0]),
        .I4(state[1]),
        .O(\state[0]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h01110010)) 
    \state[0]_i_5 
       (.I0(state[6]),
        .I1(state[1]),
        .I2(state[0]),
        .I3(s_axi_rvalid),
        .I4(s_axi_arready),
        .O(\state[0]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \state[1]_i_3 
       (.I0(s_axi_rresp[1]),
        .I1(s_axi_rresp[0]),
        .O(\state[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000040)) 
    \state[1]_i_4 
       (.I0(state[6]),
        .I1(state[0]),
        .I2(s_axi_bvalid),
        .I3(state[1]),
        .I4(s_axi_bresp[0]),
        .I5(s_axi_bresp[1]),
        .O(\state[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFDFF5555FC000000)) 
    \state[2]_i_3 
       (.I0(\state[7]_i_7_n_0 ),
        .I1(s_axi_rresp[0]),
        .I2(s_axi_rresp[1]),
        .I3(s_axi_rvalid),
        .I4(\state[7]_i_6_n_0 ),
        .I5(state[2]),
        .O(\state[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0030FF00003FFF55)) 
    \state[3]_i_2 
       (.I0(s_axi_arready),
        .I1(\state[1]_i_3_n_0 ),
        .I2(s_axi_rvalid),
        .I3(\state[7]_i_10_n_0 ),
        .I4(state[0]),
        .I5(state[3]),
        .O(\state[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h01000D000D0C0D00)) 
    \state[5]_i_2 
       (.I0(s_axi_arready),
        .I1(state[0]),
        .I2(\state[7]_i_10_n_0 ),
        .I3(state[5]),
        .I4(s_axi_rvalid),
        .I5(\state[1]_i_3_n_0 ),
        .O(\state[5]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h08)) 
    \state[5]_i_3 
       (.I0(\state[6]_i_6_n_0 ),
        .I1(state[5]),
        .I2(s_axi_awready),
        .O(\state[5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h1010100000000000)) 
    \state[6]_i_2 
       (.I0(state[1]),
        .I1(state[6]),
        .I2(state[0]),
        .I3(s_axi_rresp[1]),
        .I4(s_axi_rresp[0]),
        .I5(s_axi_rvalid),
        .O(\state[6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \state[6]_i_3 
       (.I0(\state[6]_i_6_n_0 ),
        .I1(state[6]),
        .I2(s_axi_awready),
        .O(\state[6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h000000DD8DDD8D00)) 
    \state[6]_i_4 
       (.I0(state[2]),
        .I1(state[5]),
        .I2(state[3]),
        .I3(state[1]),
        .I4(state[6]),
        .I5(state[0]),
        .O(\state[6]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'h0ECE3FCE)) 
    \state[6]_i_6 
       (.I0(state[6]),
        .I1(state[1]),
        .I2(state[0]),
        .I3(state[2]),
        .I4(state[5]),
        .O(\state[6]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hEFEFFF0F)) 
    \state[6]_i_7 
       (.I0(s_axi_bresp[1]),
        .I1(s_axi_bresp[0]),
        .I2(state[0]),
        .I3(state[5]),
        .I4(s_axi_bvalid),
        .O(\state[6]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h56)) 
    \state[6]_i_8 
       (.I0(state[0]),
        .I1(state[6]),
        .I2(state[1]),
        .O(\state[6]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \state[6]_i_9 
       (.I0(state[0]),
        .I1(s_axi_wready),
        .O(\state[6]_i_9_n_0 ));
  LUT3 #(
    .INIT(8'h02)) 
    \state[7]_i_1 
       (.I0(\state[7]_i_3_n_0 ),
        .I1(state[4]),
        .I2(state[7]),
        .O(\state[7]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \state[7]_i_10 
       (.I0(state[1]),
        .I1(state[6]),
        .O(\state[7]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h00100000000007FF)) 
    \state[7]_i_3 
       (.I0(state[0]),
        .I1(state[1]),
        .I2(state[2]),
        .I3(state[3]),
        .I4(state[6]),
        .I5(state[5]),
        .O(\state[7]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hAAFCA8FC)) 
    \state[7]_i_5 
       (.I0(state[0]),
        .I1(state[5]),
        .I2(state[3]),
        .I3(state[1]),
        .I4(state[2]),
        .O(\state[7]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h02)) 
    \state[7]_i_6 
       (.I0(state[0]),
        .I1(state[6]),
        .I2(state[1]),
        .O(\state[7]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \state[7]_i_7 
       (.I0(state[6]),
        .I1(state[1]),
        .I2(s_axi_arready),
        .I3(state[0]),
        .O(\state[7]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h00000035)) 
    \state[7]_i_8 
       (.I0(s_axi_wready),
        .I1(s_axi_bvalid),
        .I2(state[0]),
        .I3(state[1]),
        .I4(state[6]),
        .O(\state[7]_i_8_n_0 ));
  (* DONT_TOUCH *) 
  (* FSM_ENCODED_STATES = "iSTATE:00000000,iSTATE0:00000001,iSTATE1:00000010,iSTATE2:00000011,iSTATE3:00000100,iSTATE4:00000101,iSTATE5:00000110,iSTATE6:00000111,iSTATE7:00001000,iSTATE8:00001001,iSTATE9:00001010,iSTATE10:01100100" *) 
  (* KEEP = "yes" *) 
  FDRE \state_reg[0] 
       (.C(ui_clk),
        .CE(\state[7]_i_1_n_0 ),
        .D(p_0_in__0[0]),
        .Q(state[0]),
        .R(s_axi_awvalid0));
  (* DONT_TOUCH *) 
  (* FSM_ENCODED_STATES = "iSTATE:00000000,iSTATE0:00000001,iSTATE1:00000010,iSTATE2:00000011,iSTATE3:00000100,iSTATE4:00000101,iSTATE5:00000110,iSTATE6:00000111,iSTATE7:00001000,iSTATE8:00001001,iSTATE9:00001010,iSTATE10:01100100" *) 
  (* KEEP = "yes" *) 
  FDRE \state_reg[1] 
       (.C(ui_clk),
        .CE(\state[7]_i_1_n_0 ),
        .D(p_0_in__0[1]),
        .Q(state[1]),
        .R(s_axi_awvalid0));
  (* DONT_TOUCH *) 
  (* FSM_ENCODED_STATES = "iSTATE:00000000,iSTATE0:00000001,iSTATE1:00000010,iSTATE2:00000011,iSTATE3:00000100,iSTATE4:00000101,iSTATE5:00000110,iSTATE6:00000111,iSTATE7:00001000,iSTATE8:00001001,iSTATE9:00001010,iSTATE10:01100100" *) 
  (* KEEP = "yes" *) 
  FDRE \state_reg[2] 
       (.C(ui_clk),
        .CE(\state[7]_i_1_n_0 ),
        .D(p_0_in__0[2]),
        .Q(state[2]),
        .R(s_axi_awvalid0));
  (* DONT_TOUCH *) 
  (* FSM_ENCODED_STATES = "iSTATE:00000000,iSTATE0:00000001,iSTATE1:00000010,iSTATE2:00000011,iSTATE3:00000100,iSTATE4:00000101,iSTATE5:00000110,iSTATE6:00000111,iSTATE7:00001000,iSTATE8:00001001,iSTATE9:00001010,iSTATE10:01100100" *) 
  (* KEEP = "yes" *) 
  FDRE \state_reg[3] 
       (.C(ui_clk),
        .CE(\state[7]_i_1_n_0 ),
        .D(p_0_in__0[3]),
        .Q(state[3]),
        .R(s_axi_awvalid0));
  (* DONT_TOUCH *) 
  (* FSM_ENCODED_STATES = "iSTATE:00000000,iSTATE0:00000001,iSTATE1:00000010,iSTATE2:00000011,iSTATE3:00000100,iSTATE4:00000101,iSTATE5:00000110,iSTATE6:00000111,iSTATE7:00001000,iSTATE8:00001001,iSTATE9:00001010,iSTATE10:01100100" *) 
  (* KEEP = "yes" *) 
  FDRE \state_reg[4] 
       (.C(ui_clk),
        .CE(\state[7]_i_1_n_0 ),
        .D(p_0_in__0[4]),
        .Q(state[4]),
        .R(s_axi_awvalid0));
  (* DONT_TOUCH *) 
  (* FSM_ENCODED_STATES = "iSTATE:00000000,iSTATE0:00000001,iSTATE1:00000010,iSTATE2:00000011,iSTATE3:00000100,iSTATE4:00000101,iSTATE5:00000110,iSTATE6:00000111,iSTATE7:00001000,iSTATE8:00001001,iSTATE9:00001010,iSTATE10:01100100" *) 
  (* KEEP = "yes" *) 
  FDRE \state_reg[5] 
       (.C(ui_clk),
        .CE(\state[7]_i_1_n_0 ),
        .D(p_0_in__0[5]),
        .Q(state[5]),
        .R(s_axi_awvalid0));
  (* DONT_TOUCH *) 
  (* FSM_ENCODED_STATES = "iSTATE:00000000,iSTATE0:00000001,iSTATE1:00000010,iSTATE2:00000011,iSTATE3:00000100,iSTATE4:00000101,iSTATE5:00000110,iSTATE6:00000111,iSTATE7:00001000,iSTATE8:00001001,iSTATE9:00001010,iSTATE10:01100100" *) 
  (* KEEP = "yes" *) 
  FDRE \state_reg[6] 
       (.C(ui_clk),
        .CE(\state[7]_i_1_n_0 ),
        .D(p_0_in__0[6]),
        .Q(state[6]),
        .R(s_axi_awvalid0));
  (* DONT_TOUCH *) 
  (* FSM_ENCODED_STATES = "iSTATE:00000000,iSTATE0:00000001,iSTATE1:00000010,iSTATE2:00000011,iSTATE3:00000100,iSTATE4:00000101,iSTATE5:00000110,iSTATE6:00000111,iSTATE7:00001000,iSTATE8:00001001,iSTATE9:00001010,iSTATE10:01100100" *) 
  (* KEEP = "yes" *) 
  FDRE \state_reg[7] 
       (.C(ui_clk),
        .CE(\state[7]_i_1_n_0 ),
        .D(p_0_in__0[7]),
        .Q(state[7]),
        .R(s_axi_awvalid0));
  ethernetlite_axi_ethernet_0_0_Signal_CrossDomain_1 valid_inp
       (.D(p_0_in__0),
        .E(valid_inp_n_0),
        .Q(state),
        .i_cen(i_cen),
        .i_cen_0(valid_inp_n_1),
        .i_valid_p(i_valid_p),
        .i_wren(i_wren),
        .o_ready(o_ready),
        .o_ready_reg(o_ready_i_2_n_0),
        .out(state[6]),
        .\s_axi_araddr_reg[0] (\s_axi_awaddr[31]_i_2_n_0 ),
        .s_axi_awready(s_axi_awready),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_wready(s_axi_wready),
        .\state_reg[0] (\state[0]_i_2_n_0 ),
        .\state_reg[0]_0 (\state[0]_i_3_n_0 ),
        .\state_reg[0]_1 (\state[0]_i_5_n_0 ),
        .\state_reg[0]_2 (\state[7]_i_10_n_0 ),
        .\state_reg[1] (\state[7]_i_5_n_0 ),
        .\state_reg[1]_0 (\state[7]_i_6_n_0 ),
        .\state_reg[1]_1 (\state[1]_i_3_n_0 ),
        .\state_reg[1]_2 (\state[1]_i_4_n_0 ),
        .\state_reg[1]_3 (\state[6]_i_6_n_0 ),
        .\state_reg[2] (\state[2]_i_3_n_0 ),
        .\state_reg[3] (\state[3]_i_2_n_0 ),
        .\state_reg[4] (\state[7]_i_7_n_0 ),
        .\state_reg[5] (\state[6]_i_4_n_0 ),
        .\state_reg[5]_0 (\state[5]_i_2_n_0 ),
        .\state_reg[5]_1 (\state[5]_i_3_n_0 ),
        .\state_reg[5]_2 (\state[6]_i_7_n_0 ),
        .\state_reg[5]_3 (\state[6]_i_8_n_0 ),
        .\state_reg[5]_4 (\state[6]_i_9_n_0 ),
        .\state_reg[6] (valid_inp_n_10),
        .\state_reg[6]_0 (\state[6]_i_2_n_0 ),
        .\state_reg[6]_1 (\state[6]_i_3_n_0 ),
        .\state_reg[7] (\state[7]_i_8_n_0 ),
        .ui_clk(ui_clk));
  LUT4 #(
    .INIT(16'h2F20)) 
    wr_ack_i_1
       (.I0(state[2]),
        .I1(state[6]),
        .I2(wr_ack_i_2_n_0),
        .I3(wr_ack),
        .O(wr_ack_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000000010040001)) 
    wr_ack_i_2
       (.I0(wr_ack_i_3_n_0),
        .I1(state[1]),
        .I2(state[6]),
        .I3(state[5]),
        .I4(state[2]),
        .I5(state[3]),
        .O(wr_ack_i_2_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    wr_ack_i_3
       (.I0(state[0]),
        .I1(state[4]),
        .I2(state[7]),
        .O(wr_ack_i_3_n_0));
  FDRE #(
    .INIT(1'b0)) 
    wr_ack_reg
       (.C(ui_clk),
        .CE(1'b1),
        .D(wr_ack_i_1_n_0),
        .Q(wr_ack),
        .R(s_axi_awvalid0));
  ethernetlite_axi_ethernet_0_0_Signal_CrossDomain_2 wrack
       (.sys_clock(sys_clock),
        .wr_ack(wr_ack),
        .wr_ack_p(wr_ack_p));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
