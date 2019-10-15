module student_circuit_Q1 (
          input clk, clear,
          input [7:0] cct_input,
          output reg [7:0] cct_output
			 );

reg [2:0] count;

always @ (posedge clk)
if (clear == 1'b1) count = 3'd0;
else if (count == 3'b111) count = 3'd0;
else count = count + 3'b001;

always @ (posedge clk)
if (clear == 1'b1) cct_output = 8'd0;
else if (count < 3'd5) cct_output = cct_input;
else cct_output = ~cct_input;

endmodule
