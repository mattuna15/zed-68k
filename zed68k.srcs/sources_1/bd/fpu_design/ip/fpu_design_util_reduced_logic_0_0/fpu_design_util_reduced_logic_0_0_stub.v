// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Sun Jul 25 07:37:12 2021
// Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/code/zed-68k/zed68k.srcs/sources_1/bd/fpu_design/ip/fpu_design_util_reduced_logic_0_0/fpu_design_util_reduced_logic_0_0_stub.v
// Design      : fpu_design_util_reduced_logic_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "util_reduced_logic_v2_0_4_util_reduced_logic,Vivado 2020.1" *)
module fpu_design_util_reduced_logic_0_0(Op1, Res)
/* synthesis syn_black_box black_box_pad_pin="Op1[4:0],Res" */;
  input [4:0]Op1;
  output Res;
endmodule
