module student_circuit_Q2 (
          input clk, clear,
          input [7:0] cct_input,
          output reg [7:0] cct_output
			 );

always @ *
if (clear == 1'b1) cct_output = 8'd0;
else if (cct_input[7:4] == 4'b11) cct_output = ~cct_input;
else if (cct_input[7] == 1'b1) 
cct_output = {7'd0,cct_input[7]} + {7'd0,cct_input[6]} + {7'd0,cct_input[5]} + {7'd0,cct_input[4]} + {7'd0,cct_input[3]} + {7'd0,cct_input[2]} + {7'd0,cct_input[1]} + {7'd0,cct_input[0]};
else cct_output = cct_input;

endmodule
