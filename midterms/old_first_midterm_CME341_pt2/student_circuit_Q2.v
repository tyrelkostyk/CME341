module student_circuit_Q2 (
          input clk, clear,
          input [7:0] cct_input,
          output reg [7:0] cct_output
			 );

always @ *
if (clear == 1'b1) cct_output = 8'd0;
else if (cct_input[7:4] >= 4'd8) cct_output = cct_input + 8'd57;
else cct_output = cct_input ^ 8'h99;

endmodule 