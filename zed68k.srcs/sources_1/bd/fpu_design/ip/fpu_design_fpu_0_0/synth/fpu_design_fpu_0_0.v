// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:fpu:1.0
// IP Revision: 1

(* X_CORE_INFO = "fpu,Vivado 2020.1" *)
(* CHECK_LICENSE_TYPE = "fpu_design_fpu_0_0,fpu,{}" *)
(* CORE_GENERATION_INFO = "fpu_design_fpu_0_0,fpu,{x_ipProduct=Vivado 2020.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=fpu,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module fpu_design_fpu_0_0 (
  clk_i,
  opa_i,
  opb_i,
  fpu_op_i,
  rmode_i,
  output_o,
  start_i,
  ready_o,
  ine_o,
  overflow_o,
  underflow_o,
  div_zero_o,
  inf_o,
  zero_o,
  qnan_o,
  snan_o
);

input wire clk_i;
input wire [31 : 0] opa_i;
input wire [31 : 0] opb_i;
input wire [2 : 0] fpu_op_i;
input wire [1 : 0] rmode_i;
output wire [31 : 0] output_o;
input wire start_i;
output wire ready_o;
output wire ine_o;
output wire overflow_o;
output wire underflow_o;
output wire div_zero_o;
output wire inf_o;
output wire zero_o;
output wire qnan_o;
output wire snan_o;

  fpu inst (
    .clk_i(clk_i),
    .opa_i(opa_i),
    .opb_i(opb_i),
    .fpu_op_i(fpu_op_i),
    .rmode_i(rmode_i),
    .output_o(output_o),
    .start_i(start_i),
    .ready_o(ready_o),
    .ine_o(ine_o),
    .overflow_o(overflow_o),
    .underflow_o(underflow_o),
    .div_zero_o(div_zero_o),
    .inf_o(inf_o),
    .zero_o(zero_o),
    .qnan_o(qnan_o),
    .snan_o(snan_o)
  );
endmodule
