module program_sequencer(
	input clk, sync_reset, jmp, jmp_nz, dont_jmp,
	input NOPC8, NOPCF, NOPD8, NOPDF,		// inputs; will probably need in exam
	input [3:0] jmp_addr,
	input [7:0] pc_q,
	output reg [1:0] head, tail,
	output reg [7:0] pm_addr,
	output reg [7:0] pc,			// made output for final exam (instead of internal)
	output reg [7:0] from_PS			// made specifically for final exam scrambler
	);


always @ *
from_PS = queue_reg;  // in exam
//from_PS = pc;		// testing prior to exam

// queue_reg
reg [7:0] queue_reg;
always @ (posedge clk)
if (sync_reset)
	queue_reg = 8'h0;
else if (NOPD8)
	queue_reg = pc_q;
else queue_reg = queue_reg;


// tail
always @ (posedge clk)
if (sync_reset)
	tail = 2'd0;
else if (NOPC8)
	tail = tail + 2'd1;
else 
	tail = tail;


// head
always @ (posedge clk)
if (sync_reset)
	head = 2'd0;
else if (NOPD8)
	head = head + 2'd1;
else head = head;


always @ (posedge clk)
pc <= pm_addr;

always @ *
if (sync_reset == 1'b1) 
	pm_addr = 8'd0;
else if (jmp == 1'b1) 
	pm_addr = {jmp_addr, 4'd0};
else if ((jmp_nz == 1'b1) && (dont_jmp == 1'b0)) 
	pm_addr = {jmp_addr, 4'd0};
else 
	pm_addr = pc + 8'd1;

endmodule
