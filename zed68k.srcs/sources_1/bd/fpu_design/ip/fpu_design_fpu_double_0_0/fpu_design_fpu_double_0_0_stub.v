// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Fri Aug 13 16:55:38 2021
// Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/code/zed-68k/zed68k.srcs/sources_1/bd/fpu_design/ip/fpu_design_fpu_double_0_0/fpu_design_fpu_double_0_0_stub.v
// Design      : fpu_design_fpu_double_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "fpu_double,Vivado 2020.1" *)
module fpu_design_fpu_double_0_0(clk, rst, enable, rmode, fpu_op, opa, opb, out_fp, ready, 
  underflow, overflow, inexact, exception, invalid)
/* synthesis syn_black_box black_box_pad_pin="clk,rst,enable,rmode[1:0],fpu_op[2:0],opa[63:0],opb[63:0],out_fp[63:0],ready,underflow,overflow,inexact,exception,invalid" */;
  input clk;
  input rst;
  input enable;
  input [1:0]rmode;
  input [2:0]fpu_op;
  input [63:0]opa;
  input [63:0]opb;
  output [63:0]out_fp;
  output ready;
  output underflow;
  output overflow;
  output inexact;
  output exception;
  output invalid;
endmodule
