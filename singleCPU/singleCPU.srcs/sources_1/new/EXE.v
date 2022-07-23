`timescale 1ns / 1ps

module EXE(
    	input clk,
    	input [31:0] rdata1,	// rs ��������
    	input [31:0] rdata2,	// rt ��������
    	input shift,			//λ���ź�
    	input ramWE,			// Ram д���ź�
    	input ram2reg,			// Ram д�� Reg
	    input imm,				//�������ź�
	    input sign_ext,			//�Ƿ������չ
	    input [4:0] rs,			// rs ��ַ
	    input [4:0] rt,			// rt ��ַ
	    input [4:0] sa,			//λ��λ��
	    input [15:0] immediate,	//������
	    input [3:0] aluOP,		// alu ��������
	    output wire [31:0] f,	//������
	    output wire z			//�������Ƿ�Ϊ 0
    );
    reg [31:0] a;				// alu ���� a ��
    reg [31:0] b;				// alu ���� b ��
    always @(posedge clk)
	begin
       	#1
		if (shift == 1'b0)	//�Ƿ��漰λ�Ʋ���
			a <= rdata1;	//�� rs �������ݸ�ֵ�� a
		else				//�漰λ�Ʋ���
			a <= sa;		//��λ��λ������ a    
		if (imm == 1'b1)	//�Ƿ��漰����������
		begin
			if (sign_ext == 1'b1)//�Ƿ���Ҫ������չ
				b <= {{16{immediate[15]}}, immediate};//������չ�� 32 λ
			else//����Ҫ������չ
				b <= {16'b0, immediate};//����չ�� 32 λ
		end
		else//���漰����������
			b <= rdata2;//�� rt �������ݸ�ֵ�� b
	end    
    alu myalu(a, b, aluOP, f, z);//ʵ���� ALU
endmodule