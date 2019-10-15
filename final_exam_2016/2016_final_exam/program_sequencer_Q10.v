module program_sequencer_Q10(clk, sync_reset, pm_addr, jmp, jmp_nz, jmp_addr, dont_jmp, 
								pc, from_PS, ir, data_bus);
input clk, sync_reset, jmp,jmp_nz, dont_jmp;
input [3:0] jmp_addr, data_bus;
input [7:0] ir;
output reg [7:0] pc, pm_addr, from_PS;

reg [2:0] loop_count;
reg [7:0] start_addr, end_addr;

always @ (posedge clk)
if (sync_reset)
	loop_count = 8'd0;
else if (ir[7:4] == 4'd3)
	loop_count = data_bus;
else if ((pc == end_addr) && (loop_count != 3'd0))
	loop_count = loop_count - 8'd1;
else
	loop_count = loop_count;
	
always @ (posedge clk)
if (sync_reset)
	start_addr = 8'd0;
else if (ir[7:4] == 4'd3)
	start_addr = pc + 8'd1;
else
	start_addr = start_addr;
	
always @ *
end_addr = start_addr + 8'd2;

always @ *
from_PS = {4'h0, loop_count};

always @ (posedge clk)
pc <= pm_addr;

always @ *
if (sync_reset == 1'b1)
	pm_addr <= 8'h00;
else if ((pc == end_addr) && (loop_count != 8'd0))
	pm_addr <= start_addr;
else if ((pc == end_addr) && (loop_count == 8'd0))
	pm_addr <= pc + 8'd1;
else if (jmp == 1'b1)
	pm_addr <= {jmp_addr,4'h0};
else if ((jmp_nz == 1'b1) && (dont_jmp == 1'b0))
	pm_addr <= {jmp_addr,4'h0};
else
	pm_addr <= pc + 8'b1;

endmodule
