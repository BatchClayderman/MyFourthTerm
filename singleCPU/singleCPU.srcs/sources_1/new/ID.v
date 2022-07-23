`timescale 1ns / 1ps

module ID(
		input [31:0] instrument,		//输入指令
		input z,						//运算结果是否为 0
		output wire [1:0] pcindex,		// pc 来源
		output wire regWE,				// Reg 写信号
		output wire ram2reg,			// Ram 写入 Reg
		output wire ramWE,				// Ram 写信号
		output wire imm,				//立即数信号
		output wire shift,				//位移信号
		output wire isrt,				//是否写入 rt
		output wire sign_ext,			//是否符号扩展
		output wire jal,				//是否 jal 指令
		output wire lui,				//是否 lui 指令
		output wire [4:0] rs,			// rs 地址
		output wire [4:0] rt,			// rt 地址
		output wire [4:0] rd,			// rd 地址
		output wire [4:0] sa,			//位移位数
		output wire [15:0] immediate,	//立即数
		output wire [25:0] addr,		//跳转地址
		output wire [3:0] aluOP			// alu 运算类型
	);
	wire [5:0] opcode;					//指令类型
	wire [5:0] func;					//功能码	 
	
	/* 实例化 ID、CU */
	InstrumentDecoder myid(instrument, opcode, func, rs, rt, rd, sa, immediate, addr);  
	CU mycu(opcode, func, z, pcindex, ram2reg, ramWE, aluOP, regWE, imm, shift, isrt, sign_ext, jal, lui);	
endmodule