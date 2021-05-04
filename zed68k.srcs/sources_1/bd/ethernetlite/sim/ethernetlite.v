//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
//Date        : Tue May  4 10:54:01 2021
//Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
//Command     : generate_target ethernetlite.bd
//Design      : ethernetlite
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "ethernetlite,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=ethernetlite,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=2,numReposBlks=2,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "ethernetlite.hwdef" *) 
module ethernetlite
   (address,
    eth_intr,
    eth_mdio_mdc_mdc,
    eth_mdio_mdc_mdio_i,
    eth_mdio_mdc_mdio_o,
    eth_mdio_mdc_mdio_t,
    eth_mii_col,
    eth_mii_crs,
    eth_mii_rst_n,
    eth_mii_rx_clk,
    eth_mii_rx_dv,
    eth_mii_rx_er,
    eth_mii_rxd,
    eth_mii_tx_clk,
    eth_mii_tx_en,
    eth_mii_txd,
    i_cen,
    i_valid_p,
    i_wren,
    o_ready_p,
    o_valid_p,
    rd_data,
    sys_clock,
    sys_resetn,
    wr_ack_p,
    wr_byte_mask,
    wr_data);
  input [31:0]address;
  (* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 INTR.ETH_INTR INTERRUPT" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME INTR.ETH_INTR, PortWidth 1, SENSITIVITY EDGE_RISING" *) output eth_intr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mdio:1.0 eth_mdio_mdc MDC" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME eth_mdio_mdc, CAN_DEBUG false" *) output eth_mdio_mdc_mdc;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mdio:1.0 eth_mdio_mdc MDIO_I" *) input eth_mdio_mdc_mdio_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mdio:1.0 eth_mdio_mdc MDIO_O" *) output eth_mdio_mdc_mdio_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mdio:1.0 eth_mdio_mdc MDIO_T" *) output eth_mdio_mdc_mdio_t;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mii:1.0 eth_mii COL" *) input eth_mii_col;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mii:1.0 eth_mii CRS" *) input eth_mii_crs;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mii:1.0 eth_mii RST_N" *) output eth_mii_rst_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mii:1.0 eth_mii RX_CLK" *) input eth_mii_rx_clk;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mii:1.0 eth_mii RX_DV" *) input eth_mii_rx_dv;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mii:1.0 eth_mii RX_ER" *) input eth_mii_rx_er;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mii:1.0 eth_mii RXD" *) input [3:0]eth_mii_rxd;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mii:1.0 eth_mii TX_CLK" *) input eth_mii_tx_clk;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mii:1.0 eth_mii TX_EN" *) output eth_mii_tx_en;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mii:1.0 eth_mii TXD" *) output [3:0]eth_mii_txd;
  input i_cen;
  input i_valid_p;
  input i_wren;
  output o_ready_p;
  output o_valid_p;
  output [31:0]rd_data;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SYS_CLOCK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SYS_CLOCK, ASSOCIATED_RESET sys_resetn, CLK_DOMAIN ethernetlite_sys_clock_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input sys_clock;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.SYS_RESETN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.SYS_RESETN, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input sys_resetn;
  output wr_ack_p;
  input [3:0]wr_byte_mask;
  input [31:0]wr_data;

  wire [31:0]address_0_1;
  wire axi_ethernet_0_o_ready_p;
  wire axi_ethernet_0_o_valid_p;
  wire [31:0]axi_ethernet_0_rd_data;
  wire [31:0]axi_ethernet_0_s_axi_ARADDR;
  wire [1:0]axi_ethernet_0_s_axi_ARBURST;
  wire [7:0]axi_ethernet_0_s_axi_ARLEN;
  wire axi_ethernet_0_s_axi_ARREADY;
  wire [2:0]axi_ethernet_0_s_axi_ARSIZE;
  wire axi_ethernet_0_s_axi_ARVALID;
  wire [31:0]axi_ethernet_0_s_axi_AWADDR;
  wire [1:0]axi_ethernet_0_s_axi_AWBURST;
  wire [7:0]axi_ethernet_0_s_axi_AWLEN;
  wire axi_ethernet_0_s_axi_AWREADY;
  wire [2:0]axi_ethernet_0_s_axi_AWSIZE;
  wire axi_ethernet_0_s_axi_AWVALID;
  wire [3:0]axi_ethernet_0_s_axi_BID;
  wire axi_ethernet_0_s_axi_BREADY;
  wire [1:0]axi_ethernet_0_s_axi_BRESP;
  wire axi_ethernet_0_s_axi_BVALID;
  wire [31:0]axi_ethernet_0_s_axi_RDATA;
  wire [3:0]axi_ethernet_0_s_axi_RID;
  wire axi_ethernet_0_s_axi_RLAST;
  wire axi_ethernet_0_s_axi_RREADY;
  wire [1:0]axi_ethernet_0_s_axi_RRESP;
  wire axi_ethernet_0_s_axi_RVALID;
  wire [31:0]axi_ethernet_0_s_axi_WDATA;
  wire axi_ethernet_0_s_axi_WLAST;
  wire axi_ethernet_0_s_axi_WREADY;
  wire [3:0]axi_ethernet_0_s_axi_WSTRB;
  wire axi_ethernet_0_s_axi_WVALID;
  wire axi_ethernet_0_wr_ack_p;
  wire axi_ethernetlite_0_MDIO_MDC;
  wire axi_ethernetlite_0_MDIO_MDIO_I;
  wire axi_ethernetlite_0_MDIO_MDIO_O;
  wire axi_ethernetlite_0_MDIO_MDIO_T;
  wire axi_ethernetlite_0_MII_COL;
  wire axi_ethernetlite_0_MII_CRS;
  wire axi_ethernetlite_0_MII_RST_N;
  wire [3:0]axi_ethernetlite_0_MII_RXD;
  wire axi_ethernetlite_0_MII_RX_CLK;
  wire axi_ethernetlite_0_MII_RX_DV;
  wire axi_ethernetlite_0_MII_RX_ER;
  wire [3:0]axi_ethernetlite_0_MII_TXD;
  wire axi_ethernetlite_0_MII_TX_CLK;
  wire axi_ethernetlite_0_MII_TX_EN;
  wire axi_ethernetlite_0_ip2intc_irpt;
  wire i_cen_0_1;
  wire i_valid_p_0_1;
  wire i_wren_0_1;
  wire sys_clock_0_1;
  wire sys_resetn_0_1;
  wire [3:0]wr_byte_mask_0_1;
  wire [31:0]wr_data_0_1;

  assign address_0_1 = address[31:0];
  assign axi_ethernetlite_0_MDIO_MDIO_I = eth_mdio_mdc_mdio_i;
  assign axi_ethernetlite_0_MII_COL = eth_mii_col;
  assign axi_ethernetlite_0_MII_CRS = eth_mii_crs;
  assign axi_ethernetlite_0_MII_RXD = eth_mii_rxd[3:0];
  assign axi_ethernetlite_0_MII_RX_CLK = eth_mii_rx_clk;
  assign axi_ethernetlite_0_MII_RX_DV = eth_mii_rx_dv;
  assign axi_ethernetlite_0_MII_RX_ER = eth_mii_rx_er;
  assign axi_ethernetlite_0_MII_TX_CLK = eth_mii_tx_clk;
  assign eth_intr = axi_ethernetlite_0_ip2intc_irpt;
  assign eth_mdio_mdc_mdc = axi_ethernetlite_0_MDIO_MDC;
  assign eth_mdio_mdc_mdio_o = axi_ethernetlite_0_MDIO_MDIO_O;
  assign eth_mdio_mdc_mdio_t = axi_ethernetlite_0_MDIO_MDIO_T;
  assign eth_mii_rst_n = axi_ethernetlite_0_MII_RST_N;
  assign eth_mii_tx_en = axi_ethernetlite_0_MII_TX_EN;
  assign eth_mii_txd[3:0] = axi_ethernetlite_0_MII_TXD;
  assign i_cen_0_1 = i_cen;
  assign i_valid_p_0_1 = i_valid_p;
  assign i_wren_0_1 = i_wren;
  assign o_ready_p = axi_ethernet_0_o_ready_p;
  assign o_valid_p = axi_ethernet_0_o_valid_p;
  assign rd_data[31:0] = axi_ethernet_0_rd_data;
  assign sys_clock_0_1 = sys_clock;
  assign sys_resetn_0_1 = sys_resetn;
  assign wr_ack_p = axi_ethernet_0_wr_ack_p;
  assign wr_byte_mask_0_1 = wr_byte_mask[3:0];
  assign wr_data_0_1 = wr_data[31:0];
  ethernetlite_axi_ethernet_0_0 axi_ethernet_0
       (.address(address_0_1),
        .i_cen(i_cen_0_1),
        .i_valid_p(i_valid_p_0_1),
        .i_wren(i_wren_0_1),
        .init_calib_complete(sys_resetn_0_1),
        .o_ready_p(axi_ethernet_0_o_ready_p),
        .o_valid_p(axi_ethernet_0_o_valid_p),
        .rd_data(axi_ethernet_0_rd_data),
        .s_axi_araddr(axi_ethernet_0_s_axi_ARADDR),
        .s_axi_arburst(axi_ethernet_0_s_axi_ARBURST),
        .s_axi_arlen(axi_ethernet_0_s_axi_ARLEN),
        .s_axi_arready(axi_ethernet_0_s_axi_ARREADY),
        .s_axi_arsize(axi_ethernet_0_s_axi_ARSIZE),
        .s_axi_arvalid(axi_ethernet_0_s_axi_ARVALID),
        .s_axi_awaddr(axi_ethernet_0_s_axi_AWADDR),
        .s_axi_awburst(axi_ethernet_0_s_axi_AWBURST),
        .s_axi_awlen(axi_ethernet_0_s_axi_AWLEN),
        .s_axi_awready(axi_ethernet_0_s_axi_AWREADY),
        .s_axi_awsize(axi_ethernet_0_s_axi_AWSIZE),
        .s_axi_awvalid(axi_ethernet_0_s_axi_AWVALID),
        .s_axi_bid(axi_ethernet_0_s_axi_BID),
        .s_axi_bready(axi_ethernet_0_s_axi_BREADY),
        .s_axi_bresp(axi_ethernet_0_s_axi_BRESP),
        .s_axi_bvalid(axi_ethernet_0_s_axi_BVALID),
        .s_axi_rdata(axi_ethernet_0_s_axi_RDATA),
        .s_axi_rid(axi_ethernet_0_s_axi_RID),
        .s_axi_rlast(axi_ethernet_0_s_axi_RLAST),
        .s_axi_rready(axi_ethernet_0_s_axi_RREADY),
        .s_axi_rresp(axi_ethernet_0_s_axi_RRESP),
        .s_axi_rvalid(axi_ethernet_0_s_axi_RVALID),
        .s_axi_wdata(axi_ethernet_0_s_axi_WDATA),
        .s_axi_wlast(axi_ethernet_0_s_axi_WLAST),
        .s_axi_wready(axi_ethernet_0_s_axi_WREADY),
        .s_axi_wstrb(axi_ethernet_0_s_axi_WSTRB),
        .s_axi_wvalid(axi_ethernet_0_s_axi_WVALID),
        .sys_clock(sys_clock_0_1),
        .sys_resetn(sys_resetn_0_1),
        .ui_clk(sys_clock_0_1),
        .ui_clk_sync_rst(sys_resetn_0_1),
        .wr_ack_p(axi_ethernet_0_wr_ack_p),
        .wr_byte_mask(wr_byte_mask_0_1),
        .wr_data(wr_data_0_1));
  ethernetlite_axi_ethernetlite_0_0 axi_ethernetlite_0
       (.ip2intc_irpt(axi_ethernetlite_0_ip2intc_irpt),
        .phy_col(axi_ethernetlite_0_MII_COL),
        .phy_crs(axi_ethernetlite_0_MII_CRS),
        .phy_dv(axi_ethernetlite_0_MII_RX_DV),
        .phy_mdc(axi_ethernetlite_0_MDIO_MDC),
        .phy_mdio_i(axi_ethernetlite_0_MDIO_MDIO_I),
        .phy_mdio_o(axi_ethernetlite_0_MDIO_MDIO_O),
        .phy_mdio_t(axi_ethernetlite_0_MDIO_MDIO_T),
        .phy_rst_n(axi_ethernetlite_0_MII_RST_N),
        .phy_rx_clk(axi_ethernetlite_0_MII_RX_CLK),
        .phy_rx_data(axi_ethernetlite_0_MII_RXD),
        .phy_rx_er(axi_ethernetlite_0_MII_RX_ER),
        .phy_tx_clk(axi_ethernetlite_0_MII_TX_CLK),
        .phy_tx_data(axi_ethernetlite_0_MII_TXD),
        .phy_tx_en(axi_ethernetlite_0_MII_TX_EN),
        .s_axi_aclk(sys_clock_0_1),
        .s_axi_araddr(axi_ethernet_0_s_axi_ARADDR[12:0]),
        .s_axi_arburst(axi_ethernet_0_s_axi_ARBURST),
        .s_axi_arcache({1'b0,1'b0,1'b1,1'b1}),
        .s_axi_aresetn(sys_resetn_0_1),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen(axi_ethernet_0_s_axi_ARLEN),
        .s_axi_arready(axi_ethernet_0_s_axi_ARREADY),
        .s_axi_arsize(axi_ethernet_0_s_axi_ARSIZE),
        .s_axi_arvalid(axi_ethernet_0_s_axi_ARVALID),
        .s_axi_awaddr(axi_ethernet_0_s_axi_AWADDR[12:0]),
        .s_axi_awburst(axi_ethernet_0_s_axi_AWBURST),
        .s_axi_awcache({1'b0,1'b0,1'b1,1'b1}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen(axi_ethernet_0_s_axi_AWLEN),
        .s_axi_awready(axi_ethernet_0_s_axi_AWREADY),
        .s_axi_awsize(axi_ethernet_0_s_axi_AWSIZE),
        .s_axi_awvalid(axi_ethernet_0_s_axi_AWVALID),
        .s_axi_bid(axi_ethernet_0_s_axi_BID),
        .s_axi_bready(axi_ethernet_0_s_axi_BREADY),
        .s_axi_bresp(axi_ethernet_0_s_axi_BRESP),
        .s_axi_bvalid(axi_ethernet_0_s_axi_BVALID),
        .s_axi_rdata(axi_ethernet_0_s_axi_RDATA),
        .s_axi_rid(axi_ethernet_0_s_axi_RID),
        .s_axi_rlast(axi_ethernet_0_s_axi_RLAST),
        .s_axi_rready(axi_ethernet_0_s_axi_RREADY),
        .s_axi_rresp(axi_ethernet_0_s_axi_RRESP),
        .s_axi_rvalid(axi_ethernet_0_s_axi_RVALID),
        .s_axi_wdata(axi_ethernet_0_s_axi_WDATA),
        .s_axi_wlast(axi_ethernet_0_s_axi_WLAST),
        .s_axi_wready(axi_ethernet_0_s_axi_WREADY),
        .s_axi_wstrb(axi_ethernet_0_s_axi_WSTRB),
        .s_axi_wvalid(axi_ethernet_0_s_axi_WVALID));
endmodule
