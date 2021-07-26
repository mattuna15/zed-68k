-makelib xcelium_lib/xpm -sv \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "D:/xilinx/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/fpu_design/ip/fpu_design_fpu_0_0/sim/fpu_design_fpu_0_0.v" \
-endlib
-makelib xcelium_lib/fifo_generator_v13_2_5 \
  "../../../../zed68k.srcs/sources_1/bd/fpu_design/ipshared/276e/simulation/fifo_generator_vlog_beh.v" \
-endlib
-makelib xcelium_lib/fifo_generator_v13_2_5 \
  "../../../../zed68k.srcs/sources_1/bd/fpu_design/ipshared/276e/hdl/fifo_generator_v13_2_rfs.vhd" \
-endlib
-makelib xcelium_lib/fifo_generator_v13_2_5 \
  "../../../../zed68k.srcs/sources_1/bd/fpu_design/ipshared/276e/hdl/fifo_generator_v13_2_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/fpu_design/ip/fpu_design_fifo_generator_0_0/sim/fpu_design_fifo_generator_0_0.v" \
-endlib
-makelib xcelium_lib/util_reduced_logic_v2_0_4 \
  "../../../../zed68k.srcs/sources_1/bd/fpu_design/ipshared/4c94/hdl/util_reduced_logic_v2_0_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/fpu_design/ip/fpu_design_util_reduced_logic_0_0/sim/fpu_design_util_reduced_logic_0_0.v" \
-endlib
-makelib xcelium_lib/xlconcat_v2_1_3 \
  "../../../../zed68k.srcs/sources_1/bd/fpu_design/ipshared/442e/hdl/xlconcat_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/fpu_design/ip/fpu_design_xlconcat_0_0/sim/fpu_design_xlconcat_0_0.v" \
-endlib
-makelib xcelium_lib/util_vector_logic_v2_0_1 \
  "../../../../zed68k.srcs/sources_1/bd/fpu_design/ipshared/2137/hdl/util_vector_logic_v2_0_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/fpu_design/ip/fpu_design_util_vector_logic_0_0/sim/fpu_design_util_vector_logic_0_0.v" \
  "../../../bd/fpu_design/sim/fpu_design.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

