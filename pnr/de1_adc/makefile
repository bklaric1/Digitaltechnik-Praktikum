SIM_PROJECT_NAME = de1_adc
PROJECT = $(SIM_PROJECT_NAME)

# Prototype Board FPGA family and device settings
# DE1-SOC
FAMILY = "Cyclone V"
DEVICE = 5CSEMA5F31C6
PROGFILEEXT = sof

SOURCE_FILES = ../../src/de1_adc_rtl.vhd 

include ../makefile

# Use the specific sdc file
$(PROJECT).sdc: $(PROJECT)_special.sdc
	ln -s $(PROJECT)_special.sdc $(PROJECT).sdc
