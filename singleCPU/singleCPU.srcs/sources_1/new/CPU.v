`timescale 1ns / 1ps

module CPU(
		input clk,
		input rst,
		input [3:0] n,
		output wire [31:0] result
	);   
	wire [1:0] pcindex;		// pc ��Դ
	wire [31:0] instrument;	//ָ��
	wire [31:0] pc4;		//˳����һ��ָ�� pc + 4
	wire [31:0] f;			// alu ������
	wire [3:0] aluOP;		// alu ��������
	wire regWE;				// Reg д�ź�
	wire ram2reg;			// Ram д�� Reg
	wire ramWE;				// Ram д�ź�
	wire imm;				//�������ź�
	wire shift;				//λ���ź�
	wire isrt;				//�Ƿ�д�� rt
	wire sign_ext;			//�Ƿ�Ϊ������չ
	wire jal;				//�Ƿ�Ϊ jal ָ��
	wire lui;				//�Ƿ�Ϊ lui ָ��
	wire [4:0] rs;			// rs ��ַ
	wire [4:0] rt;			// rt ��ַ
	wire [4:0] rd;			// rd ��ַ
	wire [4:0] sa;			//λ��λ��
	wire [15:0] immediate;	//������
	wire [25:0] addr;		//��ת��ַ
	wire [31:0] rdata1;		//rs��������
	wire [31:0] rdata2;		//rt��������
	wire [31:0] rdata;		//ram��������
	wire z;					//�������Ƿ�Ϊ 0
	
	/* ʵ���� IF��ID��EXE��MEM �� WB */
	IF myif(clk, rst, pcindex, immediate, addr, rdata1, pc4, instrument); 
	ID myid(instrument, z, pcindex, regWE, ram2reg, ramWE, imm, shift, isrt, sign_ext, jal, lui, rs, rt, rd, sa, immediate, addr, aluOP);
	EXE myexe(clk, rdata1, rdata2, shift, ramWE, ram2reg, imm, sign_ext, rs, rt, sa, immediate, aluOP, f, z); 
	MEM mymem(clk, ramWE, f, rdata2, rdata, n, result);
	WB mywb(clk, regWE, isrt, ram2reg, jal, lui, rs, rt, rd, f, rdata, pc4, immediate, rdata1, rdata2);
endmodule