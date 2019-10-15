module program_sequencer(
	input clk, sync_reset, jmp, jmp_nz, dont_jmp,
	input NOPC8, NOPCF, NOPD8, NOPDF,		// inputs; will probably need in exam
	input [3:0] jmp_addr,
	input [7:0] ir,		// q9
	output reg [7:0] pm_addr,
	output reg [7:0] pc,			// made output for final exam (instead of internal)
	output reg [7:0] from_PS			// made specifically for final exam scrambler
	);


always @ *
from_PS = 8'h0;  // in exam
//from_PS = pc;		// testing prior to exam

always @ (posedge clk)
pc <= pm_addr;

always @ *
if (sync_reset == 1'b1) 
	pm_addr = 8'd0;
else if (ir[7:4] == 4'b0001)
	if (ir[3:0] <= 4'd7)
		pm_addr = pc + {4'h0, ir[3:0]} + 8'd2;
	else
		pm_addr = pc - 8'd18 + {4'h0, ir[3:0]};
else if (jmp == 1'b1) 
	pm_addr = {jmp_addr, 4'd0};
else if ((jmp_nz == 1'b1) && (dont_jmp == 1'b0)) 
	pm_addr = {jmp_addr, 4'd0};
else 
	pm_addr = pc + 8'd1;

endmodule
