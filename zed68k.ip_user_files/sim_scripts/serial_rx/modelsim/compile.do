vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/fifo_generator_v13_2_5
vlib modelsim_lib/msim/xil_defaultlib

vmap xpm modelsim_lib/msim/xpm
vmap fifo_generator_v13_2_5 modelsim_lib/msim/fifo_generator_v13_2_5
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xpm  -incr -sv \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \

vcom -work xpm  -93 \
"D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work fifo_generator_v13_2_5  -incr \
"../../../ipstatic/ip/serial_rx/ipshared/276e/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_5  -93 \
"../../../ipstatic/ip/serial_rx/ipshared/276e/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_5  -incr \
"../../../ipstatic/ip/serial_rx/ipshared/276e/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work xil_defaultlib  -incr \
"../../../../zed68k.srcs/sources_1/ip/serial_rx/src/design_1_fifo_generator_0_0/sim/design_1_fifo_generator_0_0.v" \

vcom -work xil_defaultlib  -93 \
"../../../../zed68k.srcs/sources_1/ip/serial_rx/sim/design_1_UART_RX_0_0.vhd" \
"../../../../zed68k.srcs/sources_1/ip/serial_rx/sim/design_1_UART_FIFO_IO_cntl_pr_0_0.vhd" \
"../../../../zed68k.srcs/sources_1/ip/serial_rx/src/Uart_RX.vhd" \
"../../../../zed68k.srcs/sources_1/ip/serial_rx/src/UART_FIFO_CTL.vhd" \
"../../../../zed68k.srcs/sources_1/ip/serial_rx/sim/design_1.vhd" \
"../../../../zed68k.srcs/sources_1/ip/serial_rx/sim/serial_rx.vhd" \

vlog -work xil_defaultlib \
"glbl.v"
