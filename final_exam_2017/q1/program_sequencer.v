module program_sequencer(
	input clk, sync_reset, jmp, jmp_nz, dont_jmp,
	input NOPC8, NOPCF, NOPD8, NOPDF,
	input [3:0] jmp_addr,
	output reg [7:0] pm_addr,
	output reg [7:0] pc,			// made output for final exam (instead of internal)
	output reg [7:0] from_PS			// made specifically for final exam scrambler
	);


always @ *
from_PS = 8'h0;  // in exam
//from_PS = pc;		// testing prior to exam

reg NOPC8_flag;
always @ (posedge clk)			// ir=NOPC8 the instant NOPC8=1'b1; next clk edge (when executing NOPC8), this flag will read high
if (NOPC8 == 1'b1)
	NOPC8_flag = 1'b1;
else
	NOPC8_flag = 1'b0;

always @ (posedge clk)
pc <= pm_addr;					// ir gets loaded with appropriate instr. at same time

always @ *
if (sync_reset == 1'b1) 
	pm_addr = 8'd0;
else if (NOPC8_flag == 1'b1)
	pm_addr = pc;				// this will be high the instr AFTER NOPC8, aka meaning pm_addr will hold the following instr twice
						// it delays pm_addr (& thus pc) from incrementing for a single clk cycle (aka execute instr. twice)
else if (jmp == 1'b1) 
	pm_addr = {jmp_addr, 4'd0};
else if ((jmp_nz == 1'b1) && (dont_jmp == 1'b0)) 
	pm_addr = {jmp_addr, 4'd0};
else 
	pm_addr = pc + 8'd1;

endmodule
