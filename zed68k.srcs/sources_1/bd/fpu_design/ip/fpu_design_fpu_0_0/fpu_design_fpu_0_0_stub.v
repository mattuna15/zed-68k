// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Sat Jul 24 18:48:52 2021
// Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/code/zed-68k/zed68k.srcs/sources_1/bd/fpu_design/ip/fpu_design_fpu_0_0/fpu_design_fpu_0_0_stub.v
// Design      : fpu_design_fpu_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "fpu,Vivado 2020.1" *)
module fpu_design_fpu_0_0(clk_i, opa_i, opb_i, fpu_op_i, rmode_i, output_o, 
  start_i, ready_o, ine_o, overflow_o, underflow_o, div_zero_o, inf_o, zero_o, qnan_o, snan_o)
/* synthesis syn_black_box black_box_pad_pin="clk_i,opa_i[31:0],opb_i[31:0],fpu_op_i[2:0],rmode_i[1:0],output_o[31:0],start_i,ready_o,ine_o,overflow_o,underflow_o,div_zero_o,inf_o,zero_o,qnan_o,snan_o" */;
  input clk_i;
  input [31:0]opa_i;
  input [31:0]opb_i;
  input [2:0]fpu_op_i;
  input [1:0]rmode_i;
  output [31:0]output_o;
  input start_i;
  output ready_o;
  output ine_o;
  output overflow_o;
  output underflow_o;
  output div_zero_o;
  output inf_o;
  output zero_o;
  output qnan_o;
  output snan_o;
endmodule
