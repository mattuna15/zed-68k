-makelib ies_lib/xpm -sv \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/debug/ip/debug_ila_0_0/sim/debug_ila_0_0.vhd" \
  "../../../bd/debug/sim/debug.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

