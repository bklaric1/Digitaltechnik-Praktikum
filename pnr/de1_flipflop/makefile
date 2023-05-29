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


SIM_PROJECT_NAME = de1_flipflop
PROJECT = $(SIM_PROJECT_NAME)

# Here the VHDL files for synthesis are defined. 
include ../../sim/$(SIM_PROJECT_NAME)/makefile.sources

# Add the toplevel fpga vhdl file
SOURCE_FILES = $(SYN_SOURCE_FILES) 

include ../makefile


