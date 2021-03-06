`timescale 1 us / 1 ns
module computational_unit_testbench ();
	wire[3:0] o_reg, data_bus, i, x0, y0, x1, y1, r, m; // pulled out all registers for debugging
	wire r_eq_0;
	reg clk;
	wire [3:0] alu_out;
	reg [3:0] i_pins, dm, source_sel, nibble_ir;
	reg i_sel, x_sel, y_sel, sync_reset;
	reg [7:0] reg_en;
	reg [36:0] output_vector, correct_output_vector, output_vector_compare;
	reg [15:0] counter; // used to move to the next case
	reg clk2;

	// clock for the comp unit
	initial
	clk2 = 1'b0;
	always
	#0.25 clk2 = ~clk2; // run fast so that inputs are clocked in before next comparison

	initial
	#100 $stop;


	//***** Clock ********
	initial
	clk = 1'b0;
	always
	#0.5 clk = ~clk;
	//********************

	//***** Output Vector *******

	always @(*)
		output_vector = {o_reg, data_bus, i, x0, x1, y0, y1, r, m, r_eq_0};
	
	//***************************

	//******* Output Compare *****

	always @(posedge clk)
		output_vector_compare = output_vector ~^ correct_output_vector; // sets to all one if they match
	//*****************************

	//********* input cases *******
	initial
	counter = 16'd0;
	always @(posedge clk)
		if (counter == 16'd34)
			#2 counter = 16'd0;
		else
			#2 counter = counter + 16'd1;

	always @(*)
		case (counter)
		16'd0: // clear everything
			begin
			sync_reset = 1'b1;
			reg_en = 8'hFF;
			source_sel = 4'd10;
			i_pins = 4'd0;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'd0;
			correct_output_vector = 37'd1;
			end
		16'd1: // write to x0
			begin
			sync_reset = 1'b0;
			reg_en = 8'h01;
			source_sel = 4'd9;
			i_pins = 4'd5;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'd0;
			correct_output_vector = 37'b0000_0101_0000_0101_0000_0000_0000_0000_0000_1;
			end
		16'd2: // write to x1
			begin
			sync_reset = 1'b0;
			reg_en = 8'h02;
			source_sel = 4'd9;
			i_pins = 4'd1;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'd0;
			correct_output_vector = 37'b0000_0001_0000_0101_0001_0000_0000_0000_0000_1;
			end
		16'd3: // write to y0
			begin
			sync_reset = 1'b0;
			reg_en = 8'h04;
			source_sel = 4'd9;
			i_pins = 4'd10;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'd0;
			correct_output_vector = 37'b0000_1010_0000_0101_0001_1010_0000_0000_0000_1;
			end
		16'd4: // write to y1
			begin
			sync_reset = 1'b0;
			reg_en = 8'h08; // one bit at a time
			source_sel = 4'd9;
			i_pins = 4'd4;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'd0;
			correct_output_vector = 37'b0000_0100_0000_0101_0001_1010_0100_0000_0000_1;
			end
		16'd5: // Add x0 and y0
			begin
			sync_reset = 1'b0;
			reg_en = 8'h10; // one bit at a time
			source_sel = 4'd9;
			i_pins = 4'd4;
			dm = 4'd0;
			i_sel = 1'b1;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'b0010;
			correct_output_vector = 37'b0000_0100_0000_0101_0001_1010_0100_1111_0000_0;
			end
		16'd6: // write to the m reg 
			begin
			sync_reset = 1'b0;
			reg_en = 8'h20; // one bit at a time
			source_sel = 4'd9;
			i_pins = 4'd2;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b1;
			y_sel = 1'b0;
			nibble_ir = 4'b0000;
			correct_output_vector = 37'b0000_0010_0000_0101_0001_1010_0100_1111_0010_0;
			end 
		16'd7: // write to the i reg 
			begin
			sync_reset = 1'b0;
			reg_en = 8'h40; // one bit at a time
			source_sel = 4'd9;
			i_pins = 4'd6;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'b0000;
			correct_output_vector = 37'b0000_0110_0110_0101_0001_1010_0100_1111_0010_0;
			end
		16'd8: // write to the o reg 
			begin
			sync_reset = 1'b0;
			reg_en = 8'h80; // one bit at a time
			source_sel = 4'd9;
			i_pins = 4'd15;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b1;
			nibble_ir = 4'b1000;
			correct_output_vector = 37'b1111_1111_0110_0101_0001_1010_0100_1111_0010_0;
			end
		16'd9: // write from x0 to o_reg 
			begin
			sync_reset = 1'b0;
			reg_en = 8'h80; // one bit at a time
			source_sel = 4'd0;
			i_pins = 4'd15;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'b0000;
			correct_output_vector = 37'b0101_0101_0110_0101_0001_1010_0100_1111_0010_0;
			end
		16'd10: // write from x1 to o oreg
			begin
			sync_reset = 1'b0;
			reg_en = 8'h80; // one bit at a time
			source_sel = 4'd1;
			i_pins = 4'd15;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'b0000;
			correct_output_vector = 37'b0001_0001_0110_0101_0001_1010_0100_1111_0010_0;
			end
		16'd11: // write from y0 to o reg
			begin
			sync_reset = 1'b0;
			reg_en = 8'h80; // one bit at a time
			source_sel = 4'd2;
			i_pins = 4'd15;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'b0000;
			correct_output_vector = 37'b1010_1010_0110_0101_0001_1010_0100_1111_0010_0;
			end
		16'd12: // write from y1 to o reg
			begin
			sync_reset = 1'b0;
			reg_en = 8'h80; // one bit at a time
			source_sel = 4'd3;
			i_pins = 4'd15;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'b0000;
			correct_output_vector = 37'b0100_0100_0110_0101_0001_1010_0100_1111_0010_0;
			end
		16'd13: // write from r to o reg
			begin
			sync_reset = 1'b0;
			reg_en = 8'h80; // one bit at a time
			source_sel = 4'd4;
			i_pins = 4'd15;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'b0000;
			correct_output_vector = 37'b1111_1111_0110_0101_0001_1010_0100_1111_0010_0;
			end
		16'd14: // write from m to o reg
			begin
			sync_reset = 1'b0;
			reg_en = 8'h80; // one bit at a time
			source_sel = 4'd5;
			i_pins = 4'd15;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'b0000;
			correct_output_vector = 37'b0010_0010_0110_0101_0001_1010_0100_1111_0010_0;
			end
		16'd15: // write from i to o reg
			begin
			sync_reset = 1'b0;
			reg_en = 8'h80; // one bit at a time
			source_sel = 4'd6;
			i_pins = 4'd15;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'b0000;
			correct_output_vector = 37'b0110_0110_0110_0101_0001_1010_0100_1111_0010_0;
			end
		16'd16: // write from dm to o reg
			begin
			sync_reset = 1'b0;
			reg_en = 8'h80; // one bit at a time
			source_sel = 4'd7;
			i_pins = 4'd15;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'b0000;
			correct_output_vector = 37'b0000_0000_0110_0101_0001_1010_0100_1111_0010_0;
			end
		16'd17: // write from om data to o reg
			begin
			sync_reset = 1'b0;
			reg_en = 8'h80; // one bit at a time
			source_sel = 4'd8;
			i_pins = 4'd15;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'b0001;
			correct_output_vector = 37'b0001_0001_0110_0101_0001_1010_0100_1111_0010_0;
			end
		16'd18: // auto increment i
			begin
			sync_reset = 1'b0;
			i_sel = 1'b1;
			reg_en = 8'h40; // one bit at a time
			#0.3 reg_en = 8'h00; // disable so that i does not keep changing
			source_sel = 4'd8;
			i_pins = 4'd15;
			dm = 4'd0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'b0001;
			correct_output_vector = 37'b0001_0001_1000_0101_0001_1010_0100_1111_0010_0;
			end
		16'd19: // x0 - y0
			begin
			sync_reset = 1'b0;
			reg_en = 8'h10; // one bit at a time
			source_sel = 4'd8;
			i_pins = 4'd15;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'b0001;
			correct_output_vector = 37'b0001_0001_1000_0101_0001_1010_0100_1011_0010_0;
			end
		16'd20: // write 10 to x1 and y1
			begin
			sync_reset = 1'b0;
			reg_en = 8'h0A; // one bit at a time
			source_sel = 4'd9;
			i_pins = 4'd10;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'b0001;
			correct_output_vector = 37'b0001_1010_1000_0101_1010_1010_1010_1011_0010_0;
			end
		16'd21: // x1 * y1 [7:4]
			begin
			sync_reset = 1'b0;
			reg_en = 8'h10; // one bit at a time
			source_sel = 4'd9;
			i_pins = 4'd10;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b1;
			y_sel = 1'b1;
			nibble_ir = 4'b1011;
			correct_output_vector = 37'b0001_1010_1000_0101_1010_1010_1010_0110_0010_0;
			end
		16'd22: // x1 * y1 [3:0]
			begin
			sync_reset = 1'b0;
			reg_en = 8'h10; // one bit at a time
			source_sel = 4'd9;
			i_pins = 4'd5;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b1;
			y_sel = 1'b1;
			nibble_ir = 4'b1100;
			correct_output_vector = 37'b0001_0101_1000_0101_1010_1010_1010_0100_0010_0;
			end
		16'd23: // x1 ^ y0
			begin
			sync_reset = 1'b0;
			reg_en = 8'h10; // one bit at a time
			source_sel = 4'd9;
			i_pins = 4'd5;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b1;
			y_sel = 1'b0;
			nibble_ir = 4'b0101;
			correct_output_vector = 37'b0001_0101_1000_0101_1010_1010_1010_0000_0010_1;
			end
		16'd24: // x0 & y1
			begin
			sync_reset = 1'b0;
			reg_en = 8'h10; // one bit at a time
			source_sel = 4'd9;
			i_pins = 4'd5;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b1;
			nibble_ir = 4'b1110;
			correct_output_vector = 37'b0001_0101_1000_0101_1010_1010_1010_0000_0010_1;
			end
		16'd25: // write 0 to x0
			begin
			sync_reset = 1'b0;
			reg_en = 8'h01; // one bit at a time
			source_sel = 4'd9;
			i_pins = 4'd0;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'b0110;
			correct_output_vector = 37'b0001_0000_1000_0000_1010_1010_1010_0000_0010_1;
			end
		16'd26: // ~x0
			begin
			sync_reset = 1'b0;
			reg_en = 8'h10; // one bit at a time
			source_sel = 4'd9;
			i_pins = 4'd5;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'b0111;
			correct_output_vector = 37'b0001_0101_1000_0000_1010_1010_1010_1111_0010_0;
			end
		16'd27: // write F to x0
			begin
			sync_reset = 1'b0;
			reg_en = 8'h01; // one bit at a time
			source_sel = 4'd9;
			i_pins = 4'd15;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'b0110;
			correct_output_vector = 37'b0001_1111_1000_1111_1010_1010_1010_1111_0010_0;
			end
		16'd28: // ~x0
			begin
			sync_reset = 1'b0;
			reg_en = 8'h10; // one bit at a time
			source_sel = 4'd9;
			i_pins = 4'd5;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'b0111;
			correct_output_vector = 37'b0001_0101_1000_1111_1010_1010_1010_0000_0010_1;
			end
		16'd29: // write F to x1
			begin
			sync_reset = 1'b0;
			reg_en = 8'h02; // one bit at a time
			source_sel = 4'd9;
			i_pins = 4'd15;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'b0110;
			correct_output_vector = 37'b0001_1111_1000_1111_1111_1010_1010_0000_0010_1;
			end
		16'd30: // -x1
			begin
			sync_reset = 1'b0;
			reg_en = 8'h10; // one bit at a time
			source_sel = 4'd9;
			i_pins = 4'd5;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b1;
			y_sel = 1'b0;
			nibble_ir = 4'b0000;
			correct_output_vector = 37'b0001_0101_1000_1111_1111_1010_1010_0001_0010_0;
			end
		16'd31: // write 0 to x1
			begin
			sync_reset = 1'b0;
			reg_en = 8'h02; // one bit at a time
			source_sel = 4'd9;
			i_pins = 4'd0;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b0;
			y_sel = 1'b0;
			nibble_ir = 4'b0110;
			correct_output_vector = 37'b0001_0000_1000_1111_0000_1010_1010_0001_0010_0;
			end
		16'd32: // -x1
			begin
			sync_reset = 1'b0;
			reg_en = 8'h10; // one bit at a time
			source_sel = 4'd9;
			i_pins = 4'd5;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b1;
			y_sel = 1'b0;
			nibble_ir = 4'b0000;
			correct_output_vector = 37'b0001_0101_1000_1111_0000_1010_1010_0000_0010_1;
			end
		16'd33: // test no op for 000
			begin
			sync_reset = 1'b0;
			reg_en = 8'h10; // one bit at a time
			source_sel = 4'd9;
			i_pins = 4'd5;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b1;
			y_sel = 1'b1;
			nibble_ir = 4'b1000;
			correct_output_vector = 37'b0001_0101_1000_1111_0000_1010_1010_0000_0010_1;
			end
		16'd34: // test no op for 111
			begin
			sync_reset = 1'b0;
			reg_en = 8'h10; // one bit at a time
			source_sel = 4'd9;
			i_pins = 4'd5;
			dm = 4'd0;
			i_sel = 1'b0;
			x_sel = 1'b1;
			y_sel = 1'b1;
			nibble_ir = 4'b1111;
			correct_output_vector = 37'b0001_0101_1000_1111_0000_1010_1010_0000_0010_1;
			end

		default
			correct_output_vector = correct_output_vector;
		endcase












	//***** instantiation *******
	computational_unit comp_unit (.o_reg(o_reg),
				      .data_bus(data_bus),
				      .r_eq_0(r_eq_0),
				      .i(i),
				      .x0(x0),
				      .x1(x1),
				      .y0(y0),
				      .y1(y1),
				      .r(r),
				      .m(m),
				      .clk(clk2),
				      .reg_en({reg_en[7], 1'b0, reg_en[6:0]}),  // testbench reg_en[7] = reg_en[8] in comp unit
				      .i_sel(i_sel),
				      .x_sel(x_sel),
				      .y_sel(y_sel),
				      .nibble_ir(nibble_ir),
				      .source_sel(source_sel),
				      .sync_reset(sync_reset),
				      .dm(dm),
				      .i_pins(i_pins),
				      .alu_out(alu_out)
				      );


endmodule
