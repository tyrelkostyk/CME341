
`timescale 1us / 1ns
module final_exam_asm_testing();
reg clk, reset;
reg [3:0] i_pins;

wire [8:0] register_enables;
wire [7:0] pm_address, pm_data;
wire [7:0] 	pc, ir;
wire [7:0] from_PS, from_ID, from_CU; // signals to convey changes
                              // that were made in the program 
                             // sequencer, instruction decoder  
                             // and the computational unit
wire [3:0] x0, x1, y0, y1, r, m, i, dm, o_reg;
wire zero_flag;	
wire NOPC8, NOPCF, NOPD8, NOPDF;

initial #120 $stop;

initial clk = 1'b0;
always #0.5 clk = ~clk;  // 1us clk period for data_memory 

initial 
begin
reset = 1'b0;
#2 reset = 1'b1;
#1 reset = 1'b0;
end

initial i_pins = 4'h1;

micro   micro_1 (
	.clk(clk),
	.reset(reset),
	.i_pins(i_pins),
	.o_reg(o_reg),
	.x0(x0),
	.x1(x1),
	.y0(y0),
	.y1(y1),
	.r(r),
	.zero_flag(zero_flag),
	.m(m),
	.i(i),
	.dm(dm),
	.pm_data(pm_data),
	.pm_address(pm_address),
	.pc(pc),
	.ir(ir),
	.register_enables(register_enables),
	.from_PS(from_PS),
	.from_ID(from_ID),
	.from_CU(from_CU), 
        .NOPC8(NOPC8),  .NOPCF(NOPCF), 
        .NOPD8(NOPD8), .NOPDF(NOPDF)        );


endmodule 