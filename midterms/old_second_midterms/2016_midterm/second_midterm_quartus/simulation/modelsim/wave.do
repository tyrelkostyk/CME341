onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /second_midterm_testbench/seed
add wave -noupdate -radix hexadecimal /second_midterm_testbench/accumulator_output
add wave -noupdate /second_midterm_testbench/counter_full_bar
add wave -noupdate /second_midterm_testbench/clk
add wave -noupdate /second_midterm_testbench/reset
add wave -noupdate /second_midterm_testbench/sync_reset
add wave -noupdate -color Blue -itemcolor Blue -radix hexadecimal /second_midterm_testbench/stimulus
add wave -noupdate /second_midterm_testbench/zero_flag
add wave -noupdate /second_midterm_testbench/jump
add wave -noupdate /second_midterm_testbench/conditional_jump
add wave -noupdate -radix hexadecimal /second_midterm_testbench/pm_address
add wave -noupdate /second_midterm_testbench/i_mux_select
add wave -noupdate -radix hexadecimal /second_midterm_testbench/source_register_select
add wave -noupdate -radix hexadecimal /second_midterm_testbench/register_enables
add wave -noupdate -color Goldenrod -itemcolor Goldenrod -radix hexadecimal /second_midterm_testbench/instr_register
add wave -noupdate -color Goldenrod -itemcolor Goldenrod -radix hexadecimal /second_midterm_testbench/pc
add wave -noupdate -radix hexadecimal /second_midterm_testbench/pm_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 165
configure wave -valuecolwidth 40
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
WaveRestoreZoom {0 ps} {19995702 ps}
