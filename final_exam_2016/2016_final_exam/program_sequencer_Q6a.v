module program_sequencer_Q6a(clk, sync_reset, pm_addr, jmp, jmp_nz, jmp_addr, dont_jmp, 
								pc, from_PS);
input clk, sync_reset, jmp,jmp_nz, dont_jmp;
input [3:0] jmp_addr;
output reg [7:0] pc, pm_addr, from_PS;

always @ *
from_PS = 8'h0;

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
