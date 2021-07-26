vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/fifo_generator_v13_2_5
vlib questa_lib/msim/util_reduced_logic_v2_0_4
vlib questa_lib/msim/xlconcat_v2_1_3
vlib questa_lib/msim/util_vector_logic_v2_0_1

vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap fifo_generator_v13_2_5 questa_lib/msim/fifo_generator_v13_2_5
vmap util_reduced_logic_v2_0_4 questa_lib/msim/util_reduced_logic_v2_0_4
vmap xlconcat_v2_1_3 questa_lib/msim/xlconcat_v2_1_3
vmap util_vector_logic_v2_0_1 questa_lib/msim/util_vector_logic_v2_0_1

vlog -work xpm  -sv \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93 \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  \
"../../../bd/fpu_design/ip/fpu_design_fpu_0_0/sim/fpu_design_fpu_0_0.v" \

vlog -work fifo_generator_v13_2_5  \
"../../../../zed68k.srcs/sources_1/bd/fpu_design/ipshared/276e/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_5  -93 \
"../../../../zed68k.srcs/sources_1/bd/fpu_design/ipshared/276e/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_5  \
"../../../../zed68k.srcs/sources_1/bd/fpu_design/ipshared/276e/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work xil_defaultlib  \
"../../../bd/fpu_design/ip/fpu_design_fifo_generator_0_0/sim/fpu_design_fifo_generator_0_0.v" \

vlog -work util_reduced_logic_v2_0_4  \
"../../../../zed68k.srcs/sources_1/bd/fpu_design/ipshared/4c94/hdl/util_reduced_logic_v2_0_vl_rfs.v" \

vlog -work xil_defaultlib  \
"../../../bd/fpu_design/ip/fpu_design_util_reduced_logic_0_0/sim/fpu_design_util_reduced_logic_0_0.v" \

vlog -work xlconcat_v2_1_3  \
"../../../../zed68k.srcs/sources_1/bd/fpu_design/ipshared/442e/hdl/xlconcat_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  \
"../../../bd/fpu_design/ip/fpu_design_xlconcat_0_0/sim/fpu_design_xlconcat_0_0.v" \

vlog -work util_vector_logic_v2_0_1  \
"../../../../zed68k.srcs/sources_1/bd/fpu_design/ipshared/2137/hdl/util_vector_logic_v2_0_vl_rfs.v" \

vlog -work xil_defaultlib  \
"../../../bd/fpu_design/ip/fpu_design_util_vector_logic_0_0/sim/fpu_design_util_vector_logic_0_0.v" \
"../../../bd/fpu_design/sim/fpu_design.v" \

vlog -work xil_defaultlib \
"glbl.v"

