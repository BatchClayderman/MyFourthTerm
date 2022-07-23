`timescale 1ns / 1ps

module IOManager(
		input [5:0] addr,				//地址
		input [31:0] din,				//内存输入数据
		output [31:0] dout,				//内存或开关获得数据
		input we,						//内存使能端
		input clk,						//时钟信号
		input [3:0] switch,				//开关输入数据
		output reg [31:0] displaydata	// IO 输出数据
	);
	wire [31:0] ramdout;// Ram 读出数据
	wire ramWE;// Ram 写入信号
	wire ce;// Ram 片选信号(值为 0 时选中)
	assign ce = (|addr[5:4]);//既不写入 f(n) 也不访问 n 时选中
	assign dout = addr[5] ? {{28{1'b0}}, switch} : ramdout;//根据第 5 位输出 n 或 Ram 中数据
	assign ramWE = we && (~addr[4]);//不写入 f(n) 且 IO 可写时 Ram 可写
	ram myram(clk, ce, addr[3:0], din, ramWE, ramdout);//实例化 ram
	always @(posedge clk)
	begin
		if ((addr[4] == 1'b1) && we)//若要写入 f(n) 且 IO 可写
			displaydata <= din;//输出 IO 的数据
	end
	initial
		$monitor($time, , "MEM/IOManager: displaydata = %h", displaydata);
endmodule