create_clock -period 20.000 -name CLOCK_50 CLOCK_50
set_input_delay -clock CLOCK_50 2 [all_inputs]
set_output_delay -clock CLOCK_50 2 [all_outputs]
