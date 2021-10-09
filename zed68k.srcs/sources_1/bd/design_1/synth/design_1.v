//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
//Date        : Fri Oct  8 20:45:52 2021
//Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=11,numReposBlks=11,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,da_board_cnt=2,da_clkrst_cnt=2,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (Interrupt_100hz,
    Interrupt_ms,
    Interrupt_us,
    clk_en_n,
    clock100,
    reset_n,
    timer_en);
  (* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 INTR.INTERRUPT_100HZ INTERRUPT" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME INTR.INTERRUPT_100HZ, PortWidth 1, SENSITIVITY LEVEL_HIGH" *) output Interrupt_100hz;
  (* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 INTR.INTERRUPT_MS INTERRUPT" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME INTR.INTERRUPT_MS, PortWidth 1, SENSITIVITY LEVEL_HIGH" *) output Interrupt_ms;
  (* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 INTR.INTERRUPT_US INTERRUPT" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME INTR.INTERRUPT_US, PortWidth 1, SENSITIVITY LEVEL_HIGH" *) output Interrupt_us;
  input clk_en_n;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLOCK100 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLOCK100, ASSOCIATED_RESET reset_n, CLK_DOMAIN design_1_clock_rtl, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input clock100;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET_N RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET_N, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input reset_n;
  input [2:0]timer_en;

  wire clk_wiz_clk_out1;
  wire clk_wiz_locked;
  wire clock_rtl_1;
  wire ms_timer_Interrupt;
  wire ms_timer_Interrupt1;
  wire power_down_0_1;
  wire reset_n_1;
  wire [0:0]rst_clk_wiz_100M_peripheral_reset;
  wire timer100_khz_Interrupt;
  wire [2:0]timer_en_1;
  wire [0:0]util_vector_logic_0_Res;
  wire [0:0]util_vector_logic_1_Res;
  wire [0:0]util_vector_logic_2_Res;
  wire [0:0]xlslice_0_Dout;
  wire [0:0]xlslice_1_Dout;
  wire [0:0]xlslice_2_Dout;

  assign Interrupt_100hz = timer100_khz_Interrupt;
  assign Interrupt_ms = ms_timer_Interrupt1;
  assign Interrupt_us = ms_timer_Interrupt;
  assign clock_rtl_1 = clock100;
  assign power_down_0_1 = clk_en_n;
  assign reset_n_1 = reset_n;
  assign timer_en_1 = timer_en[2:0];
  design_1_clk_wiz_0 clk_wiz
       (.clk_in1(clock_rtl_1),
        .clk_out1(clk_wiz_clk_out1),
        .locked(clk_wiz_locked),
        .power_down(power_down_0_1),
        .resetn(reset_n_1));
  design_1_us_timer_0 ms_timer
       (.Clk(util_vector_logic_2_Res),
        .Interrupt(ms_timer_Interrupt1),
        .Rst(rst_clk_wiz_100M_peripheral_reset));
  design_1_rst_clk_wiz_100M_0 rst_clk_wiz_100M
       (.aux_reset_in(1'b1),
        .dcm_locked(clk_wiz_locked),
        .ext_reset_in(reset_n_1),
        .mb_debug_sys_rst(1'b0),
        .peripheral_reset(rst_clk_wiz_100M_peripheral_reset),
        .slowest_sync_clk(clk_wiz_clk_out1));
  design_1_fit_timer_0_1 timer100hz
       (.Clk(util_vector_logic_1_Res),
        .Interrupt(timer100_khz_Interrupt),
        .Rst(rst_clk_wiz_100M_peripheral_reset));
  design_1_fit_timer_0_0 us_timer
       (.Clk(util_vector_logic_0_Res),
        .Interrupt(ms_timer_Interrupt),
        .Rst(rst_clk_wiz_100M_peripheral_reset));
  design_1_util_vector_logic_0_0 util_vector_logic_0
       (.Op1(xlslice_0_Dout),
        .Op2(clk_wiz_clk_out1),
        .Res(util_vector_logic_0_Res));
  design_1_util_vector_logic_0_1 util_vector_logic_1
       (.Op1(xlslice_1_Dout),
        .Op2(clk_wiz_clk_out1),
        .Res(util_vector_logic_1_Res));
  design_1_util_vector_logic_1_0 util_vector_logic_2
       (.Op1(xlslice_2_Dout),
        .Op2(clk_wiz_clk_out1),
        .Res(util_vector_logic_2_Res));
  design_1_xlslice_0_0 xlslice_0
       (.Din(timer_en_1),
        .Dout(xlslice_0_Dout));
  design_1_xlslice_1_0 xlslice_1
       (.Din(timer_en_1),
        .Dout(xlslice_1_Dout));
  design_1_xlslice_1_1 xlslice_2
       (.Din(timer_en_1),
        .Dout(xlslice_2_Dout));
endmodule
