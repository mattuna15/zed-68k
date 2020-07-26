
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2020.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# UART_FIFO_IO_cntl_proc, UART_RX

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7a100tcsg324-1
   set_property BOARD_PART digilentinc.com:nexys4_ddr:part0:1.1 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set LED [ create_bd_port -dir O -from 7 -to 0 LED ]
  set cts [ create_bd_port -dir O cts ]
  set m68_rxd [ create_bd_port -dir O -from 7 -to 0 m68_rxd ]
  set rd_clk [ create_bd_port -dir I -type clk rd_clk ]
  set rd_data_cnt [ create_bd_port -dir O -from 8 -to 0 rd_data_cnt ]
  set rd_en [ create_bd_port -dir I rd_en ]
  set reset_n [ create_bd_port -dir I -type rst reset_n ]
  set rts [ create_bd_port -dir O rts ]
  set rxd1 [ create_bd_port -dir I rxd1 ]
  set sys_clock [ create_bd_port -dir I -type clk -freq_hz 100000000 sys_clock ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_RESET {reset} \
   CONFIG.PHASE {0.000} \
 ] $sys_clock

  # Create instance: UART_FIFO_IO_cntl_pr_0, and set properties
  set block_name UART_FIFO_IO_cntl_proc
  set block_cell_name UART_FIFO_IO_cntl_pr_0
  if { [catch {set UART_FIFO_IO_cntl_pr_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $UART_FIFO_IO_cntl_pr_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: UART_RX_0, and set properties
  set block_name UART_RX
  set block_cell_name UART_RX_0
  if { [catch {set UART_RX_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $UART_RX_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0 ]
  set_property -dict [ list \
   CONFIG.CLK_IN1_BOARD_INTERFACE {sys_clock} \
   CONFIG.RESET_BOARD_INTERFACE {reset} \
   CONFIG.RESET_PORT {resetn} \
   CONFIG.RESET_TYPE {ACTIVE_LOW} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $clk_wiz_0

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Data_Count_Width {9} \
   CONFIG.Empty_Threshold_Assert_Value {2} \
   CONFIG.Empty_Threshold_Negate_Value {3} \
   CONFIG.Enable_Reset_Synchronization {true} \
   CONFIG.Enable_Safety_Circuit {false} \
   CONFIG.Fifo_Implementation {Independent_Clocks_Block_RAM} \
   CONFIG.Full_Flags_Reset_Value {0} \
   CONFIG.Full_Threshold_Assert_Value {509} \
   CONFIG.Full_Threshold_Negate_Value {508} \
   CONFIG.Input_Data_Width {8} \
   CONFIG.Input_Depth {512} \
   CONFIG.Output_Data_Width {8} \
   CONFIG.Output_Depth {512} \
   CONFIG.Overflow_Flag {true} \
   CONFIG.Programmable_Empty_Type {No_Programmable_Empty_Threshold} \
   CONFIG.Read_Clock_Frequency {1} \
   CONFIG.Read_Data_Count {true} \
   CONFIG.Read_Data_Count_Width {9} \
   CONFIG.Reset_Pin {false} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.Underflow_Flag {true} \
   CONFIG.Use_Dout_Reset {false} \
   CONFIG.Use_Embedded_Registers {false} \
   CONFIG.Valid_Flag {true} \
   CONFIG.Write_Acknowledge_Flag {true} \
   CONFIG.Write_Clock_Frequency {1} \
   CONFIG.Write_Data_Count {true} \
   CONFIG.Write_Data_Count_Width {9} \
 ] $fifo_generator_0

  # Create port connections
  connect_bd_net -net UART_FIFO_IO_cntl_pr_0_fifoM_wr_en [get_bd_pins UART_FIFO_IO_cntl_pr_0/fifoM_wr_en] [get_bd_pins fifo_generator_0/wr_en]
  connect_bd_net -net UART_FIFO_IO_cntl_pr_0_uart_rx_rd_en [get_bd_ports cts] [get_bd_pins UART_FIFO_IO_cntl_pr_0/uart_rx_rd_en]
  connect_bd_net -net UART_FIFO_IO_cntl_pr_0_uart_tx_wr_en [get_bd_ports rts] [get_bd_pins UART_FIFO_IO_cntl_pr_0/uart_tx_wr_en]
  connect_bd_net -net UART_RX_0_o_RX_Byte [get_bd_pins UART_RX_0/o_RX_Byte] [get_bd_pins fifo_generator_0/din]
  connect_bd_net -net UART_RX_0_o_RX_DV [get_bd_pins UART_FIFO_IO_cntl_pr_0/uart_rx_dv] [get_bd_pins UART_RX_0/o_RX_DV]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins UART_FIFO_IO_cntl_pr_0/clk] [get_bd_pins UART_RX_0/i_Clk] [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins fifo_generator_0/wr_clk]
  connect_bd_net -net fifo_generator_0_dout [get_bd_ports LED] [get_bd_ports m68_rxd] [get_bd_pins fifo_generator_0/dout]
  connect_bd_net -net fifo_generator_0_empty [get_bd_pins UART_FIFO_IO_cntl_pr_0/fifoM_empty] [get_bd_pins fifo_generator_0/empty]
  connect_bd_net -net fifo_generator_0_full [get_bd_pins UART_FIFO_IO_cntl_pr_0/fifoM_full] [get_bd_pins fifo_generator_0/full]
  connect_bd_net -net fifo_generator_0_rd_data_count [get_bd_ports rd_data_cnt] [get_bd_pins fifo_generator_0/rd_data_count]
  connect_bd_net -net fifo_generator_0_wr_ack [get_bd_pins UART_FIFO_IO_cntl_pr_0/fifoM_wr_ack] [get_bd_pins fifo_generator_0/wr_ack]
  connect_bd_net -net rd_clk_0_1 [get_bd_ports rd_clk] [get_bd_pins fifo_generator_0/rd_clk]
  connect_bd_net -net rd_en_0_1 [get_bd_ports rd_en] [get_bd_pins fifo_generator_0/rd_en]
  connect_bd_net -net reset_n_1 [get_bd_ports reset_n] [get_bd_pins UART_FIFO_IO_cntl_pr_0/rst] [get_bd_pins clk_wiz_0/resetn]
  connect_bd_net -net rxd1_1 [get_bd_ports rxd1] [get_bd_pins UART_RX_0/i_RX_Serial]
  connect_bd_net -net sys_clock_1 [get_bd_ports sys_clock] [get_bd_pins clk_wiz_0/clk_in1]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


