//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
//Date        : Mon Jul 26 14:26:11 2021
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
  output error;
  input [2:0]fpu_op_i;
  input [31:0]opa_i;
  input [31:0]opb_i;
  input rd_en;
  output [0:0]ready_o;
  output [31:0]result_o;
  input [1:0]rmode_i;
  input start_i;

  wire clk_wiz_clk_out1;
  wire [4:0]fifo_generator_0_data_count;
  wire [31:0]fifo_generator_0_dout;
  wire fifo_generator_0_empty;
  wire fpu_0_div_zero_o;
  wire fpu_0_inf_o;
  wire [31:0]fpu_0_output_o;
  wire fpu_0_qnan_o;
  wire fpu_0_ready_o;
  wire fpu_0_snan_o;
  wire fpu_0_zero_o;
  wire [2:0]fpu_op_i_0_1;
  wire [31:0]opa_i_0_1;
  wire [31:0]opb_i_0_1;
  wire rd_en_0_1;
  wire [1:0]rmode_i_0_1;
  wire start_i_0_1;
  wire util_reduced_logic_0_Res;
  wire [0:0]util_vector_logic_0_Res;
  wire [4:0]xlconcat_0_dout;

  assign clk_wiz_clk_out1 = clk_in100;
  assign data_count_0[4:0] = fifo_generator_0_data_count;
  assign error = util_reduced_logic_0_Res;
  assign fpu_op_i_0_1 = fpu_op_i[2:0];
  assign opa_i_0_1 = opa_i[31:0];
  assign opb_i_0_1 = opb_i[31:0];
  assign rd_en_0_1 = rd_en;
  assign ready_o[0] = util_vector_logic_0_Res;
  assign result_o[31:0] = fifo_generator_0_dout;
  assign rmode_i_0_1 = rmode_i[1:0];
  assign start_i_0_1 = start_i;
  fpu_design_fifo_generator_0_0 fifo_generator_0
       (.clk(clk_wiz_clk_out1),
        .data_count(fifo_generator_0_data_count),
        .din(fpu_0_output_o),
        .dout(fifo_generator_0_dout),
        .empty(fifo_generator_0_empty),
        .rd_en(rd_en_0_1),
        .wr_en(fpu_0_ready_o));
  fpu_design_fpu_0_0 fpu_0
       (.clk_i(clk_wiz_clk_out1),
        .div_zero_o(fpu_0_div_zero_o),
        .fpu_op_i(fpu_op_i_0_1),
        .inf_o(fpu_0_inf_o),
        .opa_i(opa_i_0_1),
        .opb_i(opb_i_0_1),
        .output_o(fpu_0_output_o),
        .qnan_o(fpu_0_qnan_o),
        .ready_o(fpu_0_ready_o),
        .rmode_i(rmode_i_0_1),
        .snan_o(fpu_0_snan_o),
        .start_i(start_i_0_1),
        .zero_o(fpu_0_zero_o));
  fpu_design_util_reduced_logic_0_0 util_reduced_logic_0
       (.Op1(xlconcat_0_dout),
        .Res(util_reduced_logic_0_Res));
  fpu_design_util_vector_logic_0_0 util_vector_logic_0
       (.Op1(fifo_generator_0_empty),
        .Res(util_vector_logic_0_Res));
  fpu_design_xlconcat_0_0 xlconcat_0
       (.In0(fpu_0_div_zero_o),
        .In1(fpu_0_inf_o),
        .In2(fpu_0_zero_o),
        .In3(fpu_0_qnan_o),
        .In4(fpu_0_snan_o),
        .dout(xlconcat_0_dout));
endmodule
