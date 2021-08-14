//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
//Date        : Fri Aug 13 16:53:19 2021
//Host        : DESKTOP-ID021MN running 64-bit major release  (build 9200)
//Command     : generate_target fpu_design.bd
//Design      : fpu_design
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "fpu_design,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=fpu_design,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=5,numReposBlks=5,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,da_clkrst_cnt=1,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "fpu_design.hwdef" *) 
module fpu_design
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
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_IN100 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_IN100, CLK_DOMAIN fpu_design_clk_in100, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input clk_in100;
  output [4:0]data_count_0;
  output [0:0]error;
  input [2:0]fpu_op_i;
  input [63:0]opa_i;
  input [63:0]opb_i;
  input rd_en;
  output [0:0]ready_o;
  output [63:0]result_o;
  input [1:0]rmode_i;
  input start_i;

  wire clk_in100_1;
  wire [63:0]fifo_generator_0_dout;
  wire fifo_generator_0_empty;
  wire [4:0]fifo_generator_0_rd_data_count;
  wire fpu_double_0_exception;
  wire fpu_double_0_invalid;
  wire [63:0]fpu_double_0_out_fp;
  wire fpu_double_0_ready;
  wire [2:0]fpu_op_i_1;
  wire [63:0]opa_0_1;
  wire [63:0]opb_0_1;
  wire rd_en_0_1;
  wire [1:0]rmode_i_1;
  wire start_i_1;
  wire [0:0]util_vector_logic_0_Res;
  wire [0:0]util_vector_logic_1_Res;
  wire [0:0]xlconstant_0_dout;

  assign clk_in100_1 = clk_in100;
  assign data_count_0[4:0] = fifo_generator_0_rd_data_count;
  assign error[0] = util_vector_logic_1_Res;
  assign fpu_op_i_1 = fpu_op_i[2:0];
  assign opa_0_1 = opa_i[63:0];
  assign opb_0_1 = opb_i[63:0];
  assign rd_en_0_1 = rd_en;
  assign ready_o[0] = util_vector_logic_0_Res;
  assign result_o[63:0] = fifo_generator_0_dout;
  assign rmode_i_1 = rmode_i[1:0];
  assign start_i_1 = start_i;
  fpu_design_fifo_generator_0_0 fifo_generator_0
       (.din(fpu_double_0_out_fp),
        .dout(fifo_generator_0_dout),
        .empty(fifo_generator_0_empty),
        .rd_clk(clk_in100_1),
        .rd_data_count(fifo_generator_0_rd_data_count),
        .rd_en(rd_en_0_1),
        .wr_clk(clk_in100_1),
        .wr_en(fpu_double_0_ready));
  fpu_design_fpu_double_0_0 fpu_double_0
       (.clk(clk_in100_1),
        .enable(start_i_1),
        .exception(fpu_double_0_exception),
        .fpu_op(fpu_op_i_1),
        .invalid(fpu_double_0_invalid),
        .opa(opa_0_1),
        .opb(opb_0_1),
        .out_fp(fpu_double_0_out_fp),
        .ready(fpu_double_0_ready),
        .rmode(rmode_i_1),
        .rst(xlconstant_0_dout));
  fpu_design_util_vector_logic_0_1 util_vector_logic_0
       (.Op1(fifo_generator_0_empty),
        .Res(util_vector_logic_0_Res));
  fpu_design_util_vector_logic_1_0 util_vector_logic_1
       (.Op1(fpu_double_0_exception),
        .Op2(fpu_double_0_invalid),
        .Res(util_vector_logic_1_Res));
  fpu_design_xlconstant_0_0 xlconstant_0
       (.dout(xlconstant_0_dout));
endmodule
