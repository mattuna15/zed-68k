-makelib ies_lib/xpm -sv \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/serial/ip/serial_UART_TX_0_0/sim/serial_UART_TX_0_0.v" \
  "../../../bd/serial/ip/serial_UART_FIFO_IO_cntl_pr_0_0/sim/serial_UART_FIFO_IO_cntl_pr_0_0.v" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_5 \
  "../../../../zed68k.srcs/sources_1/bd/serial/ipshared/276e/simulation/fifo_generator_vlog_beh.v" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_5 \
  "../../../../zed68k.srcs/sources_1/bd/serial/ipshared/276e/hdl/fifo_generator_v13_2_rfs.vhd" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_5 \
  "../../../../zed68k.srcs/sources_1/bd/serial/ipshared/276e/hdl/fifo_generator_v13_2_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/serial/ip/serial_fifo_generator_0_0/sim/serial_fifo_generator_0_0.v" \
-endlib
-makelib ies_lib/util_vector_logic_v2_0_1 \
  "../../../../zed68k.srcs/sources_1/bd/serial/ipshared/2137/hdl/util_vector_logic_v2_0_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/serial/ip/serial_util_vector_logic_0_0/sim/serial_util_vector_logic_0_0.v" \
  "../../../bd/serial/ip/serial_util_vector_logic_0_1/sim/serial_util_vector_logic_0_1.v" \
  "../../../bd/serial/sim/serial.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

