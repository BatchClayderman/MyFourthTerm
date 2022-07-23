`timescale 1ns / 1ps
module biaojue(
	input a, b, c,
	output f
);
	assign f = a & b || b & c || c & a;//直接进行逻辑运算
endmodule