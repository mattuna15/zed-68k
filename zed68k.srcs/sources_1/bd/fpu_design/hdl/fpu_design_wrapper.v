//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
//Date        : Mon Jul 26 16:27:26 2021
//Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
//Command     : generate_target fpu_design_wrapper.bd
//Design      : fpu_design_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module fpu_design_wrapper
   (clk_in100,
    data_count_0,
    error,
    fpu_op_i,
    opa_i,
    opb_i,
    rd_en,
    ready_o,
    result_o,
    rmode_i,
    start_i);
  input clk_in100;
  output [4:0]data_count_0;
  output error;
  input [2:0]fpu_op_i;
  input [31:0]opa_i;
  input [31:0]opb_i;
  input rd_en;
  output [0:0]ready_o;
  output [31:0]result_o;
  input [1:0]rmode_i;
  input start_i;

  wire clk_in100;
  wire [4:0]data_count_0;
  wire error;
  wire [2:0]fpu_op_i;
  wire [31:0]opa_i;
  wire [31:0]opb_i;
  wire rd_en;
  wire [0:0]ready_o;
  wire [31:0]result_o;
  wire [1:0]rmode_i;
  wire start_i;

  fpu_design fpu_design_i
       (.clk_in100(clk_in100),
        .data_count_0(data_count_0),
        .error(error),
        .fpu_op_i(fpu_op_i),
        .opa_i(opa_i),
        .opb_i(opb_i),
        .rd_en(rd_en),
        .ready_o(ready_o),
        .result_o(result_o),
        .rmode_i(rmode_i),
        .start_i(start_i));
endmodule
