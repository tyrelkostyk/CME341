module program_sequencer_Q8(clk, sync_reset, pm_addr, jmp, jmp_nz, jmp_addr, dont_jmp, 
								pc, from_PS, y0, y1, NOPCF);
input clk, sync_reset, jmp,jmp_nz, dont_jmp, NOPCF;
input [3:0] jmp_addr, y0, y1;
output reg [7:0] pc, pm_addr, from_PS;

reg loop;
reg [7:0] start_addr, end_addr;

always @ (posedge clk)
if (sync_reset)
	loop = 1'b0;
else if (NOPCF)
	loop = 1'b1;
else
	loop = loop;

always @ (posedge clk)
if (sync_reset)
	start_addr = 8'd0;
else if (NOPCF)
	start_addr = pc + 8'd1;
else
	start_addr = start_addr;

always @ *
end_addr = start_addr + 8'h3;
	
always @ *
from_PS = 8'h0;

always @ (posedge clk)
pc <= pm_addr;

always @ *
if (sync_reset == 1'b1)
	pm_addr <= 8'h00;
else if ((loop == 1'b1) && (pc == end_addr) && (y0 < y1))
	pm_addr <= start_addr;
else if ((loop == 1'b1) && (pc == end_addr) && (y0 >= y1))
	pm_addr <= pc + 8'd1;
else if (jmp == 1'b1)
	pm_addr <= {jmp_addr,4'h0};
else if ((jmp_nz == 1'b1) && (dont_jmp == 1'b0))
	pm_addr <= {jmp_addr,4'h0};
else
	pm_addr <= pc + 8'b1;

endmodule
