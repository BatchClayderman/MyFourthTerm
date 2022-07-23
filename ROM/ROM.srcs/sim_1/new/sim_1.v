`timescale 1ns / 1ps

module sim1(

	);
	reg clk = 0;
	reg reset = 1;
	wire [11:0] res;
	always #10 clk = ~clk;
	initial #50 reset = 0;
	top tes(reset, clk, res);
endmodule