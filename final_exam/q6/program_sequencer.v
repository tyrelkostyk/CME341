module program_sequencer(
	input clk, sync_reset, jmp, jmp_nz, dont_jmp,
	input NOPC8, NOPCF, NOPD8, NOPDF,		// inputs; will probably need in exam
	input [3:0] jmp_addr,
	output reg [7:0] pm_addr,
	output reg [7:0] pc,			// made output for final exam (instead of internal)
	output reg [7:0] from_PS			// made specifically for final exam scrambler
	);


always @ *
from_PS = counter;  // in exam
//from_PS = pc;		// testing prior to exam

// counter
reg [7:0] counter;
always @ (posedge clk)
if (sync_reset)
	counter = 8'd02;
else if (counter == 8'd0)
	if (reset_count == 4'd0)			// no prev resets - this is the first
		counter = 8'd6;
	else if (reset_count == 4'd1)		// one prev reset - this is the 2nd
		counter = 8'd8;
	else										// third or higher reset
		counter = 8'd255;
else
	counter = counter - 8'd1;

// reset_count
reg [3:0] reset_count;
always @ (posedge clk)
if (sync_reset)
	reset_count = 4'd0;
else if (counter == 8'd0)
	reset_count = reset_count + 4'd1;
else
	reset_count = reset_count;

// interrupt pulse
reg interrupt;
always @ *
if (counter == 8'd0)
	interrupt = 1'b1;
else
	interrupt = 1'b0;


always @ (posedge clk)
pc <= pm_addr;

// return_addr
reg [7:0] return_addr;
always @ (posedge clk)
if (sync_reset == 1'b1) 
	return_addr = 8'd0;
else if (counter == 8'd0) 
	return_addr = pc + 8'd1;
else
	return_addr = return_addr;


always @ *
if (sync_reset == 1'b1) 
	pm_addr = 8'd0;
else if (NOPC8)
	pm_addr = return_addr;
else if (interrupt)
	if (reset_count == 4'd0)
		pm_addr = 8'h71;
	else
		pm_addr = 8'h82;
else if (jmp == 1'b1) 
	pm_addr = {jmp_addr, 4'd0};
else if ((jmp_nz == 1'b1) && (dont_jmp == 1'b0)) 
	pm_addr = {jmp_addr, 4'd0};
else 
	pm_addr = pc + 8'd1;

endmodule
