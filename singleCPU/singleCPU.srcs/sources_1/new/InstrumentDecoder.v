`timescale 1ns / 1ps

module InstrumentDecoder(
		input [31:0] instrument,		//����ָ��
		output reg [5:0] opcode,		//ָ������
		output reg [5:0] func,  		//������
		output reg [4:0] rs,			// rs ��ַ
		output reg [4:0] rt,			// rt ��ַ
		output reg [4:0] rd,			// rd ��ַ
		output reg [4:0] sa,			//��λλ��
		output reg [15:0] immediate,	//������
		output reg [25:0] addr  		//��ת��ַ
	);
	always @(*)
		begin
			opcode = instrument [31:26];//��ȡָ������
			/* ����Ĭ��ֵ */
			rs = 5'b0;
			rt = 5'b0;
			rd = 5'b0;
			sa = 5'b0;
			immediate = 15'b0;
			addr = 25'b0;
			case(opcode)//����ָ�����Ͷ�ָ  
				/* R ָ������ */
				6'b000000:
					begin
						func = instrument [5:0];//���ù�����
						sa = instrument [10:6];//����λ��λ��
						rd = instrument [15:11];//���� rd ��ַ
						rt = instrument [20:16];//���� rt ��ַ
						rs = instrument [25:21];//���� rs ��ַ
					end
				/* I ���� */
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
						immediate = instrument [15:0];//���� immediate �� offset
						rt = instrument [20:16];//���� rt ��ַ
						rs = instrument [25:21];//���� rs ��ַ
					end
				/* J ���� */
				6'b000010,// j
				6'b000011:// jal
					begin
						addr = instrument [25:0];//������ת��ַ
					end
				default: rs = 5'b0; 
			endcase
		end
endmodule