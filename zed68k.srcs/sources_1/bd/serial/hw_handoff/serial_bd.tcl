
################################################################
# This is a generated script based on design: serial
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
# source serial_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# UART_FIFO_IO_cntl_proc, UART_TX

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7a100tcsg324-1
   set_property BOARD_PART digilentinc.com:arty-a7-100:part0:1.0 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name serial

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
  set cts [ create_bd_port -dir O cts ]
  set reset_n [ create_bd_port -dir I -type rst reset_n ]
  set rts [ create_bd_port -dir O rts ]
  set sys_clk [ create_bd_port -dir I -type clk sys_clk ]
  set tx_data [ create_bd_port -dir I -from 7 -to 0 tx_data ]
  set tx_send_active [ create_bd_port -dir O -from 0 -to 0 tx_send_active ]
  set tx_wr_en [ create_bd_port -dir I tx_wr_en ]
  set txd [ create_bd_port -dir O txd ]

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
  
  # Create instance: UART_TX_0, and set properties
  set block_name UART_TX
  set block_cell_name UART_TX_0
  if { [catch {set UART_TX_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $UART_TX_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.g_CLKS_PER_BIT {868} \
 ] $UART_TX_0

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Data_Count {true} \
   CONFIG.Data_Count_Width {5} \
   CONFIG.Full_Threshold_Assert_Value {30} \
   CONFIG.Full_Threshold_Negate_Value {29} \
   CONFIG.Input_Data_Width {8} \
   CONFIG.Input_Depth {32} \
   CONFIG.Output_Data_Width {8} \
   CONFIG.Output_Depth {32} \
   CONFIG.Read_Data_Count_Width {5} \
   CONFIG.Reset_Pin {false} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.Use_Dout_Reset {false} \
   CONFIG.Valid_Flag {true} \
   CONFIG.Write_Acknowledge_Flag {true} \
   CONFIG.Write_Data_Count_Width {5} \
 ] $fifo_generator_0

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_0

  # Create instance: util_vector_logic_1, and set properties
  set util_vector_logic_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_1 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_1

  # Create port connections
  connect_bd_net -net UART_FIFO_IO_cntl_pr_0_fifoM_rd_en [get_bd_pins UART_FIFO_IO_cntl_pr_0/fifoM_rd_en] [get_bd_pins fifo_generator_0/rd_en]
  connect_bd_net -net UART_FIFO_IO_cntl_pr_0_uart_rx_rd_en [get_bd_ports cts] [get_bd_pins UART_FIFO_IO_cntl_pr_0/uart_rx_rd_en]
  connect_bd_net -net UART_FIFO_IO_cntl_pr_0_uart_tx_wr_en [get_bd_ports rts] [get_bd_pins UART_FIFO_IO_cntl_pr_0/uart_tx_wr_en]
  connect_bd_net -net UART_TX_0_o_TX_Active [get_bd_pins UART_TX_0/o_TX_Active] [get_bd_pins util_vector_logic_1/Op1]
  connect_bd_net -net UART_TX_0_o_TX_Serial [get_bd_ports txd] [get_bd_pins UART_TX_0/o_TX_Serial]
  connect_bd_net -net clk_0_1 [get_bd_ports sys_clk] [get_bd_pins UART_FIFO_IO_cntl_pr_0/clk] [get_bd_pins UART_TX_0/i_Clk] [get_bd_pins fifo_generator_0/clk]
  connect_bd_net -net din_0_1 [get_bd_ports tx_data] [get_bd_pins fifo_generator_0/din]
  connect_bd_net -net fifo_generator_0_dout [get_bd_pins UART_TX_0/i_TX_Byte] [get_bd_pins fifo_generator_0/dout]
  connect_bd_net -net fifo_generator_0_full [get_bd_pins UART_FIFO_IO_cntl_pr_0/fifoM_full] [get_bd_pins fifo_generator_0/full] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net fifo_generator_0_valid [get_bd_pins UART_TX_0/i_TX_DV] [get_bd_pins fifo_generator_0/valid]
  connect_bd_net -net fifo_generator_0_wr_ack [get_bd_pins UART_FIFO_IO_cntl_pr_0/fifoM_wr_ack] [get_bd_pins fifo_generator_0/wr_ack]
  connect_bd_net -net rst_0_1 [get_bd_ports reset_n] [get_bd_pins UART_FIFO_IO_cntl_pr_0/rst]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_ports tx_send_active] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net util_vector_logic_1_Res [get_bd_pins UART_FIFO_IO_cntl_pr_0/uart_tx_rfd] [get_bd_pins util_vector_logic_1/Res]
  connect_bd_net -net wr_en_0_1 [get_bd_ports tx_wr_en] [get_bd_pins fifo_generator_0/wr_en]

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


