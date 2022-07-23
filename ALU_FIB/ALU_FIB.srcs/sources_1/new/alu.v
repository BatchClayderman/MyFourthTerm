`timescale 1ns / 1ps

module alu(
		input [31:0] a,
		input [31:0] b,
		input [3:0] op,
		input [31:0] f,
		output z
	);
	parameter plus =  4'b0001, minus = 4'b0010;//宏定义
	parameter bit_and = 4'b0011, bit_or = 4'b0100, bit_xor = 4'b0101;//宏定义
	
	reg [31:0] result;
	always@(*)
	begin
		case(op)
		4'b0000:
			result = 32'b0;
		plus:
			result = a + b;
		minus:
			result = a - b;
		bit_and:
			result = a & b;
		bit_or:
			result = a | b;
		bit_xor:
			result = a ^ b;
		default:
			result = 32'b0;
		endcase
	end
    
	assign #1 f = result;
	assign #1 z = ~(|result);
    
	initial
		$monitor($time, , "alu: a = %d, b = %d, op = %b", a, b, op); 
	initial
		$monitor($time, , "alu: f = %d, z = %b", f, z);
endmodule