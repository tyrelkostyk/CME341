module program_sequencer_Q7(clk, sync_reset, pm_addr, jmp, jmp_nz, jmp_addr, dont_jmp, 
								pc, from_PS, NOPC8, NOPDF);
input clk, sync_reset, jmp,jmp_nz, dont_jmp, NOPC8, NOPDF;
input [3:0] jmp_addr;
output reg [7:0] pc, pm_addr, from_PS;

reg wren;
reg [2:0] TOS_address, next_TOS_address;
reg [7:0] pop_reg;
wire [7:0] q;

always @ (posedge clk)
TOS_address = next_TOS_address;

always @ *
if (sync_reset)
	next_TOS_address = -3'd1;
else if (NOPDF)
	next_TOS_address = TOS_address + 3'd1;
else if ((NOPC8 == 1'b1) && (TOS_address >= 3'd0))
	next_TOS_address = TOS_address - 3'd1;
else
	next_TOS_address = TOS_address;
	
always @ *
wren = NOPDF;

always @ (posedge clk)
if (sync_reset)
	pop_reg = 8'd0;
else if (NOPC8)
	pop_reg = q;
else
	pop_reg = pop_reg;

stack st(.clock(~clk), .data(pc), .rdaddress(next_TOS_address), .wraddress(TOS_address), .wren(wren), .q(q));

always @ *
from_PS = pop_reg;

always @ (posedge clk)
pc <= pm_addr;

always @ *
if (sync_reset == 1'b1)
	pm_addr <= 8'h00;
else if (jmp == 1'b1)
	pm_addr <= {jmp_addr,4'h0};
else if ((jmp_nz == 1'b1) && (dont_jmp == 1'b0))
	pm_addr <= {jmp_addr,4'h0};
else
	pm_addr <= pc + 8'b1;

endmodule
