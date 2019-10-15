
`timescale 1 us / 1 ns
module data_memory_testbench ();
	// inputs to data memory
	reg [3:0] addr, data;
	reg wren, clk;
	// outputs 
	wire [3:0] q;

initial #7.5 $stop;

initial clk = 1'b0;
always #0.25 clk = ~clk;  // 0.5us clk period for data_memory

reg clk_in;
initial clk_in = 1'b0;
always #0.5 clk_in = ~clk_in;  // 1us clk period for count (testbench)

reg [3:0] count;
initial count = 4'h0;
always @ (posedge clk_in)
if (count == 4'h7)  // 3 cases (including setup)
#0.005 count <= 4'b0000; // hold count for 5 ns
			// after clock edge to model
			// a hardware counter
else
#0.005 count <= count + 4'h1; // hold count for 5 ns
			// after clock edge to model
			// a hardware counter

reg result; // 0 if ever incorrect

always @ *
case (count)
4'h0:
	// clear everything
	begin
	addr = 4'h0;
	data = 4'h0;
	wren = 1'b0;
	if (q == 4'h0) result = 1'b1;  // RAM should be completely empty
	else result = 1'b0;
	end
4'h1:
	// try writing w/out wren (write enable)
	begin
	addr = 4'h0;
	data = 4'hA;
	wren = 1'b0;
	#0.3;
	if (q == 4'h0) result = 1'b1;  // RAM should still be completely empty
	else result = 1'b0;
	end
4'h2:
	// start filling RAM with data
	begin
	addr = 4'h0;
	data = 4'hA;
	wren = 1'b1;
	#0.3;
	if (q == 4'hA) result = 1'b1;  // RAM addr 0x0 should contain 4'hA
	else result = 1'b0;
	end
4'h3:
	// start filling RAM with data
	begin
	addr = 4'h1;
	data = 4'hB;
	wren = 1'b1;
	#0.3;
	if (q == 4'hB) result = 1'b1;  // RAM addr 0x1 should contain 4'hB
	else result = 1'b0;
	end
4'h4:
	// start filling RAM with data
	begin
	addr = 4'h5;
	data = 4'hF;
	wren = 1'b1;
	#0.3;
	if (q == 4'hF) result = 1'b1;  // RAM addr 0x5 should contain 4'hF
	else result = 1'b0;
	end
4'h5:
	// start only reading q - no setting data
	begin
	addr = 4'h0;
	data = 4'h0;
	wren = 1'b0;
	if (q == 4'hA) result = 1'b1;  // RAM addr 0x0 should contain 4'hA
	else result = 1'b0;
	end
4'h6:
	// read data at addr 0x01
	begin
	addr = 4'h1;
	if (q == 4'hB) result = 1'b1;  // RAM addr 0x1 should contain 4'hB
	else result = 1'b0;
	end
4'h7:
	// read data at addr 0x05
	begin
	addr = 4'h5;
	if (q == 4'hF) result = 1'b1;  // RAM addr 0x5 should contain 4'hF
	else result = 1'b0;
	end
default:
	// this should never happen - clear everything
	begin
	addr = 4'h0;
	data = 4'h0;
	wren = 1'b0;
	result = 1'b0;
	end
endcase

data_memory data_mem(
	.address(addr),
	.data(data),
	.clock(clk),
	.wren(wren),
	.q(q)
	);


endmodule







