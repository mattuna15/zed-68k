-makelib xcelium_lib/xpm -sv \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../zed68k.srcs/sources_1/ip/audio_clock229/audio_clock229_clk_wiz.v" \
  "../../../../zed68k.srcs/sources_1/ip/audio_clock229/audio_clock229.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib
