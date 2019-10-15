module Computational_unit_Q14(clk, sync_reset, r_eq_0, i_pins, ir_nibble, 
									i_sel, y_sel, x_sel, source_sel, reg_en,
									i, data_bus, dm, o_reg, from_CU,
									x0, x1, y0, y1, r, m
									);
						
input clk, sync_reset, i_sel, x_sel, y_sel;
input [3:0] i_pins, dm, source_sel, ir_nibble;
input [8:0] reg_en;
output reg r_eq_0;
output reg [3:0] i, o_reg, data_bus;
output reg [3:0] x0, x1, y0, y1, r, m;
output reg [7:0] from_CU;

reg alu_out_eq_0;
reg [2:0] alu_function;
reg [3:0] x, y, pm_data, i_mux, alu_out;
reg [7:0] alu_xy;

always @ *
from_CU = {x1, x0};

always @ *
pm_data = ir_nibble;

always @ *
alu_function = ir_nibble[2:0];

always @ *
case(source_sel)
	4'd0:	data_bus = x0;
	4'd1:	data_bus = x1;
	4'd2:	data_bus = y0;
	4'd3:	data_bus = y1;
	4'd4:	data_bus = r;
	4'd5:	data_bus = m;
	4'd6:	data_bus = i;
	4'd7:	data_bus = dm;
	4'd8:	data_bus = pm_data;
	4'd9:	data_bus = i_pins;
	4'd10:data_bus = 4'h0;
	4'd11:data_bus = 4'h0;
	4'd12:data_bus = 4'h0;
	4'd13:data_bus = 4'h0;
	4'd14:data_bus = 4'h0;
	4'd15:data_bus = 4'h0;
endcase

always @ (posedge clk)
if (reg_en[6] == 1'b1)
	i = i_mux;
else
	i = i;
	
always @ *
case(i_sel)
	1'd0:	i_mux = data_bus;
	1'd1:	i_mux = i + m;
endcase

always @ (posedge clk)
if (reg_en[5] == 1'b1)
	m = data_bus;
else
	m = m;

always @ (posedge clk)
if (reg_en[8] == 1'b1)
	o_reg = data_bus;
else
	o_reg = o_reg;
	
always @ (posedge clk)
if (reg_en[0] == 1'b1)
	x0 = data_bus;
else
	x0 = x0;
	
always @ (posedge clk)
if (reg_en[1] == 1'b1)
	x1 = data_bus;
else
	x1 = x1;
	
always @ (posedge clk)
if (reg_en[2] == 1'b1)
	y0 = data_bus;
else
	y0 = y0;
	
always @ (posedge clk)
if (reg_en[3] == 1'b1)
	y1 = data_bus;
else
	y1 = y1;
	
always @ *
case(x_sel)
	1'b0:	x = x0;
	1'b1:	x = x1;
endcase

always @ *
case(y_sel)
	1'b0:	y = y0;
	1'b1:	y = y1;
endcase

always @ (posedge clk)
if (reg_en[4] == 1'b1)
	r_eq_0 = alu_out_eq_0;
else
	r_eq_0 = r_eq_0;
	
always @ (posedge clk)
if (reg_en[4] == 1'b1)
	r = alu_out;
else
	r = r;
	
always @ *
alu_xy = x*y;
	
always @ *
if (sync_reset == 1'b1)
	alu_out = 4'h0;
else if ((alu_function == 3'b000) && (ir_nibble[3] == 1'b0))
	alu_out = -x;
else if ((alu_function == 3'b000) && (ir_nibble[3] == 1'b1))
	alu_out = r;
else if (alu_function == 3'b001)
	alu_out = x - y;
else if (alu_function == 3'b010)
	alu_out = x + y;
else if (alu_function == 3'b011)
	alu_out = alu_xy[7:4];
else if (alu_function == 3'b100)
	alu_out = alu_xy[3:0];
else if (alu_function == 3'b101)
	alu_out = x^y;
else if (alu_function == 3'b110)
	alu_out = x&y;
else if ((alu_function == 3'b111) && (ir_nibble[3] == 1'b0))
	alu_out = ~x;
else if ((alu_function == 3'b111) && (ir_nibble[3] == 1'b1))
	alu_out = r;
else
	alu_out = r;
		
always @ *
if (sync_reset == 1'b1)
	alu_out_eq_0 = 1'b1;
else if (alu_out == 4'h0)
	alu_out_eq_0 = 1'b1;
else
	alu_out_eq_0 = 1'b0;
		
endmodule
