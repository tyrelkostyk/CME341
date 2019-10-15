`timescale 1us/1ns
module midterm_1_testbench ();
reg clk, clear;
reg [7:0] seed, exam_dependent_seed;
reg [7:0] stimulus; 
wire [7:0] student_output;
reg counter_full_bar;
reg [15:0] accumulator_output;


reg [7:0] scrambled_output;
reg [7:0] adder_output;
reg [15:0] rotator_output;

// define the length of the simulation
initial #640 $stop;

// set the exam dependent seed

initial exam_dependent_seed = 8'HFF;

// generate the reset

initial begin clear = 1'b1; #5.2 clear = 1'b0;
              #4 clear = 1'b1; #1 clear = 1'b0;
              #200 clear = 1'b1; #0.5 clear = 1'b0; // narrow pulse
                                              // should not clear
        end
initial begin # 320 clear = 1'b1; #5.2 clear = 1'b0;
              #4 clear = 1'b1; #1 clear = 1'b0;
              #200 clear = 1'b1; #0.5 clear = 1'b0; // narrow pulse
                                              // should not clear

        end
 // make the clock
 
 initial clk = 1'b1;
 always #0.5 clk = ~clk; // 1 MHz clock

// seed used in simulation
initial 
     begin seed = 8'HAA;
           #320 seed = exam_dependent_seed;
    end

always @ (posedge clk)  //design the accumulator
if (clear == 1'b1) 
 accumulator_output <= 8'b0;   
else if (counter_full_bar == 0)
  accumulator_output <= accumulator_output;
else
   accumulator_output <= rotator_output;


always @ (posedge clk)  //design the counter
if (clear == 1'b1) 
 stimulus <= 8'b0;   
else if (counter_full_bar == 0)
  stimulus <= stimulus;
else
   stimulus <=
         stimulus + 1'b1;

always @ * //design the rotator
rotator_output = {accumulator_output[14:8], 
          adder_output, accumulator_output[15]};

always @ * //design the adder
adder_output = accumulator_output[7:0]+scrambled_output;

always @ * // design the scrambler (added the extra seed in 2010)
scrambled_output =  seed  ^ student_output;

always @ * // design the counter full dectector
if (& stimulus == 1'b1) // counter is full
		counter_full_bar = 1'b0;
else    counter_full_bar = 1'b1;

/* ***************************
 instantiate the .vo file
 that resulted from the student 
 design
******************************/
 
 student_circuit student_cct_1(
          .clk(clk), .clear(clear),
          .cct_input(stimulus), 
			    .cct_output(student_output)
			          );
endmodule 
