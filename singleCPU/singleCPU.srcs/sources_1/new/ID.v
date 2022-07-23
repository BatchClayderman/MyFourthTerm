`timescale 1ns / 1ps

module ID(
		input [31:0] instrument,		//����ָ��
		input z,						//�������Ƿ�Ϊ 0
		output wire [1:0] pcindex,		// pc ��Դ
		output wire regWE,				// Reg д�ź�
		output wire ram2reg,			// Ram д�� Reg
		output wire ramWE,				// Ram д�ź�
		output wire imm,				//�������ź�
		output wire shift,				//λ���ź�
		output wire isrt,				//�Ƿ�д�� rt
		output wire sign_ext,			//�Ƿ������չ
		output wire jal,				//�Ƿ� jal ָ��
		output wire lui,				//�Ƿ� lui ָ��
		output wire [4:0] rs,			// rs ��ַ
		output wire [4:0] rt,			// rt ��ַ
		output wire [4:0] rd,			// rd ��ַ
		output wire [4:0] sa,			//λ��λ��
		output wire [15:0] immediate,	//������
		output wire [25:0] addr,		//��ת��ַ
		output wire [3:0] aluOP			// alu ��������
	);
	wire [5:0] opcode;					//ָ������
	wire [5:0] func;					//������	 
	
	/* ʵ���� ID��CU */
	InstrumentDecoder myid(instrument, opcode, func, rs, rt, rd, sa, immediate, addr);  
	CU mycu(opcode, func, z, pcindex, ram2reg, ramWE, aluOP, regWE, imm, shift, isrt, sign_ext, jal, lui);	
endmodule