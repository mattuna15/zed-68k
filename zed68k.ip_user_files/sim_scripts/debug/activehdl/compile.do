vlib work
vlib activehdl

vlib activehdl/xpm
vlib activehdl/xil_defaultlib

vmap xpm activehdl/xpm
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xpm  -sv2k12 "+incdir+../../../../zed68k.srcs/sources_1/bd/debug/ipshared/1b7e/hdl/verilog" "+incdir+../../../../zed68k.srcs/sources_1/bd/debug/ipshared/122e/hdl/verilog" "+incdir+../../../../zed68k.srcs/sources_1/bd/debug/ipshared/b205/hdl/verilog" "+incdir+../../../../zed68k.srcs/sources_1/bd/debug/ipshared/c968/hdl/verilog" \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/debug/ip/debug_ila_0_0/sim/debug_ila_0_0.vhd" \
"../../../bd/debug/sim/debug.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

