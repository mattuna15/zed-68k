# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "g_CLKS_PER_BIT" -parent ${Page_0}


}

proc update_PARAM_VALUE.g_CLKS_PER_BIT { PARAM_VALUE.g_CLKS_PER_BIT } {
	# Procedure called to update g_CLKS_PER_BIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.g_CLKS_PER_BIT { PARAM_VALUE.g_CLKS_PER_BIT } {
	# Procedure called to validate g_CLKS_PER_BIT
	return true
}


proc update_MODELPARAM_VALUE.g_CLKS_PER_BIT { MODELPARAM_VALUE.g_CLKS_PER_BIT PARAM_VALUE.g_CLKS_PER_BIT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.g_CLKS_PER_BIT}] ${MODELPARAM_VALUE.g_CLKS_PER_BIT}
}

