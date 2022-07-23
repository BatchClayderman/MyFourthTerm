`timescale 1ns / 1ps

module MEM(
		input clk,
		input ramWE,// Ram 写入信号
		input [31:0] addr,//操作地址
		input [31:0] wdata,//写入数据
		output [31:0] rdata,//读出数据
		input [3:0] n,//开关输入数据
		output wire [31:0] displaydata// IO 输出数据
	);
	IOManager myio(addr[5:0], wdata, rdata, ramWE, clk, n, displaydata);
endmodule