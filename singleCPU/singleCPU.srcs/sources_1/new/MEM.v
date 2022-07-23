`timescale 1ns / 1ps

module MEM(
		input clk,
		input ramWE,// Ram д���ź�
		input [31:0] addr,//������ַ
		input [31:0] wdata,//д������
		output [31:0] rdata,//��������
		input [3:0] n,//������������
		output wire [31:0] displaydata// IO �������
	);
	IOManager myio(addr[5:0], wdata, rdata, ramWE, clk, n, displaydata);
endmodule