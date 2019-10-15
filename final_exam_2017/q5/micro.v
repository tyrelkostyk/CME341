module micro (
	input clk, reset,
	input [3:0] i_pins,
	output [3:0] o_reg,
	output [7:0] pm_data,
	output [7:0] pc, from_PS, pm_address,
	output [7:0] ir, from_ID,
	output NOPC8, NOPCF, NOPD8, NOPDF,
	output [8:0] register_enables,
	output [7:0] from_CU,
	output [3:0] x0, x1, y0, y1, r, m, i,
	output zero_flag,
	output sub_flag
	);

//wire [8:0] register_enables;				// made outputs for final exam
//wire [7:0] pm_data, pm_address; 	// made outputs for final exam
wire [3:0] LS_nibble_ir, source_select, data_bus, dm;		// made data_mem_addr = i; made output
wire jump, conditional_jump, i_mux_select, y_reg_select, x_reg_select; //, sub_flag;  // made zero_flag an output for final exam
reg sync_reset;

always @ (posedge clk)
sync_reset = reset;

program_memory prog_mem(
	.clock(~clk),
	.address(pm_address),
	.q(pm_data));


program_sequencer prog_sequencer(
	.clk(clk),
	.sync_reset(sync_reset),
	.pm_addr(pm_address),
	.jmp(jump),
	.jmp_nz(conditional_jump),
	.jmp_addr(LS_nibble_ir),
	.dont_jmp(zero_flag),
	.NOPC8(NOPC8),				// inputs; will probably need in exam
	.NOPCF(NOPCF),
	.NOPD8(NOPD8),
	.NOPDF(NOPDF),
	.pc(pc),
	.sub_flag(sub_flag),
	.from_PS(from_PS)
	);


instruction_decoder intr_decoder(
	.clk(clk),
	.sync_reset(sync_reset),
	.next_instr(pm_data),
	.jmp(jump),
	.jmp_nz(conditional_jump),
	.ir_nibble(LS_nibble_ir),
	.i_sel(i_mux_select),
	.y_sel(y_reg_select),
	.x_sel(x_reg_select),
	.source_sel(source_select),
	.reg_en(register_enables),
	.ir(ir),
	.NOPC8(NOPC8),
	.NOPCF(NOPCF),
	.NOPD8(NOPD8),
	.NOPDF(NOPDF),
	.from_ID(from_ID)
	);


computational_unit comp_unit(
	.clk(clk),
	.i_pins(i_pins),
	.sync_reset(sync_reset),
	.r_eq_0(zero_flag),
	.nibble_ir(LS_nibble_ir),
	.i_sel(i_mux_select),
	.y_sel(y_reg_select),
	.x_sel(x_reg_select),
	.source_sel(source_select),
	.reg_en(register_enables),
	.i(i),						// i = data_mem_addr
	.data_bus(data_bus),
	.dm(dm),
	.o_reg(o_reg),
	.x0(x0),
	.x1(x1),
	.y0(y0),
	.y1(y1),
	.r(r),
	.m(m),
	.NOPC8(NOPC8),				// inputs; will probably need in exam
	.NOPCF(NOPCF),
	.NOPD8(NOPD8),
	.NOPDF(NOPDF),
	.sub_flag(sub_flag),
	.from_CU(from_CU)
	);


data_memory data_mem(
	.clock(~clk),
	.address(i),				// i = data_mem_addr
	.data(data_bus),
	.q(dm),
	.wren(register_enables[7]));


	
endmodule

	
	
