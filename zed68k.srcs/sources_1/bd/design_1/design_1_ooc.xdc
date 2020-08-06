################################################################################

# This XDC is used only for OOC mode of synthesis, implementation
# This constraints file contains default clock frequencies to be used during
# out-of-context flows such as OOC Synthesis and Hierarchical Designs.
# This constraints file is not used in normal top-down synthesis (default flow
# of Vivado)
################################################################################
create_clock -name rd_clk -period 10 [get_ports rd_clk]
create_clock -name clk100_i -period 10 [get_ports clk100_i]

################################################################################