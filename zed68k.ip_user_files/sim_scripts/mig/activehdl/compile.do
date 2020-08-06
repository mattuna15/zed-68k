vlib work
vlib activehdl

vlib activehdl/xpm
vlib activehdl/xil_defaultlib

vmap xpm activehdl/xpm
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xpm  -sv2k12 \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/clocking/mig_7series_v4_2_clk_ibuf.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/clocking/mig_7series_v4_2_infrastructure.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/clocking/mig_7series_v4_2_iodelay_ctrl.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/clocking/mig_7series_v4_2_tempmon.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/controller/mig_7series_v4_2_arb_mux.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/controller/mig_7series_v4_2_arb_row_col.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/controller/mig_7series_v4_2_arb_select.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/controller/mig_7series_v4_2_bank_cntrl.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/controller/mig_7series_v4_2_bank_common.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/controller/mig_7series_v4_2_bank_compare.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/controller/mig_7series_v4_2_bank_mach.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/controller/mig_7series_v4_2_bank_queue.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/controller/mig_7series_v4_2_bank_state.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/controller/mig_7series_v4_2_col_mach.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/controller/mig_7series_v4_2_mc.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/controller/mig_7series_v4_2_rank_cntrl.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/controller/mig_7series_v4_2_rank_common.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/controller/mig_7series_v4_2_rank_mach.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/controller/mig_7series_v4_2_round_robin_arb.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/ecc/mig_7series_v4_2_ecc_buf.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/ecc/mig_7series_v4_2_ecc_dec_fix.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/ecc/mig_7series_v4_2_ecc_gen.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/ecc/mig_7series_v4_2_ecc_merge_enc.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/ecc/mig_7series_v4_2_fi_xor.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/ip_top/mig_7series_v4_2_memc_ui_top_std.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/ip_top/mig_7series_v4_2_mem_intfc.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_byte_group_io.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_byte_lane.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_calib_top.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_if_post_fifo.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_mc_phy.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_mc_phy_wrapper.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_of_pre_fifo.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_4lanes.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ck_addr_cmd_delay.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_dqs_found_cal.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_dqs_found_cal_hr.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_init.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_cntlr.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_data.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_edge.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_lim.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_mux.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_po_cntlr.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_samp.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_oclkdelay_cal.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_prbs_rdlvl.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_rdlvl.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_tempmon.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_wrcal.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_wrlvl.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_wrlvl_off_delay.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_prbs_gen.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_poc_cc.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_poc_edge_store.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_poc_meta.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_poc_pd.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_poc_tap_base.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_poc_top.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/ui/mig_7series_v4_2_ui_cmd.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/ui/mig_7series_v4_2_ui_rd_data.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/ui/mig_7series_v4_2_ui_top.v" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/ui/mig_7series_v4_2_ui_wr_data.v" \

vcom -work xil_defaultlib -93 \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_top.vhd" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/mig_mig_sim.vhd" \
"../../../../../memory/mig_example.srcs/sources_1/ip/mig/mig/user_design/rtl/mig.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

