module student_circuit_Q5 (
          input clk, clear,
          input [7:0] cct_input,
          output reg [7:0] cct_output
			 );

always @ *
begin
cct_output = {cct_input >> 2};
cct_output[7:6] = {cct_input[7],cct_input[7]}; 
end

endmodule
