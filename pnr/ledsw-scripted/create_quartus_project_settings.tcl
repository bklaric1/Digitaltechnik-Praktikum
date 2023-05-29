## ----------------------------------------------------------------------------
## Script     : create_quartus_project_settings.tcl
## ----------------------------------------------------------------------------
## Author     : Johann Faerber, F. Beckmann
## Company    : University of Applied Sciences Augsburg
## ----------------------------------------------------------------------------
## Description: create a quartus project with default settings for device, 
##              unused pins, ...
##              quartus_sh -t create_quartus_project_settings.tcl 

# Load Quartus II Tcl Project package
package require ::quartus::project

	# ----------------------------------------------------------------------------
	# Create project
	# ----------------------------------------------------------------------------
	project_new ledsw -overwrite
	
	# ----------------------------------------------------------------------------
	# Assign family, device, and top-level file
	# ----------------------------------------------------------------------------
	set_global_assignment -name FAMILY "Cyclone II"
	set_global_assignment -name DEVICE EP2C20F484C7
	
	# ----------------------------------------------------------------------------
	# Default settings
	# ----------------------------------------------------------------------------
	set_global_assignment -name USE_CONFIGURATION_DEVICE ON
	set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
	set_global_assignment -name VHDL_INPUT_VERSION VHDL_2008
	
	# ----------------------------------------------------------------------------
	# Design files
	# ----------------------------------------------------------------------------
	set_global_assignment -name VHDL_FILE ../../src/ledsw_rtl.vhd
	
	# ----------------------------------------------------------------------------
	# Pin Assignments
	# ----------------------------------------------------------------------------
	# set_location_assignment PIN_L1 -to CLOCK_50
	set_location_assignment PIN_L22 -to SW[0]
	set_location_assignment PIN_L21 -to SW[1]
	set_location_assignment PIN_M22 -to SW[2]
	set_location_assignment PIN_V12 -to SW[3]
	set_location_assignment PIN_W12 -to SW[4]
	set_location_assignment PIN_U12 -to SW[5]
	set_location_assignment PIN_U11 -to SW[6]
	set_location_assignment PIN_M2  -to SW[7]
	set_location_assignment PIN_M1  -to SW[8]
	set_location_assignment PIN_L2  -to SW[9]
	set_location_assignment PIN_R20 -to LEDR[0]
	set_location_assignment PIN_R19 -to LEDR[1]
	set_location_assignment PIN_U19 -to LEDR[2]
	set_location_assignment PIN_Y19 -to LEDR[3]
	set_location_assignment PIN_T18 -to LEDR[4]
	set_location_assignment PIN_V19 -to LEDR[5]
	set_location_assignment PIN_Y18 -to LEDR[6]
	set_location_assignment PIN_U18 -to LEDR[7]
	set_location_assignment PIN_R18 -to LEDR[8]
	set_location_assignment PIN_R17 -to LEDR[9]
	
	# ----------------------------------------------------------------------------
	# Close project
	# ----------------------------------------------------------------------------
	project_close


