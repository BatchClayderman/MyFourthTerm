`timescale 1ns / 1ps

module registers(
		input clk,
		input oc,					//片选信号
		input [4:0] raddr1,			//读出地址 1
		input [4:0] raddr2,			//读出地址 2
		input [4:0] waddr,			//写入地址
		input [31:0] wdata,			//写入数据
		input we,		   			//可写信号
		output reg [31:0] rdata1,	//读出数据 1
		output reg [31:0] rdata2	//读出数据 2
	);
	reg [31:0] regts[1:31];// $0 号寄存器只能存放 0
	always @(posedge clk)//写端口
	begin
		#3
		if ((we == 1'b1) && (waddr != 5'b00000))//可写且目标非 $0 号寄存器
		begin
			regts[waddr] <= wdata;//写入数据
			$display($time, , "WB/reg: write %h to Reg %h", wdata, waddr);
		end
	end		  
	always @(*)//读端口 1
	begin
		if (oc == 1'b1)//禁止输出
			rdata1 = 32'bz;
		else if (raddr1 == 5'b00000)// $0 号寄存器只保存 0
			rdata1 = 32'b0;
		else
			rdata1 = regts[raddr1];//正常输出数据
		$monitor($time, , "WB/reg: read Reg %h -> data1 = %h", raddr1, rdata1);
	end
	always @(*)//读端口 2
	begin
		if (oc == 1'b1)//禁止输出
			rdata2 = 32'bz;
		else if (raddr2 == 5'b00000)// $0 号寄存器只保存 0
			rdata2 = 32'b0;
		else
			rdata2 = regts[raddr2];//正常输出数据
		$monitor($time, , "WB/reg: read Reg %h -> data2 = %h", raddr2, rdata2);
	end  
endmodule