`timescale 1ns / 1ps

module alu(
		input [31:0] a, // alu ���� a ��
		input [31:0] b, // alu ���� b ��
		input [3:0] op, // alu ��������
		output [31:0] f,// alu ������
		output z		//�������Ƿ�Ϊ 0
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
				4'b1000: result = $signed(b) >>> a;//��������������
				4'b1001: result = $signed(b) <<< a;//��������������
				default: result = 32'b0;
			endcase
		end	
	assign f = result;
	assign z = ~(|result);//�������Ƿ�Ϊ 0
	initial
		$monitor($time, , "EXE/alu: a = %h, b = %h", a, b);
	initial
		$monitor($time, , "EXE/alu: op = %b", op);
	initial
		$monitor($time, , "EXE/alu: f = %h", f);
endmodule