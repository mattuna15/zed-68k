-makelib ies_lib/xpm -sv \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../zed68k.srcs/sources_1/ip/audio_clock48/audio_clock48_clk_wiz.v" \
  "../../../../zed68k.srcs/sources_1/ip/audio_clock48/audio_clock48.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

