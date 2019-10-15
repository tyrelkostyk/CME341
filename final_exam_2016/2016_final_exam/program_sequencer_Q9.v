module program_sequencer_Q9(clk, sync_reset, pm_address_big, jmp, jmp_nz, jmp_addr, dont_jmp, 
								pc_big, from_PS);
input clk, sync_reset, jmp,jmp_nz, dont_jmp;
input [3:0] jmp_addr;
output reg [7:0] from_PS;
output reg [9:0] pc_big, pm_address_big;

always @ *
from_PS = pc_big[9:2];

always @ (posedge clk)
pc_big <= pm_address_big;

always @ *
if (sync_reset == 1'b1)
	pm_address_big <= 10'h00;
else if (jmp == 1'b1)
	pm_address_big <= {jmp_addr,6'h0};
else if ((jmp_nz == 1'b1) && (dont_jmp == 1'b0))
	pm_address_big <= {2'h0,jmp_addr,4'h0};
else
	pm_address_big <= pc_big + 10'b1;

endmodule
