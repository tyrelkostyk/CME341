onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /data_memory_testbench/clk
add wave -noupdate /data_memory_testbench/clk_in
add wave -noupdate -radix hexadecimal /data_memory_testbench/addr
add wave -noupdate -radix hexadecimal /data_memory_testbench/data
add wave -noupdate /data_memory_testbench/wren
add wave -noupdate -radix hexadecimal /data_memory_testbench/q
add wave -noupdate -radix hexadecimal /data_memory_testbench/count
add wave -noupdate /data_memory_testbench/result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1896832 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {10500 ns}
