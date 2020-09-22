-makelib xcelium_lib/xpm -sv \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../../../xilinx/Downloads/opl3_fpga-master/fpga/modules/clks/ip/clk_gen/clk_gen_clk_wiz.v" \
  "../../../../../../xilinx/Downloads/opl3_fpga-master/fpga/modules/clks/ip/clk_gen/clk_gen.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

