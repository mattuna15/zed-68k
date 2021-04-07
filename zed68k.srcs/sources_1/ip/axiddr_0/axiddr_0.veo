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

// IP VLNV: mattpearce:user:axiddr:1.0
// IP Revision: 10

// The following must be inserted into your Verilog file for this
// core to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
axiddr_0 your_instance_name (
  .address(address),                          // input wire [27 : 0] address
  .wr_data(wr_data),                          // input wire [15 : 0] wr_data
  .wr_byte_mask(wr_byte_mask),                // input wire [1 : 0] wr_byte_mask
  .i_cen(i_cen),                              // input wire i_cen
  .i_wren(i_wren),                            // input wire i_wren
  .i_valid_p(i_valid_p),                      // input wire i_valid_p
  .rd_data(rd_data),                          // output wire [15 : 0] rd_data
  .o_ready_p(o_ready_p),                      // output wire o_ready_p
  .wr_ack_p(wr_ack_p),                        // output wire wr_ack_p
  .o_valid_p(o_valid_p),                      // output wire o_valid_p
  .ddr3_sdram_addr(ddr3_sdram_addr),          // output wire [13 : 0] ddr3_sdram_addr
  .ddr3_sdram_ba(ddr3_sdram_ba),              // output wire [2 : 0] ddr3_sdram_ba
  .ddr3_sdram_cas_n(ddr3_sdram_cas_n),        // output wire ddr3_sdram_cas_n
  .ddr3_sdram_ck_n(ddr3_sdram_ck_n),          // output wire [0 : 0] ddr3_sdram_ck_n
  .ddr3_sdram_ck_p(ddr3_sdram_ck_p),          // output wire [0 : 0] ddr3_sdram_ck_p
  .ddr3_sdram_cke(ddr3_sdram_cke),            // output wire [0 : 0] ddr3_sdram_cke
  .ddr3_sdram_cs_n(ddr3_sdram_cs_n),          // output wire [0 : 0] ddr3_sdram_cs_n
  .ddr3_sdram_dm(ddr3_sdram_dm),              // output wire [1 : 0] ddr3_sdram_dm
  .ddr3_sdram_dq(ddr3_sdram_dq),              // inout wire [15 : 0] ddr3_sdram_dq
  .ddr3_sdram_dqs_n(ddr3_sdram_dqs_n),        // inout wire [1 : 0] ddr3_sdram_dqs_n
  .ddr3_sdram_dqs_p(ddr3_sdram_dqs_p),        // inout wire [1 : 0] ddr3_sdram_dqs_p
  .ddr3_sdram_odt(ddr3_sdram_odt),            // output wire [0 : 0] ddr3_sdram_odt
  .ddr3_sdram_ras_n(ddr3_sdram_ras_n),        // output wire ddr3_sdram_ras_n
  .ddr3_sdram_reset_n(ddr3_sdram_reset_n),    // output wire ddr3_sdram_reset_n
  .ddr3_sdram_we_n(ddr3_sdram_we_n),          // output wire ddr3_sdram_we_n
  .sys_resetn(sys_resetn),                    // input wire sys_resetn
  .sys_clock(sys_clock),                      // input wire sys_clock
  .clock166(clock166),                        // input wire clock166
  .clock200(clock200),                        // input wire clock200
  .init_calib_complete(init_calib_complete)  // output wire init_calib_complete
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

