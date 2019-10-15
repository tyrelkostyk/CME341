onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /final_exam_testbench/clk
add wave -noupdate /final_exam_testbench/reset
add wave -noupdate -color {Steel Blue} -itemcolor Black -radix hexadecimal /final_exam_testbench/seed
add wave -noupdate -color {Steel Blue} -itemcolor Black -radix hexadecimal /final_exam_testbench/accumulator_output
add wave -noupdate -color Khaki -itemcolor Khaki -radix hexadecimal /final_exam_testbench/pm_address
add wave -noupdate -color {Medium Aquamarine} -itemcolor {Medium Aquamarine} -radix hexadecimal /final_exam_testbench/pm_data
add wave -noupdate -color Gold -height 25 -itemcolor Gold -radix hexadecimal /final_exam_testbench/pc
add wave -noupdate -color Cyan -height 25 -itemcolor Cyan -radix hexadecimal /final_exam_testbench/ir
add wave -noupdate -color Gray70 -itemcolor Grey70 -radix hexadecimal /final_exam_testbench/from_PS
add wave -noupdate -color Gray70 -itemcolor Grey70 -radix hexadecimal /final_exam_testbench/from_ID
add wave -noupdate -radix unsigned /final_exam_testbench/watch_dog
add wave -noupdate /final_exam_testbench/sync_reset
add wave -noupdate -color Red /final_exam_testbench/flag5
add wave -noupdate -color Orange /final_exam_testbench/flag4
add wave -noupdate -color Gold /final_exam_testbench/flag3
add wave -noupdate -color Yellow /final_exam_testbench/flag2
add wave -noupdate -color Yellow /final_exam_testbench/flag1
add wave -noupdate -color Blue -radix binary /final_exam_testbench/NOPC8
add wave -noupdate -color Gray70 -itemcolor Grey70 -radix hexadecimal /final_exam_testbench/from_CU
add wave -noupdate -radix hexadecimal /final_exam_testbench/x0
add wave -noupdate -radix hexadecimal /final_exam_testbench/x1
add wave -noupdate -radix hexadecimal /final_exam_testbench/y0
add wave -noupdate -radix hexadecimal /final_exam_testbench/y1
add wave -noupdate -color Green -itemcolor Green -radix hexadecimal /final_exam_testbench/r
add wave -noupdate -color Green -itemcolor Green -radix hexadecimal /final_exam_testbench/zero_flag
add wave -noupdate -radix hexadecimal /final_exam_testbench/m
add wave -noupdate -radix hexadecimal /final_exam_testbench/i
add wave -noupdate -color Blue -itemcolor Blue -radix hexadecimal /final_exam_testbench/o_reg
add wave -noupdate -radix binary /final_exam_testbench/NOPCF
add wave -noupdate -radix binary /final_exam_testbench/NOPD8
add wave -noupdate -radix binary /final_exam_testbench/NOPDF
add wave -noupdate -radix hexadecimal /final_exam_testbench/register_enables
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {273435301 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 58
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
WaveRestoreZoom {262796839 ps} {295266071 ps}
