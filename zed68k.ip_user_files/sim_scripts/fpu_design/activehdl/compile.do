vlib work
vlib activehdl

vlib activehdl/xpm
vlib activehdl/xil_defaultlib
vlib activehdl/fifo_generator_v13_2_5
vlib activehdl/util_reduced_logic_v2_0_4
vlib activehdl/xlconcat_v2_1_3
vlib activehdl/util_vector_logic_v2_0_1

vmap xpm activehdl/xpm
vmap xil_defaultlib activehdl/xil_defaultlib
vmap fifo_generator_v13_2_5 activehdl/fifo_generator_v13_2_5
vmap util_reduced_logic_v2_0_4 activehdl/util_reduced_logic_v2_0_4
vmap xlconcat_v2_1_3 activehdl/xlconcat_v2_1_3
vmap util_vector_logic_v2_0_1 activehdl/util_vector_logic_v2_0_1

vlog -work xpm  -sv2k12 \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 \
"../../../bd/fpu_design/ip/fpu_design_fpu_0_0/sim/fpu_design_fpu_0_0.v" \

vlog -work fifo_generator_v13_2_5  -v2k5 \
"../../../../zed68k.srcs/sources_1/bd/fpu_design/ipshared/276e/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_5 -93 \
"../../../../zed68k.srcs/sources_1/bd/fpu_design/ipshared/276e/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_5  -v2k5 \
"../../../../zed68k.srcs/sources_1/bd/fpu_design/ipshared/276e/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../bd/fpu_design/ip/fpu_design_fifo_generator_0_0/sim/fpu_design_fifo_generator_0_0.v" \

vlog -work util_reduced_logic_v2_0_4  -v2k5 \
"../../../../zed68k.srcs/sources_1/bd/fpu_design/ipshared/4c94/hdl/util_reduced_logic_v2_0_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../bd/fpu_design/ip/fpu_design_util_reduced_logic_0_0/sim/fpu_design_util_reduced_logic_0_0.v" \

vlog -work xlconcat_v2_1_3  -v2k5 \
"../../../../zed68k.srcs/sources_1/bd/fpu_design/ipshared/442e/hdl/xlconcat_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../bd/fpu_design/ip/fpu_design_xlconcat_0_0/sim/fpu_design_xlconcat_0_0.v" \

vlog -work util_vector_logic_v2_0_1  -v2k5 \
"../../../../zed68k.srcs/sources_1/bd/fpu_design/ipshared/2137/hdl/util_vector_logic_v2_0_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../bd/fpu_design/ip/fpu_design_util_vector_logic_0_0/sim/fpu_design_util_vector_logic_0_0.v" \
"../../../bd/fpu_design/sim/fpu_design.v" \

vlog -work xil_defaultlib \
"glbl.v"

