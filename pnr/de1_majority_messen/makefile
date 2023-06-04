## ----------------------------------------------------------------------------
## Script     : makefile
## ----------------------------------------------------------------------------
## Author     : Johann Faerber, Friedrich Beckmann
## Company    : University of Applied Sciences Augsburg
## ----------------------------------------------------------------------------
## Description: This makefile allows automating design flow with Quartus,
##              it is based on a design directory structure described in 
##              ../makefile
## ----------------------------------------------------------------------------

###################################################################
# Project Configuration: 
#
# - assign variable SIM_PROJECT_NAME with the top level project name
# - add additional VHDL sources to SOURCE_FILES, if necessary
#
# Prerequisite: 
#   - mandatory design directory structure (see end of file)
#   - assumes file name of top level entity de1_$(PROJECT)_structure.vhd
###################################################################

SIM_PROJECT_NAME = de1_majority_messen
PROJECT = $(SIM_PROJECT_NAME)

# Here the VHDL files for synthesis are defined. 
include ../../sim/$(SIM_PROJECT_NAME)/makefile.sources

# Add the toplevel fpga vhdl file
SOURCE_FILES = $(SYN_SOURCE_FILES) 

include ../makefile


