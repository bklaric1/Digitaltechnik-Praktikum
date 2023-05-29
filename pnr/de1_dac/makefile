
SIM_PROJECT_NAME = de1_dac
PROJECT = $(SIM_PROJECT_NAME)

SOURCE_FILES = ../../src/de1_dac_rtl.vhd

include ../makefile

# Use the specific sdc file
$(PROJECT).sdc: de1_dac_special.sdc
	ln -s de1_dac_special.sdc de1_dac.sdc
