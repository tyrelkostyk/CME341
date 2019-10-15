`timescale 1us/1ns
module final_exam_testbench ();
reg clk, reset;
reg [7:0] seed, exam_dependent_seed;
reg [7:0] stimulus; 
reg counter_full_bar;
reg [15:0] accumulator_output;


reg [7:0] scrambled_output;
reg [7:0] adder_output;
reg [15:0] rotator_output;


wire [8:0] register_enables;
wire [7:0] pm_address, pm_data;
// wire [8:0]	register_enables;
wire [7:0] 	pc, ir;
wire [7:0] from_PS, from_ID, from_CU; // signals to convey changes
                              // that were made in the program 
                             // sequencer, instruction decoder  
                             // and the computational unit
wire [3:0] x0, x1, y0, y1, r, m, i, o_reg;
wire zero_flag;	
wire NOPC8, NOPCF, NOPD8, NOPDF;

// define the length of the simulation
initial #960 $stop;

//set the exam dependent seed

initial exam_dependent_seed = 8'HFF;

// set the seed 

initial
      begin 
           seed = 8'HAA;
           #640 seed = exam_dependent_seed;
      end

// generate the anwer table
initial
begin
#310 $display(,,); // make a blank line at time 310 us
$display("answer codes: seed, accumlator output");
$display(,,); // make another blank line
$display("%h,%h",seed,accumulator_output);
#320 $display("%h,%h",seed,accumulator_output);
#320 $display("%h,%h",seed,accumulator_output);
$display(,,); // make a blank line at time 630 us
end


// generate the reset

initial 
forever
  begin    reset = 1'b1; #5.2 reset = 1'b0;  
            #3 reset = 1'b1; #1 reset = 1'b0; 
            #8 reset = 1'b1; #0.1 reset = 1'b0; 
            #(320-5.2-3-1-8-0.1) reset =1'b1;
  end



 // make the clock
 
 initial clk = 1'b0;
 always #0.5 clk = ~clk; // 1 MHz clock



always @ (posedge clk)  //design the accumulator
if (reset == 1'b1) 
 accumulator_output <= 8'b0;   
else if (counter_full_bar == 0)
  accumulator_output <= accumulator_output;
else
   accumulator_output <= rotator_output;


always @ (posedge clk)  //design the counter
if (reset == 1'b1) 
 #0.05 stimulus <=  8'b0;   
else if (counter_full_bar == 0)
  #0.05 stimulus <= stimulus;
else
  #0.05 stimulus <= 
         stimulus + 8'b1;

always @ * //design the rotator
rotator_output = {accumulator_output[14:8], 
          adder_output, accumulator_output[15]};

always @ * //design the adder
adder_output = accumulator_output[7:0]+scrambled_output;

always @ * // design the scrambler 
scrambled_output =  seed ^{m,o_reg}^
                    {x1,x0}^{y1,y0}^{3'b0,zero_flag,r}^
                    ir^pc^pm_address^
                    from_PS^from_ID^from_CU;
                    

always @ * // design the counter full dectector
if (& stimulus == 1'b1) // counter is full
		counter_full_bar = 1'b0;
else    counter_full_bar = 1'b1;

/* ***************************
 instantiate the .vo file
 that resulted from the student 
 design
******************************/
micro   micro_1 (
	.clk(clk),
	.reset(reset),
	.i_pins(stimulus[7:4]),
	.o_reg(o_reg),
	.x0(x0),
	.x1(x1),
	.y0(y0),
	.y1(y1),
	.r(r),
	.zero_flag(zero_flag),
	.m(m),
	.i(i),
	.pm_data(pm_data),
	.pm_address(pm_address),
	.pc(pc),
	.ir(ir),
	.register_enables(register_enables),
	.from_PS(from_PS),
	.from_ID(from_ID),
	.from_CU(from_CU), 
        .NOPC8(NOPC8),  .NOPCF(NOPCF), 
        .NOPD8(NOPD8), .NOPDF(NOPDF)        );


endmodule 
