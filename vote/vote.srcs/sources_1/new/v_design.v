`timescale 1ns / 1ps
module biaojue(
	input a, b, c,
	output f
);
	assign f = a & b || b & c || c & a;//ֱ�ӽ����߼�����
endmodule