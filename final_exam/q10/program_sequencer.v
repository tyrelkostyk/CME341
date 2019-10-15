module program_sequencer(
	input clk, sync_reset, jmp, jmp_nz, dont_jmp,
	input NOPC8, NOPCF, NOPD8, NOPDF,		// inputs; will probably need in exam
	input [3:0] jmp_addr,
	input [3:0] i, dm,
	input dm_reg_en,
	output reg [7:0] pm_addr,
	output reg [7:0] pc,			// made output for final exam (instead of internal)
	output reg [7:0] from_PS			// made specifically for final exam scrambler
	);


always @ *
from_PS = 8'h0;  // in exam
//from_PS = pc;		// testing prior to exam

always @ (posedge clk)
pc <= pm_addr;

reg [3:0] limit;
// limit
always @ *
limit = 4'h4;

reg [3:0] ix, dm_ix;
// ix
always @ (posedge clk)
if (sync_reset == 1'b1)
	ix = 4'h0;
else if (NOPCF == 1'b1)		// NOPCF is in ir rn, i holds correct value for ix (dm location = 7) 
	ix = i;
else
	ix = ix;

// dm_ix
always @ (posedge clk)
if (sync_reset == 1'b1)
	dm_ix = 4'h0;
else if ((NOPCF == 1'b1) || (dm_reg_en == 1'b1))	// NOPCF or a mov/load dm is being executed atm
	dm_ix = dm;		// either dm is being loaded or the loop is starting; either way, want to update dm_ix
else
	dm_ix = dm_ix;


reg [3:0] start_addr, end_addr;
reg ir_eq_end_addr, dm_ix_lte_limit, jump_again;

// start_addr
always @ (posedge clk)
if (sync_reset == 1'b1)
	start_addr = 4'h0;
else if (NOPCF == 1'b1)
	start_addr = pc+1; 		// NOPCF currently being executed; want next instr addr
else
	start_addr = start_addr;

// end_addr
always @ *
end_addr =  start_addr + 4'd5;	// loop length is 6, so end_addr is start_addr + (6-1)

// ir_eq_end_addr
always @ *
if (pc == end_addr)
	ir_eq_end_addr = 1'b1; // current instr is last one in loop
else
	ir_eq_end_addr = 1'b0; // current ir is still in loop (or outside of loop)

// dm_ix_lte_limit
always @ *
if (dm_ix <= limit)
	dm_ix_lte_limit = 1'b1; // keep jumping & executing loop
else
	dm_ix_lte_limit = 1'b0; // loop_count == 0, i.e. don't jump anymore

// jump_again
always @ *
if ((ir_eq_end_addr == 1'b1) && (dm_ix_lte_limit))		// not done looping, and we're at the end of the loop
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
	pm_addr = pc + 8'd1;

endmodule
