`timescale 1ns / 1ps

module CPU(
		input clk,
		input rst,
		input [3:0] n,
		output wire [31:0] result
	);   
	wire [1:0] pcindex;		// pc 来源
	wire [31:0] instrument;	//指令
	wire [31:0] pc4;		//顺序下一条指令 pc + 4
	wire [31:0] f;			// alu 运算结果
	wire [3:0] aluOP;		// alu 运算类型
	wire regWE;				// Reg 写信号
	wire ram2reg;			// Ram 写入 Reg
	wire ramWE;				// Ram 写信号
	wire imm;				//立即数信号
	wire shift;				//位移信号
	wire isrt;				//是否写入 rt
	wire sign_ext;			//是否为符号扩展
	wire jal;				//是否为 jal 指令
	wire lui;				//是否为 lui 指令
	wire [4:0] rs;			// rs 地址
	wire [4:0] rt;			// rt 地址
	wire [4:0] rd;			// rd 地址
	wire [4:0] sa;			//位移位数
	wire [15:0] immediate;	//立即数
	wire [25:0] addr;		//跳转地址
	wire [31:0] rdata1;		//rs读出数据
	wire [31:0] rdata2;		//rt读出数据
	wire [31:0] rdata;		//ram读出数据
	wire z;					//运算结果是否为 0
	
	/* 实例化 IF、ID、EXE、MEM 和 WB */
	IF myif(clk, rst, pcindex, immediate, addr, rdata1, pc4, instrument); 
	ID myid(instrument, z, pcindex, regWE, ram2reg, ramWE, imm, shift, isrt, sign_ext, jal, lui, rs, rt, rd, sa, immediate, addr, aluOP);
	EXE myexe(clk, rdata1, rdata2, shift, ramWE, ram2reg, imm, sign_ext, rs, rt, sa, immediate, aluOP, f, z); 
	MEM mymem(clk, ramWE, f, rdata2, rdata, n, result);
	WB mywb(clk, regWE, isrt, ram2reg, jal, lui, rs, rt, rd, f, rdata, pc4, immediate, rdata1, rdata2);
endmodule