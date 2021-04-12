vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/fifo_generator_v13_2_5

vmap xpm modelsim_lib/msim/xpm
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap fifo_generator_v13_2_5 modelsim_lib/msim/fifo_generator_v13_2_5

vlog -work xpm  -incr -sv \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \

vcom -work xpm  -93 \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr \
"../../../bd/serial/ip/serial_UART_TX_0_0/sim/serial_UART_TX_0_0.v" \
"../../../bd/serial/ip/serial_UART_FIFO_IO_cntl_pr_0_0/sim/serial_UART_FIFO_IO_cntl_pr_0_0.v" \

vlog -work fifo_generator_v13_2_5  -incr \
"../../../../zed68k.srcs/sources_1/bd/serial/ipshared/276e/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_5  -93 \
"../../../../zed68k.srcs/sources_1/bd/serial/ipshared/276e/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_5  -incr \
"../../../../zed68k.srcs/sources_1/bd/serial/ipshared/276e/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work xil_defaultlib  -incr \
"../../../bd/serial/ip/serial_fifo_generator_0_0/sim/serial_fifo_generator_0_0.v" \
"../../../bd/serial/sim/serial.v" \

vlog -work xil_defaultlib \
"glbl.v"
