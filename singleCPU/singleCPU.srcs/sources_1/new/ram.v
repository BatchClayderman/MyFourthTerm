`timescale 1ns / 1ps

module ram(
		input clk,
		input ce,				//片选信号
		input [3:0] addr,		//操作地址（4位）
		input [31:0] wdata,		//写入数据
		input we,				//写入信号
		output reg [31:0] rdata	//读出数据
	);
	reg [31:0] ramdata[0:15];	//地址长度为 4 位对应 16 个内存单元	
	always @(posedge clk)		//写端口
	begin
		#2
		if ((we == 1'b1) && (ce == 1'b0))//可写且已选中
		begin
			ramdata[addr] <= wdata;//写入数据
			$display($time, , "MEM/IOManager/ram: write %h to Ram %h", wdata, addr);
		end
	end
	always @(*)//读端口
	begin
		if (ce == 1'b1)//未选中状态
			rdata = 32'bz;
		else//选中状态
		begin
			rdata = ramdata[addr];//读出数据
			$display($time, , "MEM/IOManager/ram: read Ram %h -> data = %h", addr, rdata);
		end
	end
endmodule