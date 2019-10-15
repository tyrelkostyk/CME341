module program_sequencer_Q6b(clk, sync_reset, pm_addr, jmp, jmp_nz, jmp_addr, dont_jmp, 
								pc, from_PS, interrupt, isr, NOPDF);
input clk, sync_reset, jmp,jmp_nz, dont_jmp, interrupt, NOPDF;
input [3:0] jmp_addr;
output reg isr;
output reg [7:0] pc, pm_addr, from_PS;

reg [7:0] return_addr;

always @ (posedge clk)
if (sync_reset | NOPDF)
	isr = 1'b0;
else if (interrupt)
	isr = 1'b1;
else
	isr = isr;
	
always @ (posedge interrupt)
if (sync_reset)
	return_addr = 8'd0;
else if (interrupt)
	if (jmp == 1'b1)
		return_addr <= {jmp_addr,4'h0};
	else if ((jmp_nz == 1'b1) && (dont_jmp == 1'b0))
		return_addr <= {jmp_addr,4'h0};
	else
		return_addr <= pc + 8'b1;
else
	return_addr = return_addr;

always @ *
from_PS = 8'h0;

always @ (posedge clk)
pc <= pm_addr;

always @ *
if (sync_reset == 1'b1)
	pm_addr <= 8'h00;
else if (interrupt)
	pm_addr <= 8'hF0;
else if (NOPDF)
	pm_addr <= return_addr;
else if (jmp == 1'b1)
	pm_addr <= {jmp_addr,4'h0};
else if ((jmp_nz == 1'b1) && (dont_jmp == 1'b0))
	pm_addr <= {jmp_addr,4'h0};
else
	pm_addr <= pc + 8'b1;

endmodule
