module microprocessor(clk, reset, i_pins, 
							NOPC8, NOPCF, NOPD8, NOPDF, zero_flag,
							o_reg, x0, x1, y0, y1, r, m, i,
							pm_address, pm_data, pc, from_PS, ir, from_ID, from_CU,
							reg_enables);
input clk, reset;
input [3:0] i_pins;
output wire NOPC8, NOPCF, NOPD8, NOPDF, zero_flag;
output reg [3:0] i;
output wire [3:0] o_reg, x0, x1, y0, y1, r, m;
output wire [7:0] pm_data, from_PS, ir, from_ID, from_CU;
output wire [8:0] reg_enables;

output wire [7:0] pm_address, pc;
//output reg [7:0] pm_address, pc;
//wire [9:0] pm_address_big, pc_big;
//always @ *
//pc = pc_big[7:0];
//always @ *
//pm_address = pm_address_big[7:0];

reg sync_reset;
wire jump, conditional_jump, i_mux_select, y_reg_select, x_reg_select, flag, interrupt, isr, jump_flag, alternate_function;
wire [3:0] LS_nibble_ir, data_mem_addr, data_bus, dm, source_select, timer;
wire [7:0] jump_to;

always @ *
i = data_mem_addr;

always @ (posedge clk)
sync_reset <= reset;



///////////////////////////////////////////////////////////////////////////
//							Program Memory												  //
///////////////////////////////////////////////////////////////////////////

////Question 1
//program_memory_Q1 prog_mem(.clock(~clk), .address(pm_address), .q(pm_data));

////Question 2
//program_memory_Q2 prog_mem(.clock(~clk), .address(pm_address), .q(pm_data));

////Question 3
//program_memory_Q3 prog_mem(.clock(~clk), .address(pm_address), .q(pm_data));

////Question 4
//program_memory_Q4 prog_mem(.clock(~clk), .address(pm_address), .q(pm_data));
//
////Question 5
//program_memory_Q5 prog_mem(.clock(~clk), .address(pm_address), .q(pm_data));
//
////Question 6a
//program_memory_Q6a prog_mem(.clock(~clk), .address(pm_address), .q(pm_data));
//
////Question 6b
//program_memory_Q6b prog_mem(.clock(~clk), .address(pm_address), .q(pm_data));
//
////Question 7
//program_memory_Q7 prog_mem(.clock(~clk), .address(pm_address), .q(pm_data));
//
////Question 8
//program_memory_Q8 prog_mem(.clock(~clk), .address(pm_address), .q(pm_data));
//
////Question 9
//program_memory_Q9 prog_mem(.clock(~clk), .address(pm_address_big), .q(pm_data));
//
////Question 10
//program_memory_Q10 prog_mem(.clock(~clk), .address(pm_address), .q(pm_data));
//
////Question 11
//program_memory_Q11 prog_mem(.clock(~clk), .address(pm_address), .q(pm_data));
//
////Question 12
//program_memory_Q12 prog_mem(.clock(~clk), .address(pm_address), .q(pm_data));
//
//Question 13
program_memory_Q13 prog_mem(.clock(~clk), .address(pm_address), .q(pm_data));
//
////Question 14
//program_memory_Q14 prog_mem(.clock(~clk), .address(pm_address), .q(pm_data));



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																	Instruciton Decoder												  							  //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////Question 1
//Instruction_decoder_Q1 instr_decoder(.clk(clk), .sync_reset(sync_reset), .next_instr(pm_data), .jmp(jump), .jmp_nz(conditional_jump),
//												.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select),
//												.x_sel(x_reg_select), .source_sel(source_select), .reg_en(reg_enables),
//												.ir(ir), .from_ID(from_ID), .NOPC8(NOPC8), .NOPCF(NOPCF), .NOPD8(NOPD8), .NOPDF(NOPDF));

////Question 2
//Instruction_decoder_Q2 instr_decoder(.clk(clk), .sync_reset(sync_reset), .next_instr(pm_data), .jmp(jump), .jmp_nz(conditional_jump),
//												.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select),
//												.x_sel(x_reg_select), .source_sel(source_select), .reg_en(reg_enables),
//												.ir(ir), .from_ID(from_ID), .NOPC8(NOPC8), .NOPCF(NOPCF), .NOPD8(NOPD8), .NOPDF(NOPDF));

////Question 3
//Instruction_decoder_Q3 instr_decoder(.clk(clk), .sync_reset(sync_reset), .next_instr(pm_data), .jmp(jump), .jmp_nz(conditional_jump),
//												.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select),
//												.x_sel(x_reg_select), .source_sel(source_select), .reg_en(reg_enables),
//												.ir(ir), .from_ID(from_ID), .NOPC8(NOPC8), .NOPCF(NOPCF), .NOPD8(NOPD8), .NOPDF(NOPDF));

////Question 4
//Instruction_decoder_Q4 instr_decoder(.clk(clk), .sync_reset(sync_reset), .next_instr(pm_data), .jmp(jump), .jmp_nz(conditional_jump),
//												.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select),
//												.x_sel(x_reg_select), .source_sel(source_select), .reg_en(reg_enables),
//												.ir(ir), .from_ID(from_ID), .NOPC8(NOPC8), .NOPCF(NOPCF), .NOPD8(NOPD8), .NOPDF(NOPDF));
//
////Question 5
//Instruction_decoder_Q5 instr_decoder(.clk(clk), .sync_reset(sync_reset), .next_instr(pm_data), .jmp(jump), .jmp_nz(conditional_jump),
//												.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select),
//												.x_sel(x_reg_select), .source_sel(source_select), .reg_en(reg_enables),
//												.ir(ir), .from_ID(from_ID), .NOPC8(NOPC8), .NOPCF(NOPCF), .NOPD8(NOPD8), .NOPDF(NOPDF));
//
////Question 6a
//Instruction_decoder_Q6a instr_decoder(.clk(clk), .sync_reset(sync_reset), .next_instr(pm_data), .jmp(jump), .jmp_nz(conditional_jump),
//												.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select),
//												.x_sel(x_reg_select), .source_sel(source_select), .reg_en(reg_enables),
//												.ir(ir), .from_ID(from_ID), .NOPC8(NOPC8), .NOPCF(NOPCF), .NOPD8(NOPD8), .NOPDF(NOPDF));
//
////Question 6b
//Instruction_decoder_Q6b instr_decoder(.clk(clk), .sync_reset(sync_reset), .next_instr(pm_data), .jmp(jump), .jmp_nz(conditional_jump),
//												.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select),
//												.x_sel(x_reg_select), .source_sel(source_select), .reg_en(reg_enables),
//												.ir(ir), .from_ID(from_ID), .NOPC8(NOPC8), .NOPCF(NOPCF), .NOPD8(NOPD8), .NOPDF(NOPDF));
//
////Question 7
//Instruction_decoder_Q7 instr_decoder(.clk(clk), .sync_reset(sync_reset), .next_instr(pm_data), .jmp(jump), .jmp_nz(conditional_jump),
//												.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select),
//												.x_sel(x_reg_select), .source_sel(source_select), .reg_en(reg_enables),
//												.ir(ir), .from_ID(from_ID), .NOPC8(NOPC8), .NOPCF(NOPCF), .NOPD8(NOPD8), .NOPDF(NOPDF));
//
////Question 8
//Instruction_decoder_Q8 instr_decoder(.clk(clk), .sync_reset(sync_reset), .next_instr(pm_data), .jmp(jump), .jmp_nz(conditional_jump),
//												.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select),
//												.x_sel(x_reg_select), .source_sel(source_select), .reg_en(reg_enables),
//												.ir(ir), .from_ID(from_ID), .NOPC8(NOPC8), .NOPCF(NOPCF), .NOPD8(NOPD8), .NOPDF(NOPDF));
//
////Question 9
//Instruction_decoder_Q9 instr_decoder(.clk(clk), .sync_reset(sync_reset), .next_instr(pm_data), .jmp(jump), .jmp_nz(conditional_jump),
//												.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select),
//												.x_sel(x_reg_select), .source_sel(source_select), .reg_en(reg_enables),
//												.ir(ir), .from_ID(from_ID), .NOPC8(NOPC8), .NOPCF(NOPCF), .NOPD8(NOPD8), .NOPDF(NOPDF));
//
////Question 10
//Instruction_decoder_Q10 instr_decoder(.clk(clk), .sync_reset(sync_reset), .next_instr(pm_data), .jmp(jump), .jmp_nz(conditional_jump),
//												.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select),
//												.x_sel(x_reg_select), .source_sel(source_select), .reg_en(reg_enables),
//												.ir(ir), .from_ID(from_ID), .NOPC8(NOPC8), .NOPCF(NOPCF), .NOPD8(NOPD8), .NOPDF(NOPDF));
//
////Question 11
//Instruction_decoder_Q11 instr_decoder(.clk(clk), .sync_reset(sync_reset), .next_instr(pm_data), .jmp(jump), .jmp_nz(conditional_jump),
//												.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select),
//												.x_sel(x_reg_select), .source_sel(source_select), .reg_en(reg_enables),
//												.ir(ir), .from_ID(from_ID), .NOPC8(NOPC8), .NOPCF(NOPCF), .NOPD8(NOPD8), .NOPDF(NOPDF), .count_flag(count_flag));
//
////Question 12
//Instruction_decoder_Q12 instr_decoder(.clk(clk), .sync_reset(sync_reset), .next_instr(pm_data), .jmp(jump), .jmp_nz(conditional_jump),
//												.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select),
//												.x_sel(x_reg_select), .source_sel(source_select), .reg_en(reg_enables),
//												.ir(ir), .from_ID(from_ID), .NOPC8(NOPC8), .NOPCF(NOPCF), .NOPD8(NOPD8), .NOPDF(NOPDF),
//												.jump_to(jump_to), .jump_flag(jump_flag));
//
//Question 13
Instruction_decoder_Q13 instr_decoder(.clk(clk), .sync_reset(sync_reset), .next_instr(pm_data), .jmp(jump), .jmp_nz(conditional_jump),
												.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select),
												.x_sel(x_reg_select), .source_sel(source_select), .reg_en(reg_enables),
												.ir(ir), .from_ID(from_ID), .NOPC8(NOPC8), .NOPCF(NOPCF), .NOPD8(NOPD8), .NOPDF(NOPDF),
												.alternate_function(alternate_function));
//
////Question 14
//Instruction_decoder_Q14 instr_decoder(.clk(clk), .sync_reset(sync_reset), .next_instr(pm_data), .jmp(jump), .jmp_nz(conditional_jump),
//												.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select),
//												.x_sel(x_reg_select), .source_sel(source_select), .reg_en(reg_enables),
//												.ir(ir), .from_ID(from_ID), .NOPC8(NOPC8), .NOPCF(NOPCF), .NOPD8(NOPD8), .NOPDF(NOPDF));



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																	Program Sequencer 												  							  //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////Question 1
//program_sequencer_Q1 prog_sequencer(.clk(clk), .sync_reset(sync_reset), .pm_addr(pm_address), .jmp(jump), .jmp_nz(conditional_jump),
//											.jmp_addr(LS_nibble_ir), .dont_jmp(zero_flag), .pc(pc), .from_PS(from_PS), .NOPC8(NOPC8));

////Question 2
//program_sequencer_Q2 prog_sequencer(.clk(clk), .sync_reset(sync_reset), .pm_addr(pm_address), .jmp(jump), .jmp_nz(conditional_jump),
//											.jmp_addr(LS_nibble_ir), .dont_jmp(zero_flag), .pc(pc), .from_PS(from_PS));

////Question 3
//program_sequencer_Q3 prog_sequencer(.clk(clk), .sync_reset(sync_reset), .pm_addr(pm_address), .jmp(jump), .jmp_nz(conditional_jump),
//											.jmp_addr(LS_nibble_ir), .dont_jmp(zero_flag), .pc(pc), .from_PS(from_PS));

////Question 4
//program_sequencer_Q4 prog_sequencer(.clk(clk), .sync_reset(sync_reset), .pm_addr(pm_address), .jmp(jump), .jmp_nz(conditional_jump),
//											.jmp_addr(LS_nibble_ir), .dont_jmp(zero_flag), .pc(pc), .from_PS(from_PS));
//
////Question 5
//program_sequencer_Q5 prog_sequencer(.clk(clk), .sync_reset(sync_reset), .pm_addr(pm_address), .jmp(jump), .jmp_nz(conditional_jump),
//											.jmp_addr(LS_nibble_ir), .dont_jmp(zero_flag), .pc(pc), .from_PS(from_PS));
//
////Question 6a
//program_sequencer_Q6a prog_sequencer(.clk(clk), .sync_reset(sync_reset), .pm_addr(pm_address), .jmp(jump), .jmp_nz(conditional_jump),
//											.jmp_addr(LS_nibble_ir), .dont_jmp(zero_flag), .pc(pc), .from_PS(from_PS));
//
////Question 6b
//program_sequencer_Q6b prog_sequencer(.clk(clk), .sync_reset(sync_reset), .pm_addr(pm_address), .jmp(jump), .jmp_nz(conditional_jump),
//											.jmp_addr(LS_nibble_ir), .dont_jmp(zero_flag), .pc(pc), .from_PS(from_PS),
//											.interrupt(interrupt), .isr(isr), .NOPDF(NOPDF));
//
////Question 7
//program_sequencer_Q7 prog_sequencer(.clk(clk), .sync_reset(sync_reset), .pm_addr(pm_address), .jmp(jump), .jmp_nz(conditional_jump),
//											.jmp_addr(LS_nibble_ir), .dont_jmp(zero_flag), .pc(pc), .from_PS(from_PS),
//											.NOPC8(NOPC8), .NOPDF(NOPDF));
//
////Question 8
//program_sequencer_Q8 prog_sequencer(.clk(clk), .sync_reset(sync_reset), .pm_addr(pm_address), .jmp(jump), .jmp_nz(conditional_jump),
//											.jmp_addr(LS_nibble_ir), .dont_jmp(zero_flag), .pc(pc), .from_PS(from_PS),
//											.y0(y0), .y1(y1), .NOPCF(NOPCF));
//
////Question 9
//program_sequencer_Q9 prog_sequencer(.clk(clk), .sync_reset(sync_reset), .pm_address_big(pm_address_big), .jmp(jump), .jmp_nz(conditional_jump),
//											.jmp_addr(LS_nibble_ir), .dont_jmp(zero_flag), .pc_big(pc_big), .from_PS(from_PS));
//
////Question 10
//program_sequencer_Q10 prog_sequencer(.clk(clk), .sync_reset(sync_reset), .pm_addr(pm_address), .jmp(jump), .jmp_nz(conditional_jump),
//											.jmp_addr(LS_nibble_ir), .dont_jmp(zero_flag), .pc(pc), .from_PS(from_PS),
//											.ir(ir), .data_bus(data_bus));
//
////Question 11
//program_sequencer_Q11 prog_sequencer(.clk(clk), .sync_reset(sync_reset), .pm_addr(pm_address), .jmp(jump), .jmp_nz(conditional_jump),
//											.jmp_addr(LS_nibble_ir), .dont_jmp(zero_flag), .pc(pc), .from_PS(from_PS), .NOPD8(NOPD8), .count_flag(count_flag));
//
////Question 12
//program_sequencer_Q12 prog_sequencer(.clk(clk), .sync_reset(sync_reset), .pm_addr(pm_address), .jmp(jump), .jmp_nz(conditional_jump),
//											.jmp_addr(LS_nibble_ir), .dont_jmp(zero_flag), .pc(pc), .from_PS(from_PS),
//											.jump_to(jump_to), .jump_flag(jump_flag));
//
//Question 13
program_sequencer_Q13 prog_sequencer(.clk(clk), .sync_reset(sync_reset), .pm_addr(pm_address), .jmp(jump), .jmp_nz(conditional_jump),
											.jmp_addr(LS_nibble_ir), .dont_jmp(zero_flag), .pc(pc), .from_PS(from_PS));
//
////Question 14
//program_sequencer_Q14 prog_sequencer(.clk(clk), .sync_reset(sync_reset), .pm_addr(pm_address), .jmp(jump), .jmp_nz(conditional_jump),
//											.jmp_addr(LS_nibble_ir), .dont_jmp(zero_flag), .pc(pc), .from_PS(from_PS));



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																	Computational Unit 												  							  //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		

////Question 1
//Computational_unit_Q1 comp_unit(.clk(clk), .sync_reset(sync_reset), .r_eq_0(zero_flag), .i_pins(i_pins),
//										.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select), .x_sel(x_reg_select),
//										.source_sel(source_select), .reg_en(reg_enables), .i(data_mem_addr), .data_bus(data_bus),
//										.dm(dm), .o_reg(o_reg), .from_CU(from_CU), .x0(x0), .x1(x1), .y0(y0), .y1(y1), .r(r), .m(m));

////Question 2
//Computational_unit_Q2 comp_unit(.clk(clk), .sync_reset(sync_reset), .r_eq_0(zero_flag), .i_pins(i_pins),
//										.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select), .x_sel(x_reg_select),
//										.source_sel(source_select), .reg_en(reg_enables), .i(data_mem_addr), .data_bus(data_bus),
//										.dm(dm), .o_reg(o_reg), .from_CU(from_CU), .x0(x0), .x1(x1), .y0(y0), .y1(y1), .r(r), .m(m), .ir(ir));

////Question 3
//Computational_unit_Q3 comp_unit(.clk(clk), .sync_reset(sync_reset), .r_eq_0(zero_flag), .i_pins(i_pins),
//										.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select), .x_sel(x_reg_select),
//										.source_sel(source_select), .reg_en(reg_enables), .i(data_mem_addr), .data_bus(data_bus),
//										.dm(dm), .o_reg(o_reg), .from_CU(from_CU), .x0(x0), .x1(x1), .y0(y0), .y1(y1), .r(r), .m(m),
//										.NOPD8(NOPD8), .NOPDF(NOPDF));

////Question 4
//Computational_unit_Q4 comp_unit(.clk(clk), .sync_reset(sync_reset), .r_eq_0(zero_flag), .i_pins(i_pins),
//										.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select), .x_sel(x_reg_select),
//										.source_sel(source_select), .reg_en(reg_enables), .i(data_mem_addr), .data_bus(data_bus),
//										.dm(dm), .o_reg(o_reg), .from_CU(from_CU), .x0(x0), .x1(x1), .y0(y0), .y1(y1), .r(r), .m(m));
//
////Question 5
//Computational_unit_Q5 comp_unit(.clk(clk), .sync_reset(sync_reset), .r_eq_0(zero_flag), .i_pins(i_pins),
//										.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select), .x_sel(x_reg_select),
//										.source_sel(source_select), .reg_en(reg_enables), .i(data_mem_addr), .data_bus(data_bus),
//										.dm(dm), .o_reg(o_reg), .from_CU(from_CU), .x0(x0), .x1(x1), .y0(y0), .y1(y1), .r(r), .m(m));
//
////Question 6a
//Computational_unit_Q6a comp_unit(.clk(clk), .sync_reset(sync_reset), .r_eq_0(zero_flag), .i_pins(i_pins),
//										.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select), .x_sel(x_reg_select),
//										.source_sel(source_select), .reg_en(reg_enables), .i(data_mem_addr), .data_bus(data_bus),
//										.dm(dm), .o_reg(o_reg), .from_CU(from_CU), .x0(x0), .x1(x1), .y0(y0), .y1(y1), .r(r), .m(m));
//
////Question 6b
//Computational_unit_Q6b comp_unit(.clk(clk), .sync_reset(sync_reset), .r_eq_0(zero_flag), .i_pins(i_pins),
//										.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select), .x_sel(x_reg_select),
//										.source_sel(source_select), .reg_en(reg_enables), .i(data_mem_addr), .data_bus(data_bus),
//										.dm(dm), .o_reg(o_reg), .from_CU(from_CU), .x0(x0), .x1(x1), .y0(y0), .y1(y1), .r(r), .m(m),
//										.interrupt(interrupt), .isr(isr));
//
////Question 7
//Computational_unit_Q7 comp_unit(.clk(clk), .sync_reset(sync_reset), .r_eq_0(zero_flag), .i_pins(i_pins),
//										.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select), .x_sel(x_reg_select),
//										.source_sel(source_select), .reg_en(reg_enables), .i(data_mem_addr), .data_bus(data_bus),
//										.dm(dm), .o_reg(o_reg), .from_CU(from_CU), .x0(x0), .x1(x1), .y0(y0), .y1(y1), .r(r), .m(m));
//
////Question 8
//Computational_unit_Q8 comp_unit(.clk(clk), .sync_reset(sync_reset), .r_eq_0(zero_flag), .i_pins(i_pins),
//										.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select), .x_sel(x_reg_select),
//										.source_sel(source_select), .reg_en(reg_enables), .i(data_mem_addr), .data_bus(data_bus),
//										.dm(dm), .o_reg(o_reg), .from_CU(from_CU), .x0(x0), .x1(x1), .y0(y0), .y1(y1), .r(r), .m(m));
//
////Question 9
//Computational_unit_Q9 comp_unit(.clk(clk), .sync_reset(sync_reset), .r_eq_0(zero_flag), .i_pins(i_pins),
//										.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select), .x_sel(x_reg_select),
//										.source_sel(source_select), .reg_en(reg_enables), .i(data_mem_addr), .data_bus(data_bus),
//										.dm(dm), .o_reg(o_reg), .from_CU(from_CU), .x0(x0), .x1(x1), .y0(y0), .y1(y1), .r(r), .m(m));
//
////Question 10
//Computational_unit_Q10 comp_unit(.clk(clk), .sync_reset(sync_reset), .r_eq_0(zero_flag), .i_pins(i_pins),
//										.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select), .x_sel(x_reg_select),
//										.source_sel(source_select), .reg_en(reg_enables), .i(data_mem_addr), .data_bus(data_bus),
//										.dm(dm), .o_reg(o_reg), .from_CU(from_CU), .x0(x0), .x1(x1), .y0(y0), .y1(y1), .r(r), .m(m));
//
////Question 11
//Computational_unit_Q11 comp_unit(.clk(clk), .sync_reset(sync_reset), .r_eq_0(zero_flag), .i_pins(i_pins),
//										.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select), .x_sel(x_reg_select),
//										.source_sel(source_select), .reg_en(reg_enables), .i(data_mem_addr), .data_bus(data_bus),
//										.dm(dm), .o_reg(o_reg), .from_CU(from_CU), .x0(x0), .x1(x1), .y0(y0), .y1(y1), .r(r), .m(m));
//
////Question 12
//Computational_unit_Q12 comp_unit(.clk(clk), .sync_reset(sync_reset), .r_eq_0(zero_flag), .i_pins(i_pins),
//										.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select), .x_sel(x_reg_select),
//										.source_sel(source_select), .reg_en(reg_enables), .i(data_mem_addr), .data_bus(data_bus),
//										.dm(dm), .o_reg(o_reg), .from_CU(from_CU), .x0(x0), .x1(x1), .y0(y0), .y1(y1), .r(r), .m(m));
//
//Question 13
Computational_unit_Q13 comp_unit(.clk(clk), .sync_reset(sync_reset), .r_eq_0(zero_flag), .i_pins(i_pins),
										.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select), .x_sel(x_reg_select),
										.source_sel(source_select), .reg_en(reg_enables), .i(data_mem_addr), .data_bus(data_bus),
										.dm(dm), .o_reg(o_reg), .from_CU(from_CU), .x0(x0), .x1(x1), .y0(y0), .y1(y1), .r(r), .m(m),
										.alternate_function(alternate_function));
//
////Question 14
//Computational_unit_Q14 comp_unit(.clk(clk), .sync_reset(sync_reset), .r_eq_0(zero_flag), .i_pins(i_pins),
//										.ir_nibble(LS_nibble_ir), .i_sel(i_mux_select), .y_sel(y_reg_select), .x_sel(x_reg_select),
//										.source_sel(source_select), .reg_en(reg_enables), .i(data_mem_addr), .data_bus(data_bus),
//										.dm(dm), .o_reg(o_reg), .from_CU(from_CU), .x0(x0), .x1(x1), .y0(y0), .y1(y1), .r(r), .m(m));



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																	Data Memory		   												  							  //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		

////Question 1
//data_memory_Q1 data_mem(.clock(~clk), .address(data_mem_addr), .data(data_bus), .q(dm), .wren(reg_enables[7]));

////Question 2
//data_memory_Q2 data_mem(.clock(~clk), .address(data_mem_addr), .data(data_bus), .q(dm), .wren(reg_enables[7]));
//
////Question 3
//data_memory_Q3 data_mem(.clock(~clk), .address(data_mem_addr), .data(data_bus), .q(dm), .wren(reg_enables[7]));
//
////Question 4
//data_memory_Q4 data_mem(.clock(~clk), .address(i+m), .data(data_bus), .q(dm), .wren(reg_enables[7]));
//
////Question 5
//data_memory_Q5 data_mem(.clock(~clk), .address(data_mem_addr), .data(data_bus), .q(dm), .wren(reg_enables[7]));
//
////Question 6a
//data_memory_Q6a data_mem(.clock(~clk), .address(data_mem_addr), .data(data_bus), .q(dm), .wren(reg_enables[7]));
//
////Question 6b
//data_memory_Q6b data_mem(.clock(~clk), .address(data_mem_addr), .data(data_bus), .q(dm), .wren(reg_enables[7]));
//
////Question 7
//data_memory_Q7 data_mem(.clock(~clk), .address(data_mem_addr), .data(data_bus), .q(dm), .wren(reg_enables[7]));
//
////Question 8
//data_memory_Q8 data_mem(.clock(~clk), .address(data_mem_addr), .data(data_bus), .q(dm), .wren(reg_enables[7]));
//
////Question 9
//data_memory_Q9 data_mem(.clock(~clk), .address(data_mem_addr), .data(data_bus), .q(dm), .wren(reg_enables[7]));
//
////Question 10
//data_memory_Q10 data_mem(.clock(~clk), .address(data_mem_addr), .data(data_bus), .q(dm), .wren(reg_enables[7]));
//
////Question 11
//data_memory_Q11 data_mem(.clock(~clk), .address(data_mem_addr), .data(data_bus), .q(dm), .wren(reg_enables[7]));
//
////Question 12
//data_memory_Q12 data_mem(.clock(~clk), .address(data_mem_addr), .data(data_bus), .q(dm), .wren(reg_enables[7]));

//Question 13
data_memory_Q13 data_mem(.clock(~clk), .address(data_mem_addr), .data(data_bus), .q(dm), .wren(reg_enables[7]));

////Question 14
//data_memory_Q14 data_mem(.clock(~clk), .address(data_mem_addr), .data(data_bus), .q(dm), .wren(reg_enables[7]));



endmodule
