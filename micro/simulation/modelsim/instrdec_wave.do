onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /instruction_decoder_testbench/clk
add wave -noupdate /instruction_decoder_testbench/conditional_jump
add wave -noupdate /instruction_decoder_testbench/correct_output_vector
add wave -noupdate /instruction_decoder_testbench/i_mux_select
add wave -noupdate /instruction_decoder_testbench/instr_reg
add wave -noupdate /instruction_decoder_testbench/load_or_mov_instrucion
add wave -noupdate /instruction_decoder_testbench/output_vector
add wave -noupdate -color {Medium Orchid} -itemcolor {Medium Orchid} /instruction_decoder_testbench/output_vector_comparison
add wave -noupdate /instruction_decoder_testbench/output_vector_delayed
add wave -noupdate /instruction_decoder_testbench/pm_data
add wave -noupdate /instruction_decoder_testbench/pm_data_delayed_1
add wave -noupdate /instruction_decoder_testbench/pm_data_delayed_2
add wave -noupdate /instruction_decoder_testbench/register_enables
add wave -noupdate /instruction_decoder_testbench/source_register_select
add wave -noupdate /instruction_decoder_testbench/test_inst_decoder_ram
add wave -noupdate /instruction_decoder_testbench/unconditional_jump
add wave -noupdate /instruction_decoder_testbench/we
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
configure wave -namecolwidth 183
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {966 ps}
