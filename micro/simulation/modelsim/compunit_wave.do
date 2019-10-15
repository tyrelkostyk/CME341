onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /computational_unit_testbench/clk
add wave -noupdate -label {Comp Unit clk} /computational_unit_testbench/clk2
add wave -noupdate /computational_unit_testbench/sync_reset
add wave -noupdate -color Red -radix hexadecimal /computational_unit_testbench/correct_output_vector
add wave -noupdate -color Red -radix hexadecimal /computational_unit_testbench/output_vector
add wave -noupdate -color Magenta /computational_unit_testbench/output_vector_compare
add wave -noupdate -radix decimal /computational_unit_testbench/counter
add wave -noupdate /computational_unit_testbench/i_pins
add wave -noupdate /computational_unit_testbench/i_sel
add wave -noupdate /computational_unit_testbench/y_sel
add wave -noupdate /computational_unit_testbench/x_sel
add wave -noupdate /computational_unit_testbench/source_sel
add wave -noupdate /computational_unit_testbench/reg_en
add wave -noupdate -radix hexadecimal /computational_unit_testbench/nibble_ir
add wave -noupdate -color Blue /computational_unit_testbench/data_bus
add wave -noupdate -color Blue /computational_unit_testbench/dm
add wave -noupdate -color Blue /computational_unit_testbench/i
add wave -noupdate -color Blue /computational_unit_testbench/m
add wave -noupdate -color Blue /computational_unit_testbench/o_reg
add wave -noupdate -color Blue /computational_unit_testbench/r
add wave -noupdate -color Blue /computational_unit_testbench/r_eq_0
add wave -noupdate -color Blue /computational_unit_testbench/x0
add wave -noupdate -color Blue /computational_unit_testbench/x1
add wave -noupdate -color Blue /computational_unit_testbench/y0
add wave -noupdate -color Blue /computational_unit_testbench/y1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors
quietly wave cursor active 0
configure wave -namecolwidth 177
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {105 us}
