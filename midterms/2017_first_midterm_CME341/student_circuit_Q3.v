module student_circuit_Q3 (
          input clk, clear,
          input [7:0] cct_input,
          output reg [7:0] cct_output
			 );

reg [7:0] reg1, reg2, reg3, adder_out;

always @ (posedge clk)
if (clear == 1'b1) reg1 = 8'b11;
else reg1 = cct_input;

always @ (posedge clk)
if (clear == 1'b1) reg2 = 8'b11;
else reg2 = cct_input;

always @ (posedge clk)
if (clear == 1'b1) reg3 = 8'b0;
else reg3 = reg2;

always @ *
adder_out = cct_input + 8'd17;

always @ *
cct_output = (reg3 ^ (reg1^adder_out));

endmodule
