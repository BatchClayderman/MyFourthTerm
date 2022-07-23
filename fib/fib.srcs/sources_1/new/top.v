`timescale 1ns / 1ps

module top(
		input clk,
		input rst,
		input [3:0] n,
		output [11:0] result
    );
	wire [31:0] temp;
	fib myfib(.clk(clk),.rst(rst),.n(n),.result(temp));
	assign result = temp [11:0];
endmodule