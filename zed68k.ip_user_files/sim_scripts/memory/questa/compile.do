vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm  -sv \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93 \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  \
"d:/code/zed-68k/zed68k.srcs/sources_1/bd/memory/ip/memory_system_cache_0_0/memory_system_cache_0_0_sim_netlist.v" \
"d:/code/zed-68k/zed68k.srcs/sources_1/bd/memory/ip/memory_util_vector_logic_0_0/memory_util_vector_logic_0_0_sim_netlist.v" \
"d:/code/zed-68k/zed68k.srcs/sources_1/bd/memory/ip/memory_proc_sys_reset_0_0/memory_proc_sys_reset_0_0_sim_netlist.v" \
"d:/code/zed-68k/zed68k.srcs/sources_1/bd/memory/ip/memory_util_vector_logic_1_0/memory_util_vector_logic_1_0_sim_netlist.v" \
"d:/code/zed-68k/zed68k.srcs/sources_1/bd/memory/ip/memory_mig_7series_0_2/memory_mig_7series_0_2_sim_netlist.v" \

vlog -work xil_defaultlib \
"glbl.v"

