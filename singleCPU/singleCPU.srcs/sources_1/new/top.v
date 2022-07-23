`timescale 1ns / 1ps

module top(
		input clk,
		input rst,
		input [3:0] n,
		output [11:0] result
	);
	
	wire [31:0] out;
	CPU mycpu(clk, rst, n, out);//สตภýปฏ CPU
	assign result = out[11:0];
endmodule