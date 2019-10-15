module program_sequencer(
	input clk, sync_reset, jmp, jmp_nz, dont_jmp,
	input NOPC8, NOPCF, NOPD8, NOPDF,		// instr's from ID to load loop_count & loop_length_minus_1
	input [3:0] jmp_addr,
	input [3:0] x0, r,	// from CU
	output reg [7:0] pm_addr,
	output reg [7:0] pc,			// made output for final exam (instead of internal)
	output reg [7:0] from_PS			// made specifically for final exam scrambler
	);


always @ *
from_PS = {loop_length_minus_1, loop_count};  // in exam
//from_PS = pc;		// testing prior to exam

always @ (posedge clk)
pc <= pm_addr;		// addr of current instruction (executed on next rising clk edge)


reg [3:0] loop_count, loop_length_minus_1, start_addr, end_addr;
reg ir_eq_end_addr, loop_count_neq_0, jump_again;

// loop_count
always @ (posedge clk)
if (sync_reset == 1'b1)
	loop_count = 4'h0;
else if (NOPCF == 1'b1)
	loop_count = r;  // load loop_count
else if (jump_again == 1'b1)
	loop_count = loop_count - 4'h1;  // decrement loop_count
else
	loop_count = loop_count;

// loop_length_minus_1
always @ (posedge clk)
if (sync_reset == 1'b1)
	loop_length_minus_1 = 4'h0;
else if (NOPC8 == 1'b1)
	loop_length_minus_1 = x0;
else
	loop_length_minus_1 = loop_length_minus_1;

// start_addr
always @ (posedge clk)
if (sync_reset == 1'b1)
	start_addr = 4'h0;
else if (NOPCF == 1'b1)
	start_addr = pc+1;
else
	start_addr = start_addr;

// end_addr
always @ *
end_addr = loop_length_minus_1 + start_addr;

// ir_eq_end_addr
always @ *
if (pc == end_addr)
	ir_eq_end_addr = 1'b1; // current instr is last one in loop
else
	ir_eq_end_addr = 1'b0; // current ir is still in loop (or outside of loop)

// loop_count_neq_0
always @ *
if (loop_count != 4'h0)
	loop_count_neq_0 = 1'b1; // keep jumping & executing loop
else
	loop_count_neq_0 = 1'b0; // loop_count == 0, i.e. don't jump anymore

// jump_again
always @ *
if ((ir_eq_end_addr == 1'b1) && (loop_count_neq_0))
	jump_again = 1'b1; // jump to start_addr, & decrement loop_count
else
	jump_again = 1'b0; // don't derement loop_count (either leave alone or load from r), and pm_addr = pc+1




// next_addr logic
always @ *
if (sync_reset == 1'b1) 
	pm_addr = 8'd0;
else if (jmp == 1'b1) 
	pm_addr = {jmp_addr, 4'd0};
else if ((jmp_nz == 1'b1) && (dont_jmp == 1'b0)) 
	pm_addr = {jmp_addr, 4'd0};
else if (jump_again == 1'b1)
	pm_addr = start_addr;
else 
	pm_addr = pc + 8'd1;		// next addr logic

endmodule
