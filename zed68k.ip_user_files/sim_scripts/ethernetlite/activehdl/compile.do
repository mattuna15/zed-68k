vlib work
vlib activehdl

vlib activehdl/xpm
vlib activehdl/axi_lite_ipif_v3_0_4
vlib activehdl/lib_cdc_v1_0_2
vlib activehdl/blk_mem_gen_v8_4_4
vlib activehdl/lib_bmg_v1_0_13
vlib activehdl/fifo_generator_v13_2_5
vlib activehdl/lib_fifo_v1_0_14
vlib activehdl/axi_ethernetlite_v3_0_20
vlib activehdl/xil_defaultlib

vmap xpm activehdl/xpm
vmap axi_lite_ipif_v3_0_4 activehdl/axi_lite_ipif_v3_0_4
vmap lib_cdc_v1_0_2 activehdl/lib_cdc_v1_0_2
vmap blk_mem_gen_v8_4_4 activehdl/blk_mem_gen_v8_4_4
vmap lib_bmg_v1_0_13 activehdl/lib_bmg_v1_0_13
vmap fifo_generator_v13_2_5 activehdl/fifo_generator_v13_2_5
vmap lib_fifo_v1_0_14 activehdl/lib_fifo_v1_0_14
vmap axi_ethernetlite_v3_0_20 activehdl/axi_ethernetlite_v3_0_20
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xpm  -sv2k12 \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work axi_lite_ipif_v3_0_4 -93 \
"../../../../zed68k.srcs/sources_1/bd/ethernetlite/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work lib_cdc_v1_0_2 -93 \
"../../../../zed68k.srcs/sources_1/bd/ethernetlite/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vlog -work blk_mem_gen_v8_4_4  -v2k5 \
"../../../../zed68k.srcs/sources_1/bd/ethernetlite/ipshared/2985/simulation/blk_mem_gen_v8_4.v" \

vcom -work lib_bmg_v1_0_13 -93 \
"../../../../zed68k.srcs/sources_1/bd/ethernetlite/ipshared/af67/hdl/lib_bmg_v1_0_rfs.vhd" \

vlog -work fifo_generator_v13_2_5  -v2k5 \
"../../../../zed68k.srcs/sources_1/bd/ethernetlite/ipshared/276e/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_5 -93 \
"../../../../zed68k.srcs/sources_1/bd/ethernetlite/ipshared/276e/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_5  -v2k5 \
"../../../../zed68k.srcs/sources_1/bd/ethernetlite/ipshared/276e/hdl/fifo_generator_v13_2_rfs.v" \

vcom -work lib_fifo_v1_0_14 -93 \
"../../../../zed68k.srcs/sources_1/bd/ethernetlite/ipshared/a5cb/hdl/lib_fifo_v1_0_rfs.vhd" \

vcom -work axi_ethernetlite_v3_0_20 -93 \
"../../../../zed68k.srcs/sources_1/bd/ethernetlite/ipshared/e293/hdl/axi_ethernetlite_v3_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/ethernetlite/ip/ethernetlite_axi_ethernetlite_0_0/sim/ethernetlite_axi_ethernetlite_0_0.vhd" \

vlog -work xil_defaultlib  -v2k5 \
"../../../bd/ethernetlite/ip/ethernetlite_axi_ethernet_0_0/sim/ethernetlite_axi_ethernet_0_0.v" \
"../../../bd/ethernetlite/sim/ethernetlite.v" \

vlog -work xil_defaultlib \
"glbl.v"

