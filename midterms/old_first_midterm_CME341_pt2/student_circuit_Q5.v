module student_circuit_Q5 (
          input clk, clear,
          input [7:0] cct_input,
          output reg [7:0] cct_output
			 );

reg [7:0] Y;

always @ (posedge clk)
case({cct_input[7],cct_input[0]})
2'b00: Y = 8'h12;
2'b01: Y = 8'h34;
2'b10: Y = 8'h56;
2'b11: Y = 8'h78;
endcase

always @ (posedge clk)
if (cct_input[2] == 1'b1) cct_output = 8'hff;
else cct_output = Y;

endmodule
