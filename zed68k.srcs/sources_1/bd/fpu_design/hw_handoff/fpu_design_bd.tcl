
################################################################
# This is a generated script based on design: fpu_design
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
# source fpu_design_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# fpu

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7a35ticsg324-1L
   set_property BOARD_PART digilentinc.com:arty-a7-35:part0:1.0 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name fpu_design

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
  set clk_in100 [ create_bd_port -dir I -type clk clk_in100 ]
  set data_count_0 [ create_bd_port -dir O -from 4 -to 0 data_count_0 ]
  set error [ create_bd_port -dir O error ]
  set fpu_op_i [ create_bd_port -dir I -from 2 -to 0 fpu_op_i ]
  set opa_i [ create_bd_port -dir I -from 31 -to 0 opa_i ]
  set opb_i [ create_bd_port -dir I -from 31 -to 0 opb_i ]
  set rd_en [ create_bd_port -dir I rd_en ]
  set ready_o [ create_bd_port -dir O -from 0 -to 0 ready_o ]
  set result_o [ create_bd_port -dir O -from 31 -to 0 result_o ]
  set rmode_i [ create_bd_port -dir I -from 1 -to 0 rmode_i ]
  set start_i [ create_bd_port -dir I start_i ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Data_Count {true} \
   CONFIG.Data_Count_Width {5} \
   CONFIG.Empty_Threshold_Assert_Value {2} \
   CONFIG.Empty_Threshold_Negate_Value {3} \
   CONFIG.Full_Threshold_Assert_Value {30} \
   CONFIG.Full_Threshold_Negate_Value {29} \
   CONFIG.Input_Data_Width {32} \
   CONFIG.Input_Depth {32} \
   CONFIG.Output_Data_Width {32} \
   CONFIG.Output_Depth {32} \
   CONFIG.Performance_Options {Standard_FIFO} \
   CONFIG.Read_Data_Count_Width {5} \
   CONFIG.Reset_Pin {false} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.Use_Dout_Reset {false} \
   CONFIG.Use_Extra_Logic {false} \
   CONFIG.Valid_Flag {false} \
   CONFIG.Write_Data_Count_Width {5} \
 ] $fifo_generator_0

  # Create instance: fpu_0, and set properties
  set block_name fpu
  set block_cell_name fpu_0
  if { [catch {set fpu_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $fpu_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: util_reduced_logic_0, and set properties
  set util_reduced_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 util_reduced_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.C_SIZE {5} \
   CONFIG.LOGO_FILE {data/sym_orgate.png} \
 ] $util_reduced_logic_0

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_0

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {5} \
 ] $xlconcat_0

  # Create port connections
  connect_bd_net -net clk_wiz_clk_out1 [get_bd_ports clk_in100] [get_bd_pins fifo_generator_0/clk] [get_bd_pins fpu_0/clk_i]
  connect_bd_net -net fifo_generator_0_data_count [get_bd_ports data_count_0] [get_bd_pins fifo_generator_0/data_count]
  connect_bd_net -net fifo_generator_0_dout [get_bd_ports result_o] [get_bd_pins fifo_generator_0/dout]
  connect_bd_net -net fifo_generator_0_empty [get_bd_pins fifo_generator_0/empty] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net fpu_0_div_zero_o [get_bd_pins fpu_0/div_zero_o] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net fpu_0_inf_o [get_bd_pins fpu_0/inf_o] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net fpu_0_output_o [get_bd_pins fifo_generator_0/din] [get_bd_pins fpu_0/output_o]
  connect_bd_net -net fpu_0_qnan_o [get_bd_pins fpu_0/qnan_o] [get_bd_pins xlconcat_0/In3]
  connect_bd_net -net fpu_0_ready_o [get_bd_pins fifo_generator_0/wr_en] [get_bd_pins fpu_0/ready_o]
  connect_bd_net -net fpu_0_snan_o [get_bd_pins fpu_0/snan_o] [get_bd_pins xlconcat_0/In4]
  connect_bd_net -net fpu_0_zero_o [get_bd_pins fpu_0/zero_o] [get_bd_pins xlconcat_0/In2]
  connect_bd_net -net fpu_op_i_0_1 [get_bd_ports fpu_op_i] [get_bd_pins fpu_0/fpu_op_i]
  connect_bd_net -net opa_i_0_1 [get_bd_ports opa_i] [get_bd_pins fpu_0/opa_i]
  connect_bd_net -net opb_i_0_1 [get_bd_ports opb_i] [get_bd_pins fpu_0/opb_i]
  connect_bd_net -net rd_en_0_1 [get_bd_ports rd_en] [get_bd_pins fifo_generator_0/rd_en]
  connect_bd_net -net rmode_i_0_1 [get_bd_ports rmode_i] [get_bd_pins fpu_0/rmode_i]
  connect_bd_net -net start_i_0_1 [get_bd_ports start_i] [get_bd_pins fpu_0/start_i]
  connect_bd_net -net util_reduced_logic_0_Res [get_bd_ports error] [get_bd_pins util_reduced_logic_0/Res]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_ports ready_o] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins util_reduced_logic_0/Op1] [get_bd_pins xlconcat_0/dout]

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


