module program_sequencer(
	input clk, sync_reset, jmp, jmp_nz, dont_jmp, jump_flag,
	input [3:0] jmp_addr,
	output reg [7:0] pm_addr,
	output reg [7:0] from_PS, pc);  // for debugging/testing

// output reg [7:0] pc;
// pc set as output for debugging purposes
reg [3:0] addr_msb;
reg [3:0] addr_lsb;

always @ *
if (jump_flag == 1'b0)
	addr_msb = jmp_addr;
else
	addr_msb = addr_msb;
	
always @ *
if (jump_flag == 1'b1)
	addr_lsb = jmp_addr;
else
	addr_lsb = addr_lsb;

always @ *
from_PS = 8'h00;

always @ (posedge clk)
pc <= pm_addr;

always @ *
if (sync_reset == 1'b1) 
	pm_addr = 8'd0;
else if (jmp == 1'b1) 
//	pm_addr = {jmp_addr, 4'd0};
//	if (jump_flag == 1'b0)
//		pm_addr = {jmp_addr, 4'd0};
//	else
//		pm_addr = {4'd0, jmp_addr};
	pm_addr = {addr_msb, addr_lsb};
else if ((jmp_nz == 1'b1) && (dont_jmp == 1'b0))
//	pm_addr = {jmp_addr, 4'd0};
//	if (jump_flag == 1'b0)
//		pm_addr = {jmp_addr, 4'd0};
//	else
//		pm_addr = {4'd0, jmp_addr};
	pm_addr = {addr_msb, addr_lsb};
else 
	pm_addr = pc + 8'd1;

endmodule
