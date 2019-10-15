module computational_unit (
	input clk, sync_reset,
	input NOPC8, NOPCF, NOPD8, NOPDF,		// inputs; will probably need in exam
	input [3:0] source_sel, nibble_ir, i_pins, dm,
	input i_sel, y_sel, x_sel, 
	input [8:0] reg_en,
	input sub_flag,
	output reg [3:0] o_reg, i, 
	output reg [3:0] data_bus,
//	output reg [3:0] x0, x1, y0, y1, m, r, alu_out // set as outputs for testbench
	output reg [7:0] from_CU,					// for final exam scrambler
	output reg [3:0] x0, x1, y0, y1, m, r, // for final exam scrambler,
	output reg r_eq_0 							// for final exam scrambler (zero_flag)
	);


always @ *
from_CU = {y0_s, x0_s};		// during exam
//from_CU = {x1, x0};	// debugging prior to exam

//// 4-bit pm_data
reg [3:0] pm_data;

always @ *
pm_data = nibble_ir;


// o_reg
always @ *
if (sub_flag)
	o_reg = o_reg_s;
else if (!sub_flag)
	o_reg = o_reg_m;
else
	o_reg = o_reg;


//// 4-bit data registers
reg [3:0] x0_s, y0_s, o_reg_m, o_reg_s;  

// x0
always @ (posedge clk)
if ( (reg_en[0] == 1'b1) && (!sub_flag) )
	x0 = data_bus;
else
	x0 = x0;

// x0_s
always @ (posedge clk)
if (sync_reset == 1'b1)
	x0_s = 4'h0;
else if ( (reg_en[0] == 1'b1) && (sub_flag) )
	x0_s = data_bus;
else
	x0_s = x0_s;

	
// x1
always @ (posedge clk)
if (reg_en[1] == 1'b1)
	x1 = data_bus;
else
	x1 = x1;

// y0
always @ (posedge clk)
if ( (reg_en[2] == 1'b1) && (!sub_flag) )
	y0 = data_bus;
else
	y0 = y0;

// y0_s
always @ (posedge clk)
if (sync_reset == 1'b1)
	y0_s = 4'h0;
else if ( (reg_en[2] == 1'b1) && (sub_flag) )
	y0_s = data_bus;
else
	y0_s = y0_s;


// y1
always @ (posedge clk)
if (reg_en[3] == 1'b1)
	y1 = data_bus;
else
	y1 = y1;

// m
always @ (posedge clk)
if (reg_en[5] == 1'b1)
	m = data_bus;
else
	m = m;
	
// i
always @ (posedge clk)
if (reg_en[6] == 1'b1)
	if (i_sel == 1'b0) i = data_bus;
	else i = i + m;
else
	i = i;

// o_reg_m
always @ (posedge clk)
if ( (reg_en[8] == 1'b1) && (!sub_flag) )
	o_reg_m = data_bus;
else
	o_reg_m = o_reg_m;

// o_reg_s
always @ (posedge clk)
if (sync_reset == 1'b1)
	o_reg_s = 4'h0;
else if ( (reg_en[8] == 1'b1) && (sub_flag) )
	o_reg_s = data_bus;
else
	o_reg_s = o_reg_s;


//// 4-bit data_bus output
always @ *
case(source_sel)
	4'd00: 
		if (sub_flag)
			data_bus = x0_s;			// alt data reg
		else
			data_bus = x0;				// data reg
	4'b01: data_bus = x1;		// data reg
	4'd02: 
		if (sub_flag)
			data_bus = y0_s;			// alt data reg
		else
			data_bus = y0;				// data reg
	4'd03: data_bus = y1;		// data reg
	4'd04: data_bus = r;			// result reg
	4'd05: data_bus = m;			// data reg
	4'd06: data_bus = i;			// data reg
	4'd07: data_bus = dm;		// input
	4'd08: data_bus = pm_data;	// input, from nibble_ir
	4'd09: data_bus = i_pins;	// input
	default: data_bus = 4'h0;	// source_sel 10 & above is empty
endcase




//// ALU Circuit

// ALU instruction
reg [2:0] alu_func;

always @ *
alu_func = nibble_ir[2:0];


// ALU inputs (x, y)
reg [3:0] x, y;

// x
always @ *
if (x_sel == 1'b0) 
	if (sub_flag)
		x = x0_s;
	else
		x = x0;
else x = x1;

// y
always @ *
if (y_sel == 1'b0)
	if (sub_flag)
		y = y0_s;
	else
		y = y0;
else y = y1;


// ALU logic

// x*y multiplication
reg [7:0] x_mult_y;  // largest val is 15*15=225 (8 bits required)

always @ *
x_mult_y = x * y;

//alu_out
reg [3:0] alu_out;  // comment out to set as output for testbench

always @ *
if (sync_reset == 1'b1)
	alu_out = 4'h0;				// reset, clear the alu result
else if ( (alu_func == 3'h0) && (nibble_ir[3] == 1'b0) )
	alu_out = -x;					// 2's compliment of x (set zero_flag if x == 0)
else if (alu_func == 3'h1)
	alu_out = x - y;				// r = x - y
else if (alu_func == 3'h2)
	alu_out = x + y;				// r = x + y
else if (alu_func == 3'h3)
	alu_out = x_mult_y[7:4];	// r = (MS Nibble of) x * y
else if (alu_func == 3'h4)
	alu_out = x_mult_y[3:0];	// r = (LS Nibble of) x * y
else if (alu_func == 3'h5)
	alu_out = x^y;					// r = x ^ y
else if (alu_func == 3'h6)
	alu_out = x&y;					// r = x & y
else if ( (alu_func == 3'h7) && (nibble_ir[3] == 1'b0) )
	alu_out = ~x;					// 1's compliment of x (set zero_flag if x == 4'hF)

	// no-operation instructions
else if ( (alu_func == 3'h0) && (nibble_ir[3] == 1'b1) )
	alu_out = r;		// no operation (also no-op on zero_flag)
else if ( (alu_func == 3'h7) && (nibble_ir[3] == 1'b1) )
	alu_out = r;		// no operation (also no-op on zero_flag)
else
	alu_out = r;


// ALU result registers
//reg [3:0] r;  // commented to set r as output for testbench/final exam

// r
always @ (posedge clk)
if (sync_reset == 1'b1)
	r = 4'd0;
else if (reg_en[4] == 1'b1)
	r = alu_out;
else
	r = r;

// r_eq_0 (zero_flag), output
always @ (posedge clk)
if (sync_reset == 1'b1)
	r_eq_0 = 1'b1;
else if ((reg_en[4] == 1'b1) && (alu_out == 4'd0))
	r_eq_0 = 1'b1;
else if ((reg_en[4] == 1'b1) && (alu_out != 4'd0))
	r_eq_0 = 1'b0;
else
	r_eq_0 = r_eq_0;


endmodule
