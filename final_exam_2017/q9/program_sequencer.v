module program_sequencer(
	input clk, sync_reset, jmp, jmp_nz, dont_jmp,
	input NOPC8, NOPCF, NOPD8, NOPDF,		// inputs; will probably need in exam
	input [3:0] jmp_addr,
	input [9:0] jmp_addr_big,
//	output reg [7:0] pm_addr,
//	output reg [7:0] pc,			// made output for final exam (instead of internal)
	output reg [9:0] pc_big, pm_address_big,
	output reg [7:0] from_PS			// made specifically for final exam scrambler
	);


always @ *
from_PS = 8'h0;  // in exam
//from_PS = pc;		// testing prior to exam

always @ (posedge clk)
//pc <= pm_addr;
pc_big <= pm_address_big;

always @ *
if (sync_reset == 1'b1) 
	pm_address_big = 10'd0;
else if (jmp == 1'b1) 
	pm_address_big = jmp_addr_big;
else if ((jmp_nz == 1'b1) && (dont_jmp == 1'b0)) 
	pm_address_big = jmp_addr_big;
else 
	pm_address_big = pc_big + 10'd1;

endmodule
