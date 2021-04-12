// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Fri Apr  9 21:23:10 2021
// Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/code/zed-68k/zed68k.srcs/sources_1/bd/design_1/ip/design_1_UART_RX_0_0/design_1_UART_RX_0_0_sim_netlist.v
// Design      : design_1_UART_RX_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_UART_RX_0_0,UART_RX,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "UART_RX,Vivado 2020.1" *) 
(* NotValidForBitStream *)
module design_1_UART_RX_0_0
   (i_Clk,
    i_RX_Serial,
    o_RX_DV,
    o_RX_Byte);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 i_Clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME i_Clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_1_clk100_i, INSERT_VIP 0" *) input i_Clk;
  input i_RX_Serial;
  output o_RX_DV;
  output [7:0]o_RX_Byte;

  wire i_Clk;
  wire i_RX_Serial;
  wire [7:0]o_RX_Byte;
  wire o_RX_DV;

  design_1_UART_RX_0_0_UART_RX inst
       (.i_Clk(i_Clk),
        .i_RX_Serial(i_RX_Serial),
        .o_RX_Byte(o_RX_Byte),
        .o_RX_DV(o_RX_DV));
endmodule

(* ORIG_REF_NAME = "UART_RX" *) 
module design_1_UART_RX_0_0_UART_RX
   (o_RX_DV,
    o_RX_Byte,
    i_RX_Serial,
    i_Clk);
  output o_RX_DV;
  output [7:0]o_RX_Byte;
  input i_RX_Serial;
  input i_Clk;

  wire i_Clk;
  wire i_RX_Serial;
  wire [7:0]o_RX_Byte;
  wire o_RX_DV;
  wire \r_Bit_Index[0]_i_1_n_0 ;
  wire \r_Bit_Index[1]_i_1_n_0 ;
  wire \r_Bit_Index[2]_i_1_n_0 ;
  wire \r_Bit_Index[2]_i_2_n_0 ;
  wire \r_Bit_Index_reg_n_0_[0] ;
  wire \r_Bit_Index_reg_n_0_[1] ;
  wire \r_Bit_Index_reg_n_0_[2] ;
  wire \r_Clk_Count[0]_i_1_n_0 ;
  wire \r_Clk_Count[1]_i_1_n_0 ;
  wire \r_Clk_Count[2]_i_1_n_0 ;
  wire \r_Clk_Count[3]_i_1_n_0 ;
  wire \r_Clk_Count[4]_i_1_n_0 ;
  wire \r_Clk_Count[5]_i_1_n_0 ;
  wire \r_Clk_Count[6]_i_1_n_0 ;
  wire \r_Clk_Count[6]_i_2_n_0 ;
  wire \r_Clk_Count[7]_i_1_n_0 ;
  wire \r_Clk_Count[8]_i_1_n_0 ;
  wire \r_Clk_Count[8]_i_2_n_0 ;
  wire \r_Clk_Count[8]_i_3_n_0 ;
  wire \r_Clk_Count[8]_i_4_n_0 ;
  wire \r_Clk_Count[8]_i_5_n_0 ;
  wire \r_Clk_Count[9]_i_1_n_0 ;
  wire \r_Clk_Count[9]_i_2_n_0 ;
  wire \r_Clk_Count[9]_i_3_n_0 ;
  wire \r_Clk_Count[9]_i_4_n_0 ;
  wire \r_Clk_Count_reg_n_0_[0] ;
  wire \r_Clk_Count_reg_n_0_[1] ;
  wire \r_Clk_Count_reg_n_0_[2] ;
  wire \r_Clk_Count_reg_n_0_[3] ;
  wire \r_Clk_Count_reg_n_0_[4] ;
  wire \r_Clk_Count_reg_n_0_[5] ;
  wire \r_Clk_Count_reg_n_0_[6] ;
  wire \r_Clk_Count_reg_n_0_[7] ;
  wire \r_Clk_Count_reg_n_0_[8] ;
  wire \r_Clk_Count_reg_n_0_[9] ;
  wire \r_RX_Byte[0]_i_1_n_0 ;
  wire \r_RX_Byte[1]_i_1_n_0 ;
  wire \r_RX_Byte[2]_i_1_n_0 ;
  wire \r_RX_Byte[3]_i_1_n_0 ;
  wire \r_RX_Byte[4]_i_1_n_0 ;
  wire \r_RX_Byte[5]_i_1_n_0 ;
  wire \r_RX_Byte[6]_i_1_n_0 ;
  wire \r_RX_Byte[7]_i_1_n_0 ;
  wire \r_RX_Byte[7]_i_2_n_0 ;
  wire r_RX_DV_i_1_n_0;
  wire r_RX_DV_i_2_n_0;
  wire r_RX_DV_i_3_n_0;
  wire \r_SM_Main[0]_i_1_n_0 ;
  wire \r_SM_Main[0]_i_2_n_0 ;
  wire \r_SM_Main[0]_i_3_n_0 ;
  wire \r_SM_Main[1]_i_1_n_0 ;
  wire \r_SM_Main[1]_i_2_n_0 ;
  wire \r_SM_Main[1]_i_3_n_0 ;
  wire \r_SM_Main[2]_i_1_n_0 ;
  wire \r_SM_Main_reg_n_0_[0] ;
  wire \r_SM_Main_reg_n_0_[1] ;
  wire \r_SM_Main_reg_n_0_[2] ;

  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h99999990)) 
    \r_Bit_Index[0]_i_1 
       (.I0(\r_Bit_Index_reg_n_0_[0] ),
        .I1(\r_RX_Byte[7]_i_2_n_0 ),
        .I2(\r_SM_Main_reg_n_0_[2] ),
        .I3(\r_SM_Main_reg_n_0_[1] ),
        .I4(\r_SM_Main_reg_n_0_[0] ),
        .O(\r_Bit_Index[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h9A9A9A9A9A9A9A00)) 
    \r_Bit_Index[1]_i_1 
       (.I0(\r_Bit_Index_reg_n_0_[1] ),
        .I1(\r_RX_Byte[7]_i_2_n_0 ),
        .I2(\r_Bit_Index_reg_n_0_[0] ),
        .I3(\r_SM_Main_reg_n_0_[2] ),
        .I4(\r_SM_Main_reg_n_0_[1] ),
        .I5(\r_SM_Main_reg_n_0_[0] ),
        .O(\r_Bit_Index[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h9AAA00009AAA9AAA)) 
    \r_Bit_Index[2]_i_1 
       (.I0(\r_Bit_Index_reg_n_0_[2] ),
        .I1(\r_RX_Byte[7]_i_2_n_0 ),
        .I2(\r_Bit_Index_reg_n_0_[0] ),
        .I3(\r_Bit_Index_reg_n_0_[1] ),
        .I4(\r_SM_Main_reg_n_0_[2] ),
        .I5(\r_Bit_Index[2]_i_2_n_0 ),
        .O(\r_Bit_Index[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \r_Bit_Index[2]_i_2 
       (.I0(\r_SM_Main_reg_n_0_[1] ),
        .I1(\r_SM_Main_reg_n_0_[0] ),
        .O(\r_Bit_Index[2]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \r_Bit_Index_reg[0] 
       (.C(i_Clk),
        .CE(1'b1),
        .D(\r_Bit_Index[0]_i_1_n_0 ),
        .Q(\r_Bit_Index_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_Bit_Index_reg[1] 
       (.C(i_Clk),
        .CE(1'b1),
        .D(\r_Bit_Index[1]_i_1_n_0 ),
        .Q(\r_Bit_Index_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_Bit_Index_reg[2] 
       (.C(i_Clk),
        .CE(1'b1),
        .D(\r_Bit_Index[2]_i_1_n_0 ),
        .Q(\r_Bit_Index_reg_n_0_[2] ),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hCFCC1011)) 
    \r_Clk_Count[0]_i_1 
       (.I0(\r_Clk_Count[8]_i_4_n_0 ),
        .I1(\r_SM_Main_reg_n_0_[2] ),
        .I2(\r_Clk_Count[6]_i_2_n_0 ),
        .I3(\r_SM_Main_reg_n_0_[0] ),
        .I4(\r_Clk_Count_reg_n_0_[0] ),
        .O(\r_Clk_Count[0]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \r_Clk_Count[1]_i_1 
       (.I0(\r_Clk_Count_reg_n_0_[1] ),
        .I1(\r_Clk_Count_reg_n_0_[0] ),
        .O(\r_Clk_Count[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h1555FFFF40550000)) 
    \r_Clk_Count[2]_i_1 
       (.I0(\r_Clk_Count[8]_i_4_n_0 ),
        .I1(\r_Clk_Count_reg_n_0_[0] ),
        .I2(\r_Clk_Count_reg_n_0_[1] ),
        .I3(\r_Clk_Count[6]_i_2_n_0 ),
        .I4(\r_Clk_Count[8]_i_2_n_0 ),
        .I5(\r_Clk_Count_reg_n_0_[2] ),
        .O(\r_Clk_Count[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h7FFFD555)) 
    \r_Clk_Count[3]_i_1 
       (.I0(\r_Clk_Count[6]_i_2_n_0 ),
        .I1(\r_Clk_Count_reg_n_0_[2] ),
        .I2(\r_Clk_Count_reg_n_0_[0] ),
        .I3(\r_Clk_Count_reg_n_0_[1] ),
        .I4(\r_Clk_Count_reg_n_0_[3] ),
        .O(\r_Clk_Count[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \r_Clk_Count[4]_i_1 
       (.I0(\r_Clk_Count_reg_n_0_[4] ),
        .I1(\r_Clk_Count_reg_n_0_[3] ),
        .I2(\r_Clk_Count_reg_n_0_[2] ),
        .I3(\r_Clk_Count_reg_n_0_[0] ),
        .I4(\r_Clk_Count_reg_n_0_[1] ),
        .O(\r_Clk_Count[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \r_Clk_Count[5]_i_1 
       (.I0(\r_Clk_Count_reg_n_0_[5] ),
        .I1(\r_Clk_Count_reg_n_0_[4] ),
        .I2(\r_Clk_Count_reg_n_0_[1] ),
        .I3(\r_Clk_Count_reg_n_0_[0] ),
        .I4(\r_Clk_Count_reg_n_0_[2] ),
        .I5(\r_Clk_Count_reg_n_0_[3] ),
        .O(\r_Clk_Count[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF708FFFF)) 
    \r_Clk_Count[6]_i_1 
       (.I0(\r_Clk_Count_reg_n_0_[5] ),
        .I1(\r_Clk_Count_reg_n_0_[4] ),
        .I2(\r_Clk_Count[8]_i_5_n_0 ),
        .I3(\r_Clk_Count_reg_n_0_[6] ),
        .I4(\r_Clk_Count[6]_i_2_n_0 ),
        .O(\r_Clk_Count[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \r_Clk_Count[6]_i_2 
       (.I0(\r_SM_Main[1]_i_2_n_0 ),
        .I1(i_RX_Serial),
        .O(\r_Clk_Count[6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h9AAAAAAA)) 
    \r_Clk_Count[7]_i_1 
       (.I0(\r_Clk_Count_reg_n_0_[7] ),
        .I1(\r_Clk_Count[8]_i_5_n_0 ),
        .I2(\r_Clk_Count_reg_n_0_[4] ),
        .I3(\r_Clk_Count_reg_n_0_[5] ),
        .I4(\r_Clk_Count_reg_n_0_[6] ),
        .O(\r_Clk_Count[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h30301033)) 
    \r_Clk_Count[8]_i_1 
       (.I0(\r_SM_Main_reg_n_0_[0] ),
        .I1(\r_SM_Main_reg_n_0_[2] ),
        .I2(\r_Clk_Count[8]_i_4_n_0 ),
        .I3(i_RX_Serial),
        .I4(\r_SM_Main[1]_i_2_n_0 ),
        .O(\r_Clk_Count[8]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h4555)) 
    \r_Clk_Count[8]_i_2 
       (.I0(\r_SM_Main_reg_n_0_[2] ),
        .I1(\r_SM_Main[1]_i_2_n_0 ),
        .I2(i_RX_Serial),
        .I3(\r_SM_Main_reg_n_0_[0] ),
        .O(\r_Clk_Count[8]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAA6AAAAAAA)) 
    \r_Clk_Count[8]_i_3 
       (.I0(\r_Clk_Count_reg_n_0_[8] ),
        .I1(\r_Clk_Count_reg_n_0_[7] ),
        .I2(\r_Clk_Count_reg_n_0_[6] ),
        .I3(\r_Clk_Count_reg_n_0_[5] ),
        .I4(\r_Clk_Count_reg_n_0_[4] ),
        .I5(\r_Clk_Count[8]_i_5_n_0 ),
        .O(\r_Clk_Count[8]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h35)) 
    \r_Clk_Count[8]_i_4 
       (.I0(\r_SM_Main_reg_n_0_[0] ),
        .I1(r_RX_DV_i_2_n_0),
        .I2(\r_SM_Main_reg_n_0_[1] ),
        .O(\r_Clk_Count[8]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h7FFF)) 
    \r_Clk_Count[8]_i_5 
       (.I0(\r_Clk_Count_reg_n_0_[1] ),
        .I1(\r_Clk_Count_reg_n_0_[0] ),
        .I2(\r_Clk_Count_reg_n_0_[2] ),
        .I3(\r_Clk_Count_reg_n_0_[3] ),
        .O(\r_Clk_Count[8]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFF0B00000004)) 
    \r_Clk_Count[9]_i_1 
       (.I0(\r_Clk_Count[9]_i_2_n_0 ),
        .I1(\r_Clk_Count_reg_n_0_[8] ),
        .I2(\r_Clk_Count[9]_i_3_n_0 ),
        .I3(\r_SM_Main_reg_n_0_[2] ),
        .I4(\r_Clk_Count[9]_i_4_n_0 ),
        .I5(\r_Clk_Count_reg_n_0_[9] ),
        .O(\r_Clk_Count[9]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hBFFFFFFF)) 
    \r_Clk_Count[9]_i_2 
       (.I0(\r_Clk_Count[8]_i_5_n_0 ),
        .I1(\r_Clk_Count_reg_n_0_[4] ),
        .I2(\r_Clk_Count_reg_n_0_[5] ),
        .I3(\r_Clk_Count_reg_n_0_[6] ),
        .I4(\r_Clk_Count_reg_n_0_[7] ),
        .O(\r_Clk_Count[9]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h57F7)) 
    \r_Clk_Count[9]_i_3 
       (.I0(\r_SM_Main[1]_i_2_n_0 ),
        .I1(\r_SM_Main_reg_n_0_[0] ),
        .I2(\r_SM_Main_reg_n_0_[1] ),
        .I3(r_RX_DV_i_2_n_0),
        .O(\r_Clk_Count[9]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \r_Clk_Count[9]_i_4 
       (.I0(\r_SM_Main_reg_n_0_[0] ),
        .I1(i_RX_Serial),
        .I2(\r_SM_Main[1]_i_2_n_0 ),
        .O(\r_Clk_Count[9]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \r_Clk_Count_reg[0] 
       (.C(i_Clk),
        .CE(1'b1),
        .D(\r_Clk_Count[0]_i_1_n_0 ),
        .Q(\r_Clk_Count_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_Clk_Count_reg[1] 
       (.C(i_Clk),
        .CE(\r_Clk_Count[8]_i_2_n_0 ),
        .D(\r_Clk_Count[1]_i_1_n_0 ),
        .Q(\r_Clk_Count_reg_n_0_[1] ),
        .R(\r_Clk_Count[8]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \r_Clk_Count_reg[2] 
       (.C(i_Clk),
        .CE(1'b1),
        .D(\r_Clk_Count[2]_i_1_n_0 ),
        .Q(\r_Clk_Count_reg_n_0_[2] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_Clk_Count_reg[3] 
       (.C(i_Clk),
        .CE(\r_Clk_Count[8]_i_2_n_0 ),
        .D(\r_Clk_Count[3]_i_1_n_0 ),
        .Q(\r_Clk_Count_reg_n_0_[3] ),
        .R(\r_Clk_Count[8]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \r_Clk_Count_reg[4] 
       (.C(i_Clk),
        .CE(\r_Clk_Count[8]_i_2_n_0 ),
        .D(\r_Clk_Count[4]_i_1_n_0 ),
        .Q(\r_Clk_Count_reg_n_0_[4] ),
        .R(\r_Clk_Count[8]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \r_Clk_Count_reg[5] 
       (.C(i_Clk),
        .CE(\r_Clk_Count[8]_i_2_n_0 ),
        .D(\r_Clk_Count[5]_i_1_n_0 ),
        .Q(\r_Clk_Count_reg_n_0_[5] ),
        .R(\r_Clk_Count[8]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \r_Clk_Count_reg[6] 
       (.C(i_Clk),
        .CE(\r_Clk_Count[8]_i_2_n_0 ),
        .D(\r_Clk_Count[6]_i_1_n_0 ),
        .Q(\r_Clk_Count_reg_n_0_[6] ),
        .R(\r_Clk_Count[8]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \r_Clk_Count_reg[7] 
       (.C(i_Clk),
        .CE(\r_Clk_Count[8]_i_2_n_0 ),
        .D(\r_Clk_Count[7]_i_1_n_0 ),
        .Q(\r_Clk_Count_reg_n_0_[7] ),
        .R(\r_Clk_Count[8]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \r_Clk_Count_reg[8] 
       (.C(i_Clk),
        .CE(\r_Clk_Count[8]_i_2_n_0 ),
        .D(\r_Clk_Count[8]_i_3_n_0 ),
        .Q(\r_Clk_Count_reg_n_0_[8] ),
        .R(\r_Clk_Count[8]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \r_Clk_Count_reg[9] 
       (.C(i_Clk),
        .CE(1'b1),
        .D(\r_Clk_Count[9]_i_1_n_0 ),
        .Q(\r_Clk_Count_reg_n_0_[9] ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \r_RX_Byte[0]_i_1 
       (.I0(i_RX_Serial),
        .I1(\r_Bit_Index_reg_n_0_[1] ),
        .I2(\r_Bit_Index_reg_n_0_[0] ),
        .I3(\r_RX_Byte[7]_i_2_n_0 ),
        .I4(\r_Bit_Index_reg_n_0_[2] ),
        .I5(o_RX_Byte[0]),
        .O(\r_RX_Byte[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFEF00000020)) 
    \r_RX_Byte[1]_i_1 
       (.I0(i_RX_Serial),
        .I1(\r_Bit_Index_reg_n_0_[1] ),
        .I2(\r_Bit_Index_reg_n_0_[0] ),
        .I3(\r_RX_Byte[7]_i_2_n_0 ),
        .I4(\r_Bit_Index_reg_n_0_[2] ),
        .I5(o_RX_Byte[1]),
        .O(\r_RX_Byte[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFEF00000020)) 
    \r_RX_Byte[2]_i_1 
       (.I0(i_RX_Serial),
        .I1(\r_Bit_Index_reg_n_0_[0] ),
        .I2(\r_Bit_Index_reg_n_0_[1] ),
        .I3(\r_RX_Byte[7]_i_2_n_0 ),
        .I4(\r_Bit_Index_reg_n_0_[2] ),
        .I5(o_RX_Byte[2]),
        .O(\r_RX_Byte[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFBF00000080)) 
    \r_RX_Byte[3]_i_1 
       (.I0(i_RX_Serial),
        .I1(\r_Bit_Index_reg_n_0_[1] ),
        .I2(\r_Bit_Index_reg_n_0_[0] ),
        .I3(\r_RX_Byte[7]_i_2_n_0 ),
        .I4(\r_Bit_Index_reg_n_0_[2] ),
        .I5(o_RX_Byte[3]),
        .O(\r_RX_Byte[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFEFF00000200)) 
    \r_RX_Byte[4]_i_1 
       (.I0(i_RX_Serial),
        .I1(\r_Bit_Index_reg_n_0_[1] ),
        .I2(\r_Bit_Index_reg_n_0_[0] ),
        .I3(\r_Bit_Index_reg_n_0_[2] ),
        .I4(\r_RX_Byte[7]_i_2_n_0 ),
        .I5(o_RX_Byte[4]),
        .O(\r_RX_Byte[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFEFFF00002000)) 
    \r_RX_Byte[5]_i_1 
       (.I0(i_RX_Serial),
        .I1(\r_Bit_Index_reg_n_0_[1] ),
        .I2(\r_Bit_Index_reg_n_0_[0] ),
        .I3(\r_Bit_Index_reg_n_0_[2] ),
        .I4(\r_RX_Byte[7]_i_2_n_0 ),
        .I5(o_RX_Byte[5]),
        .O(\r_RX_Byte[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFEFFF00002000)) 
    \r_RX_Byte[6]_i_1 
       (.I0(i_RX_Serial),
        .I1(\r_Bit_Index_reg_n_0_[0] ),
        .I2(\r_Bit_Index_reg_n_0_[1] ),
        .I3(\r_Bit_Index_reg_n_0_[2] ),
        .I4(\r_RX_Byte[7]_i_2_n_0 ),
        .I5(o_RX_Byte[6]),
        .O(\r_RX_Byte[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hEFFFFFFF20000000)) 
    \r_RX_Byte[7]_i_1 
       (.I0(i_RX_Serial),
        .I1(\r_RX_Byte[7]_i_2_n_0 ),
        .I2(\r_Bit_Index_reg_n_0_[2] ),
        .I3(\r_Bit_Index_reg_n_0_[0] ),
        .I4(\r_Bit_Index_reg_n_0_[1] ),
        .I5(o_RX_Byte[7]),
        .O(\r_RX_Byte[7]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFEFF)) 
    \r_RX_Byte[7]_i_2 
       (.I0(\r_SM_Main_reg_n_0_[2] ),
        .I1(\r_SM_Main_reg_n_0_[0] ),
        .I2(r_RX_DV_i_2_n_0),
        .I3(\r_SM_Main_reg_n_0_[1] ),
        .O(\r_RX_Byte[7]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \r_RX_Byte_reg[0] 
       (.C(i_Clk),
        .CE(1'b1),
        .D(\r_RX_Byte[0]_i_1_n_0 ),
        .Q(o_RX_Byte[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_RX_Byte_reg[1] 
       (.C(i_Clk),
        .CE(1'b1),
        .D(\r_RX_Byte[1]_i_1_n_0 ),
        .Q(o_RX_Byte[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_RX_Byte_reg[2] 
       (.C(i_Clk),
        .CE(1'b1),
        .D(\r_RX_Byte[2]_i_1_n_0 ),
        .Q(o_RX_Byte[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_RX_Byte_reg[3] 
       (.C(i_Clk),
        .CE(1'b1),
        .D(\r_RX_Byte[3]_i_1_n_0 ),
        .Q(o_RX_Byte[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_RX_Byte_reg[4] 
       (.C(i_Clk),
        .CE(1'b1),
        .D(\r_RX_Byte[4]_i_1_n_0 ),
        .Q(o_RX_Byte[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_RX_Byte_reg[5] 
       (.C(i_Clk),
        .CE(1'b1),
        .D(\r_RX_Byte[5]_i_1_n_0 ),
        .Q(o_RX_Byte[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_RX_Byte_reg[6] 
       (.C(i_Clk),
        .CE(1'b1),
        .D(\r_RX_Byte[6]_i_1_n_0 ),
        .Q(o_RX_Byte[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_RX_Byte_reg[7] 
       (.C(i_Clk),
        .CE(1'b1),
        .D(\r_RX_Byte[7]_i_1_n_0 ),
        .Q(o_RX_Byte[7]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'hFCFC0040)) 
    r_RX_DV_i_1
       (.I0(r_RX_DV_i_2_n_0),
        .I1(\r_SM_Main_reg_n_0_[1] ),
        .I2(\r_SM_Main_reg_n_0_[0] ),
        .I3(\r_SM_Main_reg_n_0_[2] ),
        .I4(o_RX_DV),
        .O(r_RX_DV_i_1_n_0));
  LUT6 #(
    .INIT(64'h777777777FFFFFFF)) 
    r_RX_DV_i_2
       (.I0(\r_Clk_Count_reg_n_0_[9] ),
        .I1(\r_Clk_Count_reg_n_0_[8] ),
        .I2(r_RX_DV_i_3_n_0),
        .I3(\r_Clk_Count_reg_n_0_[6] ),
        .I4(\r_Clk_Count_reg_n_0_[5] ),
        .I5(\r_Clk_Count_reg_n_0_[7] ),
        .O(r_RX_DV_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'hFFFFFFF8)) 
    r_RX_DV_i_3
       (.I0(\r_Clk_Count_reg_n_0_[1] ),
        .I1(\r_Clk_Count_reg_n_0_[0] ),
        .I2(\r_Clk_Count_reg_n_0_[2] ),
        .I3(\r_Clk_Count_reg_n_0_[3] ),
        .I4(\r_Clk_Count_reg_n_0_[4] ),
        .O(r_RX_DV_i_3_n_0));
  FDRE #(
    .INIT(1'b0)) 
    r_RX_DV_reg
       (.C(i_Clk),
        .CE(1'b1),
        .D(r_RX_DV_i_1_n_0),
        .Q(o_RX_DV),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0000440555555555)) 
    \r_SM_Main[0]_i_1 
       (.I0(\r_SM_Main_reg_n_0_[2] ),
        .I1(\r_SM_Main[0]_i_2_n_0 ),
        .I2(i_RX_Serial),
        .I3(\r_SM_Main_reg_n_0_[0] ),
        .I4(\r_SM_Main_reg_n_0_[1] ),
        .I5(\r_SM_Main[0]_i_3_n_0 ),
        .O(\r_SM_Main[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFB)) 
    \r_SM_Main[0]_i_2 
       (.I0(\r_Clk_Count_reg_n_0_[1] ),
        .I1(\r_Clk_Count_reg_n_0_[7] ),
        .I2(\r_Clk_Count_reg_n_0_[2] ),
        .I3(\r_Clk_Count_reg_n_0_[6] ),
        .I4(\r_SM_Main[1]_i_3_n_0 ),
        .O(\r_SM_Main[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h77777777DFFFFFFF)) 
    \r_SM_Main[0]_i_3 
       (.I0(\r_SM_Main_reg_n_0_[1] ),
        .I1(r_RX_DV_i_2_n_0),
        .I2(\r_Bit_Index_reg_n_0_[2] ),
        .I3(\r_Bit_Index_reg_n_0_[0] ),
        .I4(\r_Bit_Index_reg_n_0_[1] ),
        .I5(\r_SM_Main_reg_n_0_[0] ),
        .O(\r_SM_Main[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h5555111500040004)) 
    \r_SM_Main[1]_i_1 
       (.I0(\r_SM_Main_reg_n_0_[2] ),
        .I1(\r_SM_Main_reg_n_0_[0] ),
        .I2(\r_SM_Main[1]_i_2_n_0 ),
        .I3(i_RX_Serial),
        .I4(r_RX_DV_i_2_n_0),
        .I5(\r_SM_Main_reg_n_0_[1] ),
        .O(\r_SM_Main[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFEFFFF)) 
    \r_SM_Main[1]_i_2 
       (.I0(\r_SM_Main_reg_n_0_[1] ),
        .I1(\r_SM_Main[1]_i_3_n_0 ),
        .I2(\r_Clk_Count_reg_n_0_[6] ),
        .I3(\r_Clk_Count_reg_n_0_[2] ),
        .I4(\r_Clk_Count_reg_n_0_[7] ),
        .I5(\r_Clk_Count_reg_n_0_[1] ),
        .O(\r_SM_Main[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFF7FFFFFFFFFFFF)) 
    \r_SM_Main[1]_i_3 
       (.I0(\r_Clk_Count_reg_n_0_[5] ),
        .I1(\r_Clk_Count_reg_n_0_[4] ),
        .I2(\r_Clk_Count_reg_n_0_[3] ),
        .I3(\r_Clk_Count_reg_n_0_[9] ),
        .I4(\r_Clk_Count_reg_n_0_[0] ),
        .I5(\r_Clk_Count_reg_n_0_[8] ),
        .O(\r_SM_Main[1]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h0400)) 
    \r_SM_Main[2]_i_1 
       (.I0(r_RX_DV_i_2_n_0),
        .I1(\r_SM_Main_reg_n_0_[1] ),
        .I2(\r_SM_Main_reg_n_0_[2] ),
        .I3(\r_SM_Main_reg_n_0_[0] ),
        .O(\r_SM_Main[2]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \r_SM_Main_reg[0] 
       (.C(i_Clk),
        .CE(1'b1),
        .D(\r_SM_Main[0]_i_1_n_0 ),
        .Q(\r_SM_Main_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_SM_Main_reg[1] 
       (.C(i_Clk),
        .CE(1'b1),
        .D(\r_SM_Main[1]_i_1_n_0 ),
        .Q(\r_SM_Main_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_SM_Main_reg[2] 
       (.C(i_Clk),
        .CE(1'b1),
        .D(\r_SM_Main[2]_i_1_n_0 ),
        .Q(\r_SM_Main_reg_n_0_[2] ),
        .R(1'b0));
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
