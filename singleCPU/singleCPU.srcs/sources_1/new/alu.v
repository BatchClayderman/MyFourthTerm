`timescale 1ns / 1ps

module alu(
		input [31:0] a, // alu 输入 a 端
		input [31:0] b, // alu 输入 b 端
		input [3:0] op, // alu 运算类型
		output [31:0] f,// alu 运算结果
		output z		//运算结果是否为 0
	);
	reg [31:0] result;   
	always@(*)
		begin
			case(op)
				4'b0000: result = 32'b0;
				4'b0001: result = a + b;
				4'b0010: result = a - b;
				4'b0011: result = a & b;
				4'b0100: result = a | b;
				4'b0101: result = a ^ b;
				4'b0110: result = b << a;
				4'b0111: result = b >> a;
				4'b1000: result = $signed(b) >>> a;//带符号算数右移
				4'b1001: result = $signed(b) <<< a;//带符号算数右移
				default: result = 32'b0;
			endcase
		end	
	assign f = result;
	assign z = ~(|result);//运算结果是否为 0
	initial
		$monitor($time, , "EXE/alu: a = %h, b = %h", a, b);
	initial
		$monitor($time, , "EXE/alu: op = %b", op);
	initial
		$monitor($time, , "EXE/alu: f = %h", f);
endmodule