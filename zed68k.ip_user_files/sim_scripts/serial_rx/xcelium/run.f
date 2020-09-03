-makelib xcelium_lib/xpm -sv \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/fifo_generator_v13_2_5 \
  "../../../ipstatic/ip/serial_rx/ipshared/276e/simulation/fifo_generator_vlog_beh.v" \
-endlib
-makelib xcelium_lib/fifo_generator_v13_2_5 \
  "../../../ipstatic/ip/serial_rx/ipshared/276e/hdl/fifo_generator_v13_2_rfs.vhd" \
-endlib
-makelib xcelium_lib/fifo_generator_v13_2_5 \
  "../../../ipstatic/ip/serial_rx/ipshared/276e/hdl/fifo_generator_v13_2_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../zed68k.srcs/sources_1/ip/serial_rx/src/design_1_fifo_generator_0_0/sim/design_1_fifo_generator_0_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../zed68k.srcs/sources_1/ip/serial_rx/sim/design_1_UART_RX_0_0.vhd" \
  "../../../../zed68k.srcs/sources_1/ip/serial_rx/sim/design_1_UART_FIFO_IO_cntl_pr_0_0.vhd" \
  "../../../../zed68k.srcs/sources_1/ip/serial_rx/src/Uart_RX.vhd" \
  "../../../../zed68k.srcs/sources_1/ip/serial_rx/src/UART_FIFO_CTL.vhd" \
  "../../../../zed68k.srcs/sources_1/ip/serial_rx/sim/design_1.vhd" \
  "../../../../zed68k.srcs/sources_1/ip/serial_rx/sim/serial_rx.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

