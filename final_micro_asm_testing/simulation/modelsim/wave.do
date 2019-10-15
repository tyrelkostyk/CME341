onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /final_exam_asm_testing/clk
add wave -noupdate /final_exam_asm_testing/reset
add wave -noupdate -color Orange -radix hexadecimal /final_exam_asm_testing/i_pins
add wave -noupdate -color Blue -radix hexadecimal /final_exam_asm_testing/register_enables
add wave -noupdate -color Blue -radix hexadecimal /final_exam_asm_testing/pm_address
add wave -noupdate -color Blue -radix hexadecimal /final_exam_asm_testing/pm_data
add wave -noupdate -color Cyan -radix hexadecimal /final_exam_asm_testing/pc
add wave -noupdate -color Cyan -radix hexadecimal /final_exam_asm_testing/ir
add wave -noupdate -color Magenta -radix hexadecimal /final_exam_asm_testing/x0
add wave -noupdate -color Magenta -radix hexadecimal /final_exam_asm_testing/x1
add wave -noupdate -color Magenta -radix hexadecimal /final_exam_asm_testing/y0
add wave -noupdate -color Magenta -radix hexadecimal /final_exam_asm_testing/y1
add wave -noupdate -color Red -radix hexadecimal /final_exam_asm_testing/r
add wave -noupdate -color Gold -radix hexadecimal /final_exam_asm_testing/m
add wave -noupdate -color Gold -radix hexadecimal /final_exam_asm_testing/i
add wave -noupdate -color Gold -radix hexadecimal /final_exam_asm_testing/dm
add wave -noupdate -color Red -radix hexadecimal /final_exam_asm_testing/o_reg
add wave -noupdate /final_exam_asm_testing/zero_flag
add wave -noupdate -radix hexadecimal /final_exam_asm_testing/from_PS
add wave -noupdate -radix hexadecimal /final_exam_asm_testing/from_ID
add wave -noupdate -radix hexadecimal /final_exam_asm_testing/from_CU
add wave -noupdate /final_exam_asm_testing/NOPC8
add wave -noupdate /final_exam_asm_testing/NOPCF
add wave -noupdate /final_exam_asm_testing/NOPD8
add wave -noupdate /final_exam_asm_testing/NOPDF
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {357692 ps} 0}
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
WaveRestoreZoom {18037500 ps} {33787500 ps}
