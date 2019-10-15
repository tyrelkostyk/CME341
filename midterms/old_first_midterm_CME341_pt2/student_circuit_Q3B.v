module student_circuit_Q3B (
          input clk, clear,
          input [7:0] cct_input,
          output reg [7:0] cct_output
			 );

reg [3:0] counter_one, counter_two;
 
always @ (posedge clk)
if (clear == 1'b1) counter_one = 4'd0;
else counter_one = counter_one + 4'd1;

always @ (posedge clk)
if (clear == 1'b1) counter_two = 4'd0;
else if (cct_input[7] == 1'b0) counter_two = counter_two + 4'd3;
else if (counter_one == 4'd7) counter_two = counter_two + 4'd1;
else counter_two = counter_two;

always @ *
cct_output = {counter_two,counter_one};

endmodule
