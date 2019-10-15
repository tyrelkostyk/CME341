module program_sequencer(
	input clk, sync_reset, jmp, jmp_nz, dont_jmp,
	input NOPC8, NOPCF, NOPD8, NOPDF,		// inputs; will probably need in exam
	input [3:0] jmp_addr,
	output reg [7:0] pm_addr,
	output reg [7:0] pc,			// made output for final exam (instead of internal)
	output reg [7:0] from_PS,	// made specifically for final exam scrambler
	output reg sub_flag			// for Q5 - controls use of main reg's or subroutine reg's
	);


always @ *
from_PS = 8'h0;  // in exam
//from_PS = pc;		// testing prior to exam

always @ (posedge clk)
pc <= pm_addr;

reg [7:0] return_addr;
always @ (posedge clk)
if (sync_reset == 1'b1) 
	return_addr = 8'd0;
else if (jmp == 1'b1) 
	return_addr = pc + 8'd1;
else
	return_addr = return_addr;

always @ *
if (sync_reset == 1'b1) 
	pm_addr = 8'd0;
else if (NOPC8)
	pm_addr = return_addr;
else if (jmp == 1'b1) 
	pm_addr = {jmp_addr, 4'd0};
else if ((jmp_nz == 1'b1) && (dont_jmp == 1'b0)) 
	pm_addr = {jmp_addr, 4'd0};
else 
	pm_addr = pc + 8'd1;


always @ (posedge clk)
if (sync_reset)
	sub_flag = 1'b0;
else if (jmp)
	sub_flag = 1'b1;
else if (NOPC8)
	sub_flag = 1'b0;
else
	sub_flag = sub_flag;

endmodule
