`timescale 1ns / 1ps

module CU(
		input [5:0] opcode,			// MIPS ָ������
		input [5:0] func,			// MIPS ָ�����
		input z,					//�Ƿ�Ϊ 0 ��־
		output reg [1:0] pcindex,	// pc ֵ����Դ
		output reg ram2reg,			//�Ƿ����ݴ� ram ��д�� reg
		output reg ramWE,			//�Ƿ�д ram
		output reg [3:0] aluOP,		// alu ����������
		output reg regWE,			//�Ƿ�д reg
		output reg imm,				//�Ƿ����������
		output reg shift,			//�Ƿ���λ
		output reg isrt,			//Ŀ�ļĴ�����ַ��rt = 1  rd = 0��
		output reg sign_ext,		//��������չ��������չ��1������չ��0��
		output reg jal,				//�Ƿ�Ϊ jal ָ��
		output reg lui				//�Ƿ�Ϊ lui ָ��
	);
	always @(*)
		begin
			shift = 1'b0;//����Ĭ��ֵ
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
			case(opcode)//����ָ������
				//Rָ��
				6'b000000:
				begin
					case(func)//���ݹ�����
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
				//Iָ��
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
				6'b001111:// lui(�� imm �����浽 rt �ĸ� 16 λ)
				begin
					isrt = 1'b1;
					lui = 1'b1;//���� lui ָ��
					regWE = 1'b1;
				end
				//Jָ��
				6'b000010:// j����ת��{PC[31:28],addr<<2}��
				begin
					pcindex = 2'b11;
					regWE = 1'b0;
				end
				6'b000011:// jal����ת��{PC[31:28],addr<<2}����pc+4��$31��
				begin
					jal = 1'b1;//���� jal ָ��
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