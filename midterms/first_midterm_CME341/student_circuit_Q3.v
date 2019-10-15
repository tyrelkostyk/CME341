module student_circuit_Q3 (
          input clk, clear,
          input [7:0] cct_input,
          output reg [7:0] cct_output
			 );

reg [7:0] reg1, reg2, adder_out;

always @ (posedge clk)
if (clear == 1'b1) reg1 = 8'b11;
else reg1 = cct_input;

always @ *
if (clear == 1'b1) adder_out = 8'b11 + 8'h22;
else adder_out = cct_input + 8'h22;

always @ (posedge clk)
if (clear == 1'b1) reg2 = 8'h55;
else reg2 = (reg1 ^ adder_out);

always @ *
cct_output = (reg2 ^ reg1);

endmodule
