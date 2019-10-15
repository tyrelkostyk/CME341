module Instruction_decoder_Q11(clk, sync_reset, next_instr, jmp, jmp_nz, ir_nibble, i_sel, y_sel, x_sel, source_sel, reg_en,
									ir, from_ID, NOPC8, NOPCF, NOPD8, NOPDF, count_flag);
input clk, sync_reset, count_flag;
input [7:0] next_instr;
output reg jmp, jmp_nz, i_sel, y_sel, x_sel, NOPC8, NOPCF, NOPD8, NOPDF;
output reg [3:0] ir_nibble, source_sel;
output reg [7:0] ir, from_ID;
output reg [8:0] reg_en;

always @ *
from_ID = reg_en[7:0];

always @ *
if (ir == 8'hC8)
	NOPC8 = 1'b1;
else
	NOPC8 = 1'b0;

always @ *
if (ir == 8'hCF)
	NOPCF = 1'b1;
else
	NOPCF = 1'b0;

always @ *
if (ir == 8'hD8)
	NOPD8 = 1'b1;
else
	NOPD8 = 1'b0;

always @ *
if (ir == 8'hDF)
	NOPDF = 1'b1;
else
	NOPDF = 1'b0;

//instruction register
always @ (posedge clk)
if (count_flag)
	ir = ir;
else
	ir = next_instr;

//ir_nibble
always @ *
ir_nibble = ir[3:0];

//////////////////////
// register enables //
//////////////////////

//o_reg
always @ *
if (sync_reset == 1'b1)
	reg_en[8] = 1'b1;
else if (ir[7:4] == 4'd4)
	reg_en[8] = 1'b1;
else if (ir[7:6] == 2'b10)
	if (ir[5:3] == 3'd4)
		reg_en[8] = 1'b1;
	else
		reg_en[8] = 1'b0;
else
	reg_en[8] = 1'b0;	

//dm
always @ *
if (sync_reset == 1'b1)
	reg_en[7] = 1'b1;
else if (ir[7:4] == 4'd7)
	reg_en[7] = 1'b1;
else if (ir[7:6] == 2'b10)
	if (ir[5:3] == 3'd7)
		reg_en[7] = 1'b1;
	else
		reg_en[7] = 1'b0;
else
	reg_en[7] = 1'b0;	

//i
always @ *
if (sync_reset == 1'b1)
	reg_en[6] = 1'b1;
else if ((ir[7:4] == 4'd6) || (ir[7:4] == 4'd7))
	reg_en[6] = 1'b1;
else if (ir[7:6] == 2'b10)
	if (ir[5:3] == 3'd6)
		reg_en[6] = 1'b1;
	else if (ir[5:3] == 3'd7)
		reg_en[6] = 1'b1;
	else if (ir[2:0] == 3'd7)
		reg_en[6] = 1'b1;
	else
		reg_en[6] = 1'b0;
else
	reg_en[6] = 1'b0;

//m
always @ *
if (sync_reset == 1'b1)
	reg_en[5] = 1'b1;
else if (ir[7:4] == 4'd5)
	reg_en[5] = 1'b1;
else if (ir[7:6] == 2'b10)
	if (ir[5:3] == 3'd5)
		reg_en[5] = 1'b1;
	else
		reg_en[5] = 1'b0;
else
	reg_en[5] = 1'b0;
	
//r
always @ *
if (sync_reset == 1'b1)
	reg_en[4] = 1'b1;
else if (ir[7:5] == 3'b110)
	reg_en[4] = 1'b1;
else
	reg_en[4] = 1'b0;

//y1
always @ *
if (sync_reset == 1'b1)
	reg_en[3] = 1'b1;
else if (ir[7:4] == 4'd3)
	reg_en[3] = 1'b1;
else if (ir[7:6] == 2'b10)
	if (ir[5:3] == 3'd3)
		reg_en[3] = 1'b1;
	else
		reg_en[3] = 1'b0;
else
	reg_en[3] = 1'b0;

//y0
always @ *
if (sync_reset == 1'b1)
	reg_en[2] = 1'b1;
else if (ir[7:4] == 4'd2)
	reg_en[2] = 1'b1;
else if (ir[7:6] == 2'b10)
	if (ir[5:3] == 3'd2)
		reg_en[2] = 1'b1;
	else
		reg_en[2] = 1'b0;
else
	reg_en[2] = 1'b0;

//x1
always @ *
if (sync_reset == 1'b1)
	reg_en[1] = 1'b1;
else if (ir[7:4] == 4'd1)
	reg_en[1] = 1'b1;
else if (ir[7:6] == 2'b10)
	if (ir[5:3] == 3'd1)
		reg_en[1] = 1'b1;
	else
		reg_en[1] = 1'b0;
else
	reg_en[1] = 1'b0;	
	
//x0
always @ *
if (sync_reset == 1'b1)
	reg_en[0] = 1'b1;
else if (ir[7:4] == 4'd0)
	reg_en[0] = 1'b1;
else if (ir[7:6] == 2'b10)
	if (ir[5:3] == 3'd0)
		reg_en[0] = 1'b1;
	else
		reg_en[0] = 1'b0;
else
	reg_en[0] = 1'b0;	

/////////////////////

//source_sel
always @ *
if (sync_reset == 1'b1)
	source_sel = 4'd10;
else if (ir[7] == 1'b0)
	source_sel = 4'd8;
else if (ir[7:6] == 2'b10)
	if (ir[2:0] == 3'd4)
		source_sel = 4'd4;
	else if (ir[5:3] == ir[2:0])
		source_sel = 4'd9;
	else
		source_sel = {1'b0,ir[2:0]};
else
	source_sel = {1'b0,ir[2:0]};
	
//////////////////////
// decoding selects //
//////////////////////

//i
always @ *
if (sync_reset == 1'b1)
	i_sel = 1'b0;
else if (ir[7:4] == 4'd6)
	i_sel = 1'b0;
else if (ir[7:6] == 2'b10)
	if (ir[5:3] == 3'd6)
		i_sel = 1'b0;
	else
		i_sel = 1'b1;
else
	i_sel = 1'b1;

//x
always @ *
if (sync_reset == 1'b1)
	x_sel = 1'b0;
else if (ir[7:5] == 3'b110)
	x_sel = ir[4];
else
	x_sel = 1'b0;

//y
always @ *
if (sync_reset == 1'b1)
	y_sel = 1'b0;
else if (ir[7:5] == 3'b110)
	y_sel = ir[3];
else
	y_sel = 1'b0;
	
//////////////////////
// instruction type //
//////////////////////

//jmp
always @ *
if (sync_reset == 1'b1)
	jmp = 1'b0;
else if (ir[7:4] == 4'b1110)
	jmp = 1'b1;
else
	jmp = 1'b0;

//jmp_nz
always @ *
if (sync_reset == 1'b1)
	jmp_nz = 1'b0;
else if (ir[7:4] == 4'b1111)
	jmp_nz = 1'b1;
else
	jmp_nz = 1'b0;
	
endmodule
