`timescale 1ns / 1ps

module WB(
		input clk,					//时钟信号
		input regWE,				// Reg 写入信号
		input isrt,					//是否写入 rt
		input ram2reg,				// Ram 写入 Reg
		input jal,					//是否 jal 指令
		input lui,					//是否 lui 指令
		input [4:0] rs,				// rs 地址
		input [4:0] rt,				// rt 地址
		input [4:0] rd,				// rd 地址
		input [31:0] f,				// alu 运算结果
		input [31:0] rdata,			// Ram 读出数据
		input [31:0] pc4,			//顺序下一条指令 pc + 4
		input [15:0] immediate,		//立即数
		output wire [31:0] rdata1,	// Reg 读出 rdata1
		output wire [31:0] rdata2 	// Reg 读出 rdata2
	);
	reg oc = 1'b0;// Reg 片选信号
	reg [4:0] wa;// Reg 写入地址
	reg [31:0] wdata;// Reg 写入数据
	always @(posedge clk)
	begin
		#2
		if ((jal == 1'b0) && (lui == 1'b0))//非 jal 或 lui 指令
		begin
			if (regWE == 1'b1)//需要写入寄存器
			begin
				wa <= isrt ? rt : rd;//根据 isrt 写入 rt 或 rd
				wdata <= ram2reg ? rdata : f;
				//根据 ram2reg 写入 ram 读出数据或 alu 运算结果
			end
		end
		else if (jal == 1'b1)//为jal指令
		begin
			wa <= 5'b11111;//将pc+4保存在$31号寄存器
			wdata <= pc4;  //顺序下一条指令地址
		end
		else//为 lui 指令
		begin
			wa <= rt; //将立即数保存在rt的高16位
			wdata <= {immediate, 16'b0};
		end   
	end
	registers myregs(clk, oc, rs, rt, wa, wdata, regWE, rdata1, rdata2);
endmodule