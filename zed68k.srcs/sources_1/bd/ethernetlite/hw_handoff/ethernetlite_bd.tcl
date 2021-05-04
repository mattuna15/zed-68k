
################################################################
# This is a generated script based on design: ethernetlite
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
# source ethernetlite_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# axi_ethernet

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
set design_name ethernetlite

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
  set eth_mdio_mdc [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 eth_mdio_mdc ]

  set eth_mii [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 eth_mii ]


  # Create ports
  set address [ create_bd_port -dir I -from 31 -to 0 address ]
  set eth_intr [ create_bd_port -dir O -type intr eth_intr ]
  set i_cen [ create_bd_port -dir I i_cen ]
  set i_valid_p [ create_bd_port -dir I i_valid_p ]
  set i_wren [ create_bd_port -dir I i_wren ]
  set o_ready_p [ create_bd_port -dir O o_ready_p ]
  set o_valid_p [ create_bd_port -dir O o_valid_p ]
  set rd_data [ create_bd_port -dir O -from 31 -to 0 rd_data ]
  set sys_clock [ create_bd_port -dir I -type clk sys_clock ]
  set sys_resetn [ create_bd_port -dir I -type rst sys_resetn ]
  set wr_ack_p [ create_bd_port -dir O wr_ack_p ]
  set wr_byte_mask [ create_bd_port -dir I -from 3 -to 0 wr_byte_mask ]
  set wr_data [ create_bd_port -dir I -from 31 -to 0 wr_data ]

  # Create instance: axi_ethernet_0, and set properties
  set block_name axi_ethernet
  set block_cell_name axi_ethernet_0
  if { [catch {set axi_ethernet_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $axi_ethernet_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: axi_ethernetlite_0, and set properties
  set axi_ethernetlite_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0 ]
  set_property -dict [ list \
   CONFIG.C_RX_PING_PONG {0} \
   CONFIG.C_S_AXI_PROTOCOL {AXI4} \
   CONFIG.C_TX_PING_PONG {0} \
   CONFIG.MDIO_BOARD_INTERFACE {eth_mdio_mdc} \
   CONFIG.MII_BOARD_INTERFACE {eth_mii} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $axi_ethernetlite_0

  # Create interface connections
  connect_bd_intf_net -intf_net axi_ethernet_0_s_axi [get_bd_intf_pins axi_ethernet_0/s_axi] [get_bd_intf_pins axi_ethernetlite_0/S_AXI]
  connect_bd_intf_net -intf_net axi_ethernetlite_0_MDIO [get_bd_intf_ports eth_mdio_mdc] [get_bd_intf_pins axi_ethernetlite_0/MDIO]
  connect_bd_intf_net -intf_net axi_ethernetlite_0_MII [get_bd_intf_ports eth_mii] [get_bd_intf_pins axi_ethernetlite_0/MII]

  # Create port connections
  connect_bd_net -net address_0_1 [get_bd_ports address] [get_bd_pins axi_ethernet_0/address]
  connect_bd_net -net axi_ethernet_0_o_ready_p [get_bd_ports o_ready_p] [get_bd_pins axi_ethernet_0/o_ready_p]
  connect_bd_net -net axi_ethernet_0_o_valid_p [get_bd_ports o_valid_p] [get_bd_pins axi_ethernet_0/o_valid_p]
  connect_bd_net -net axi_ethernet_0_rd_data [get_bd_ports rd_data] [get_bd_pins axi_ethernet_0/rd_data]
  connect_bd_net -net axi_ethernet_0_wr_ack_p [get_bd_ports wr_ack_p] [get_bd_pins axi_ethernet_0/wr_ack_p]
  connect_bd_net -net axi_ethernetlite_0_ip2intc_irpt [get_bd_ports eth_intr] [get_bd_pins axi_ethernetlite_0/ip2intc_irpt]
  connect_bd_net -net i_cen_0_1 [get_bd_ports i_cen] [get_bd_pins axi_ethernet_0/i_cen]
  connect_bd_net -net i_valid_p_0_1 [get_bd_ports i_valid_p] [get_bd_pins axi_ethernet_0/i_valid_p]
  connect_bd_net -net i_wren_0_1 [get_bd_ports i_wren] [get_bd_pins axi_ethernet_0/i_wren]
  connect_bd_net -net sys_clock_0_1 [get_bd_ports sys_clock] [get_bd_pins axi_ethernet_0/sys_clock] [get_bd_pins axi_ethernet_0/ui_clk] [get_bd_pins axi_ethernetlite_0/s_axi_aclk]
  connect_bd_net -net sys_resetn_0_1 [get_bd_ports sys_resetn] [get_bd_pins axi_ethernet_0/init_calib_complete] [get_bd_pins axi_ethernet_0/sys_resetn] [get_bd_pins axi_ethernet_0/ui_clk_sync_rst] [get_bd_pins axi_ethernetlite_0/s_axi_aresetn]
  connect_bd_net -net wr_byte_mask_0_1 [get_bd_ports wr_byte_mask] [get_bd_pins axi_ethernet_0/wr_byte_mask]
  connect_bd_net -net wr_data_0_1 [get_bd_ports wr_data] [get_bd_pins axi_ethernet_0/wr_data]

  # Create address segments

  # Exclude Address Segments
  exclude_bd_addr_seg -offset 0x40E00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_ethernet_0/s_axi] [get_bd_addr_segs axi_ethernetlite_0/S_AXI/Reg]


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


