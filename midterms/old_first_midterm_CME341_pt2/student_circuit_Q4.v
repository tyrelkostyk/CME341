module student_circuit_Q4 (
          input clk, clear,
          input [7:0] cct_input,
          output reg [7:0] cct_output
			 );

reg [7:0] delay;

always @ (posedge clk)
if (clear == 1'b1) delay = 8'd0;
else delay = cct_input;

always @ *
cct_output = delay ^ cct_input;

endmodule
