#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {my_clk} -period 1000ns -waveform { 0.000 50.000 } [get_ports clk]



