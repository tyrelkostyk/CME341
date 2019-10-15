module micro (
	input clk, reset,
	input [3:0] i_pins,
	output [3:0] o_reg);

wire [8:0] reg_enables;
wire [7:0] pm_data, pm_address;
wire [3:0] LS_nibble_ir, source_select, data_mem_addr, data_bus, dm;
wire jump, conditional_jump, i_mux_select, y_reg_select, x_reg_select, zero_flag;
reg sync_reset;

always @ (posedge clk)
sync_reset = reset;

program_memory prog_mem(
	.clock(~clk),
	.address(pm_address),
	.q(pm_data));

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
	.reg_en(reg_enables));


program_sequencer prog_sequencer(
	.clk(clk),
	.sync_reset(sync_reset),
	.pm_addr(pm_address),
	.jmp(jump),
	.jmp_nz(conditional_jump),
	.jmp_addr(LS_nibble_ir),
	.dont_jmp(zero_flag));


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
	.reg_en(reg_anables),
	.i(data_mem_addr),
	.data_bus(data_bus),
	.dm(dm),
	.o_reg(o_reg));

data_memory data_mem(
	.clock(~clk),
	.address(data_mem_addr),
	.data(data_bus),
	.q(dm),
	.wren(reg_enables[7]));


	
endmodule

	
	