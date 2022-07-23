`timescale 1ns / 1ps

module InstrumentDecoder(
		input [31:0] instrument,		//读入指令
		output reg [5:0] opcode,		//指令类型
		output reg [5:0] func,  		//功能码
		output reg [4:0] rs,			// rs 地址
		output reg [4:0] rt,			// rt 地址
		output reg [4:0] rd,			// rd 地址
		output reg [4:0] sa,			//移位位数
		output reg [15:0] immediate,	//立即数
		output reg [25:0] addr  		//跳转地址
	);
	always @(*)
		begin
			opcode = instrument [31:26];//获取指令类型
			/* 设置默认值 */
			rs = 5'b0;
			rt = 5'b0;
			rd = 5'b0;
			sa = 5'b0;
			immediate = 15'b0;
			addr = 25'b0;
			case(opcode)//根据指令类型读指  
				/* R 指令类型 */
				6'b000000:
					begin
						func = instrument [5:0];//设置功能码
						sa = instrument [10:6];//设置位移位数
						rd = instrument [15:11];//设置 rd 地址
						rt = instrument [20:16];//设置 rt 地址
						rs = instrument [25:21];//设置 rs 地址
					end
				/* I 类型 */
				6'b001000,  // addi
				6'b001100,  // andi
				6'b001101,  // ori
				6'b001110,  // xori
				6'b100011,  // lw
				6'b101011,  // sw
				6'b000100,  // beq
				6'b000101,  // bne
				6'b001111:  // lui
					begin
						immediate = instrument [15:0];//设置 immediate 或 offset
						rt = instrument [20:16];//设置 rt 地址
						rs = instrument [25:21];//设置 rs 地址
					end
				/* J 类型 */
				6'b000010,// j
				6'b000011:// jal
					begin
						addr = instrument [25:0];//设置跳转地址
					end
				default: rs = 5'b0; 
			endcase
		end
endmodule