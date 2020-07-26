# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "Baud" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ClkFrequency" -parent ${Page_0}
  ipgui::add_param $IPINST -name "Oversampling" -parent ${Page_0}


}

proc update_PARAM_VALUE.Baud { PARAM_VALUE.Baud } {
	# Procedure called to update Baud when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Baud { PARAM_VALUE.Baud } {
	# Procedure called to validate Baud
	return true
}

proc update_PARAM_VALUE.ClkFrequency { PARAM_VALUE.ClkFrequency } {
	# Procedure called to update ClkFrequency when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ClkFrequency { PARAM_VALUE.ClkFrequency } {
	# Procedure called to validate ClkFrequency
	return true
}

proc update_PARAM_VALUE.Oversampling { PARAM_VALUE.Oversampling } {
	# Procedure called to update Oversampling when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Oversampling { PARAM_VALUE.Oversampling } {
	# Procedure called to validate Oversampling
	return true
}


proc update_MODELPARAM_VALUE.ClkFrequency { MODELPARAM_VALUE.ClkFrequency PARAM_VALUE.ClkFrequency } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ClkFrequency}] ${MODELPARAM_VALUE.ClkFrequency}
}

proc update_MODELPARAM_VALUE.Baud { MODELPARAM_VALUE.Baud PARAM_VALUE.Baud } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Baud}] ${MODELPARAM_VALUE.Baud}
}

proc update_MODELPARAM_VALUE.Oversampling { MODELPARAM_VALUE.Oversampling PARAM_VALUE.Oversampling } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Oversampling}] ${MODELPARAM_VALUE.Oversampling}
}

