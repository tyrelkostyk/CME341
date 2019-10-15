module program_sequencer_Q11(clk, sync_reset, pm_addr, jmp, jmp_nz, jmp_addr, dont_jmp, 
								pc, from_PS, NOPD8, count_flag);
input clk, sync_reset, jmp,jmp_nz, dont_jmp, NOPD8;
input [3:0] jmp_addr;
output reg count_flag;
output reg [7:0] pc, pm_addr, from_PS;

reg [1:0] counter;

always @ *
if (sync_reset)
	count_flag = 1'b0;
else if ((NOPD8 == 1'b1) && (counter < 2'd2))
	count_flag = 1'b1;
else
	count_flag = 1'b0;

always @ (posedge clk)
if (sync_reset)
	counter = 2'd0;
else if ((NOPD8 == 1'b1) && (counter != 2'd2))
	counter = counter + 2'd1;
else if (counter == 2'd2)
	counter = 2'd0;
else
	counter = counter;

always @ *
from_PS = 8'h0;

always @ (posedge clk)
if ((NOPD8 == 1'b1) && (counter < 2'd2))
	pc <= pc;
else
	pc <= pm_addr;

always @ *
if (sync_reset == 1'b1)
	pm_addr <= 8'h00;
else if ((NOPD8 == 1'b1) && (counter < 2'd2))
	pm_addr <= pm_addr; // same as having pc + 1
else if (jmp == 1'b1)
	pm_addr <= {jmp_addr,4'h0};
else if ((jmp_nz == 1'b1) && (dont_jmp == 1'b0))
	pm_addr <= {jmp_addr,4'h0};
else
	pm_addr <= pc + 8'b1;

endmodule
