module student_circuit (
          input clk, clear,
          input [7:0] cct_input,
//			 output reg [7:0] cct_output  // for the preamble
          output [7:0] cct_output  // for the answers
			 );

/*
  always @ *
         if (clear)
			   cct_output  = 8'H0; 
			else	
            cct_output  = cct_input;
*/			 

// student_circuit_Q2 the_cct(			 
// student_circuit_Q3 the_cct(	
// student_circuit_Q4 the_cct(		
 student_circuit_Q5 the_cct(			 	 
          .clk(clk), .clear(clear),
          .cct_input(cct_input),
          .cct_output(cct_output) );

  
endmodule
