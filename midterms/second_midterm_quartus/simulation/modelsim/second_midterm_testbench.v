`timescale 1us/1ns
module second_midterm_testbench ();
reg clk, reset;
wire sync_reset;
reg [7:0] seed, exam_dependent_seed;
reg [7:0] stimulus; 
reg counter_full_bar;
reg [15:0] accumulator_output;


reg [7:0] scrambled_output;
reg [7:0] adder_output;
reg [15:0] rotator_output;

reg zero_flag;
wire [7:0] student_scrambler_output;
wire [7:0] pm_address, pm_data;
wire jump, conditional_jump, x_mux_select, y_mux_select, i_mux_select;
wire [3:0]	source_register_select, LS_nibble_of_ir;
wire [8:0]	register_enables;
wire [7:0] 	pc, instr_register;
wire [7:0] 	from_PS, from_ID;
	
// define the length of the simulation
initial #640 $stop;

// set the seed associated with the exam
initial exam_dependent_seed = 8'HF4;

// seed used in simulation
initial 
     begin seed = 8'HAA;
           #320 seed = exam_dependent_seed;
    end


// make the zero flag
initial zero_flag = 1'b0;
always @ *
 zero_flag = stimulus[7] & stimulus[5];



// generate  reset and sync_reset

initial   begin reset = 1'b1; #5.2 reset = 1'b0; end
initial   begin #9.2 reset = 1'b1; #1 reset = 1'b0; end
initial   begin #100.1 reset = 1'b1; #0.2 reset =1'b0; end
initial   begin #320 reset = 1'b1; #5.2 reset = 1'b0; end
initial   begin #329.2 reset = 1'b1; #1 reset = 1'b0; end
initial   begin #420.1 reset = 1'b1; #0.2 reset =1'b0; end


 
 // make the clock
 
 initial clk = 1'b0;
 always #0.5 clk = ~clk; // 1 MHz clock


always @ (posedge clk)  //design the accumulator
                        // make hold time 0.01 microseconds
if (sync_reset == 1'b1) 
  accumulator_output <= #0.01 8'b0;  
else if (counter_full_bar == 0)
 accumulator_output <= #0.01 accumulator_output;
else
 accumulator_output <= #0.01 rotator_output;


always @ (posedge clk)  //design the counter
                        // make hold time 0.01 microseconds
if (sync_reset == 1'b1) 
  stimulus <=  #0.10 8'b0;   
else if (counter_full_bar == 0)
  stimulus <=  #0.01 stimulus;
else
  stimulus <=  #0.01
         stimulus + 8'b1;

always @ * //design the rotator
rotator_output = {accumulator_output[14:8], 
          adder_output, accumulator_output[15]};

always @ * //design the adder
adder_output = accumulator_output[7:0]+scrambled_output;


always @ * // design the counter full dectector
if (& stimulus == 1'b1) // counter is full
		counter_full_bar = 1'b0;
else    counter_full_bar = 1'b1;

/* make the scrambler */
always @ * 
scrambled_output = seed ^ pm_address ^ pc
                   ^ register_enables[7:0]
         ^ {5'b0, jump, conditional_jump, register_enables[8]}
          ^ from_PS ^ from_ID;


/* ***************************
 instantiate the .vo file
 that resulted from the student 
 design
******************************/
 

second_midterm_quartus exam_quartus_1 (
	.clk(clk),
	.reset(reset),
	.sync_reset(sync_reset),
	.zero_flag(zero_flag),
	.pm_address(pm_address),
	.pm_data(pm_data),
	.jump(jump),
	.conditional_jump(conditional_jump),
	.x_mux_select(x_mux_select),
	.y_mux_select(y_mux_select),
	.i_mux_select(i_mux_select),
	.source_register_select(source_register_select),
	.LS_nibble_of_ir(LS_nibble_of_ir),
	.register_enables(register_enables),
	.pc(pc),
	.instr_register(instr_register),
        .from_PS(from_PS), // conduit from prog sequencer
        .from_ID(from_ID)  // conduit from instr decoder
                                     );
endmodule 
