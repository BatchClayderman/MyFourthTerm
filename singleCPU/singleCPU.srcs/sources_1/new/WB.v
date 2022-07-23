`timescale 1ns / 1ps

module WB(
		input clk,					//ʱ���ź�
		input regWE,				// Reg д���ź�
		input isrt,					//�Ƿ�д�� rt
		input ram2reg,				// Ram д�� Reg
		input jal,					//�Ƿ� jal ָ��
		input lui,					//�Ƿ� lui ָ��
		input [4:0] rs,				// rs ��ַ
		input [4:0] rt,				// rt ��ַ
		input [4:0] rd,				// rd ��ַ
		input [31:0] f,				// alu ������
		input [31:0] rdata,			// Ram ��������
		input [31:0] pc4,			//˳����һ��ָ�� pc + 4
		input [15:0] immediate,		//������
		output wire [31:0] rdata1,	// Reg ���� rdata1
		output wire [31:0] rdata2 	// Reg ���� rdata2
	);
	reg oc = 1'b0;// Reg Ƭѡ�ź�
	reg [4:0] wa;// Reg д���ַ
	reg [31:0] wdata;// Reg д������
	always @(posedge clk)
	begin
		#2
		if ((jal == 1'b0) && (lui == 1'b0))//�� jal �� lui ָ��
		begin
			if (regWE == 1'b1)//��Ҫд��Ĵ���
			begin
				wa <= isrt ? rt : rd;//���� isrt д�� rt �� rd
				wdata <= ram2reg ? rdata : f;
				//���� ram2reg д�� ram �������ݻ� alu ������
			end
		end
		else if (jal == 1'b1)//Ϊjalָ��
		begin
			wa <= 5'b11111;//��pc+4������$31�żĴ���
			wdata <= pc4;  //˳����һ��ָ���ַ
		end
		else//Ϊ lui ָ��
		begin
			wa <= rt; //��������������rt�ĸ�16λ
			wdata <= {immediate, 16'b0};
		end   
	end
	registers myregs(clk, oc, rs, rt, wa, wdata, regWE, rdata1, rdata2);
endmodule