module second_midterm_quartus   (
input clk, reset,  zero_flag,
output reg sync_reset,
output wire [7:0] pm_address, pm_data,
output wire jump, conditional_jump,
            x_mux_select, y_mux_select, i_mux_select,
output wire [3:0] source_register_select, LS_nibble_of_ir, 
output wire [8:0] register_enables,
output wire [7:0] pc, instr_register,
output wire [7:0] from_ID, from_PS // conduits from prog sequencer and
                                   // and instruction decoder to testbench
                                   // used in second midterm and final exam
                        );

always @ (posedge clk)
sync_reset = reset;

program_memory prog_memory(
	.address(pm_address),
	.clock(~clk),
	.q(pm_data)
	);
	
program_sequencer prog_sequencer (
       .clk(clk),
	    .sync_reset(sync_reset),
       .dont_jmp(zero_flag),
       .jmp(jump),
       .jmp_nz(conditional_jump),
       .jmp_addr(LS_nibble_of_ir), 
       .pm_addr(pm_address),
       .pc(pc), //pc is taken out for purposes of debugging
       .from_PS(from_PS), // conduit to testbench for exams
		 .jmp_count(count_flag)
       );
		 
instruction_decoder inst_decoder( 
           .clk(clk), 
			  .sync_reset(sync_reset),
           .next_instr(pm_data),
           .jmp(jump),
           .jmp_nz(conditional_jump),
           .ir_nibble(LS_nibble_of_ir),
           .i_sel(i_mux_select),
           .y_sel(y_mux_select),
           .x_sel(x_mux_select),
           .source_sel(source_register_select),
           .reg_en(register_enables),
           .ir(instr_register), // ir is taken out for purposes of debugging
           .from_ID(from_ID), // conduit to testbench for exams
			  .counter_flag(count_flag)
           );

													
endmodule 
