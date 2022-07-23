`timescale 1ns / 1ps

module CU(
		input [5:0] opcode,			// MIPS 指令类型
		input [5:0] func,			// MIPS 指令功能码
		input z,					//是否为 0 标志
		output reg [1:0] pcindex,	// pc 值的来源
		output reg ram2reg,			//是否将数据从 ram 中写入 reg
		output reg ramWE,			//是否写 ram
		output reg [3:0] aluOP,		// alu 的运算类型
		output reg regWE,			//是否写 reg
		output reg imm,				//是否产生立即数
		output reg shift,			//是否移位
		output reg isrt,			//目的寄存器地址（rt = 1  rd = 0）
		output reg sign_ext,		//立即数扩展（符号扩展：1，零扩展：0）
		output reg jal,				//是否为 jal 指令
		output reg lui				//是否为 lui 指令
	);
	always @(*)
		begin
			shift = 1'b0;//设置默认值
			ram2reg = 1'b0;
			ramWE = 1'b0;
			regWE = 1'b0;
			imm = 1'b0;
			isrt = 1'b0;
			sign_ext = 1'b0;
			pcindex = 2'b0;
			aluOP = 4'b0;
			jal = 1'b0;
			lui = 1'b0;
			case(opcode)//根据指令类型
				//R指令
				6'b000000:
				begin
					case(func)//根据功能码
						6'b100000:// add(rs+rt->rd)
						begin
							aluOP = 4'b0001;
							regWE = 1'b1;
						end
						6'b100010:// sub(rs-rt->rd)
						begin
							aluOP = 4'b0010;
							regWE = 1'b1;
						end
						6'b100100:// and(rs&rt->rd)
						begin
							aluOP = 4'b0011;
							regWE = 1'b1;
						end
						6'b100101:// or(rs|rt->rd)
						begin
							aluOP = 4'b0100;
							regWE = 1'b1;
						end
						6'b100110:// xor(rs^rt->rd)
						begin
							aluOP = 4'b0101;
							regWE = 1'b1;
						end
						6'b000000:// sll(rt<<sa->rd)
						begin
							aluOP = 4'b0110;
							regWE = 1'b1;
							shift = 1'b1;
						end
						6'b000010:// srl(rt>>sa->rd)
						begin
							aluOP = 4'b0111;
							regWE = 1'b1;
							shift = 1'b1;
						end
						6'b000011:// sra(rt>>>sa->rd)
						begin
							aluOP = 4'b1000;
							regWE = 1'b1;
							shift = 1'b1;
						end
						6'b001000:// jr(jump(rs))
						begin
							pcindex = 2'b10;
							regWE = 1'b0;
						end
					endcase
				end
				//I指令
				6'b001000:  //addi(rs+imm->rt)
				begin
					aluOP = 4'b0001;
					regWE = 1'b1;
					imm = 1'b1;
					isrt = 1'b1;
				end
				6'b001100:  //andi(rs$imm->rt)
				begin
					aluOP = 4'b0011;
					regWE = 1'b1;
					imm = 1'b1;
					isrt = 1'b1;
				end
				6'b001101:  //ori(rs|imm->rt)
				begin
					aluOP = 4'b0100;
					regWE = 1'b1;
					imm = 1'b1;
					isrt = 1'b1;
				end
				6'b001110:  //xori(rs^imm->rt)
				begin
					aluOP = 4'b0101;
					regWE = 1'b1;
					imm = 1'b1;
					isrt = 1'b1;
				end
				6'b100011:  //lw(ram[rs+offset]->rt)
				begin
					aluOP = 4'b0001;
					regWE = 1'b1;
					imm = 1'b1;
					isrt = 1'b1;
					ram2reg = 1'b1;
				end
				6'b101011:// sw(rt->ram[rs+offset])
				begin
					aluOP = 4'b0001;
					regWE = 1'b0;
					imm = 1'b1;
					ramWE = 1'b1;
				end
				6'b000100:// beq(if (rs == rt) jump pc + offset << 2;)
				begin
					aluOP = 4'b0010;
					if (z == 1'b1)
						pcindex = 2'b01;
				end
				6'b000101:// beq(if (rs != rt) jump pc + offset << 2;)
				begin
					aluOP = 4'b0010;
					if (z == 1'b0)
						pcindex = 2'b01;
					regWE = 1'b0;
				end
				6'b001111:// lui(将 imm 数保存到 rt 的高 16 位)
				begin
					isrt = 1'b1;
					lui = 1'b1;//调用 lui 指令
					regWE = 1'b1;
				end
				//J指令
				6'b000010:// j（跳转到{PC[31:28],addr<<2}）
				begin
					pcindex = 2'b11;
					regWE = 1'b0;
				end
				6'b000011:// jal（跳转到{PC[31:28],addr<<2}保存pc+4到$31）
				begin
					jal = 1'b1;//调用 jal 指令
					regWE = 1'b1;
					pcindex = 2'b11;
				end
			endcase
		end
	initial
		$monitor($time, , "ID/CU: opcode = %h, func = %h", opcode, func);
	initial
		$monitor($time, , "ID/CU: regWE = %d", regWE);
endmodule