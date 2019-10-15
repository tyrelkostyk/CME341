module program_sequencer(
	input clk, sync_reset, jmp, jmp_nz, dont_jmp,
	input NOPC8, NOPCF, NOPD8, NOPDF,		// inputs; will probably need in exam
	input [3:0] jmp_addr,
//	input [3:0] x0, x1,
	input [7:0] ir,  //q5
	output reg [7:0] pm_addr,
	output reg [7:0] pc,			// made output for final exam (instead of internal)
	output reg [7:0] from_PS			// made specifically for final exam scrambler
	);


always @ *
from_PS = 8'h0;  // in exam
//from_PS = pc;		// testing prior to exam

always @ (posedge clk)
pc <= pm_addr;

//reg jsr;
//always @ (posedge clk)
//if (ir[7:5] == 3'b000)
//	jsr = 1'b1;
//else
//	jsr = 1'b0;
//	
//reg x_sel;
//always @ (posedge clk)
//if (ir[4] == 1'b1)
//	x_sel = 1'b1;
//else
//	x_sel = 1'b0;

reg [7:0] return_addr;
always @ (posedge clk)
if (sync_reset == 1'b1) 
	return_addr = 8'd0;
else if (ir[7:5] == 3'b000) 
	return_addr = pc + 8'd1;
else
	return_addr = return_addr;


always @ *
if (sync_reset == 1'b1) 
	pm_addr = 8'd0;
else if (NOPC8)
	pm_addr = return_addr;
else if (ir[7:5] == 3'b000)  		//jsr
	pm_addr = {ir[4:0], 3'b000};
else if (jmp == 1'b1) 
	pm_addr = {jmp_addr, 4'd0};
else if ((jmp_nz == 1'b1) && (dont_jmp == 1'b0)) 
	pm_addr = {jmp_addr, 4'd0};
else 
	pm_addr = pc + 8'd1;

endmodule
