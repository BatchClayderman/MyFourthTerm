`timescale 1ns / 1ps

module registers(
		input clk,
		input oc,					//Ƭѡ�ź�
		input [4:0] raddr1,			//������ַ 1
		input [4:0] raddr2,			//������ַ 2
		input [4:0] waddr,			//д���ַ
		input [31:0] wdata,			//д������
		input we,		   			//��д�ź�
		output reg [31:0] rdata1,	//�������� 1
		output reg [31:0] rdata2	//�������� 2
	);
	reg [31:0] regts[1:31];// $0 �żĴ���ֻ�ܴ�� 0
	always @(posedge clk)//д�˿�
	begin
		#3
		if ((we == 1'b1) && (waddr != 5'b00000))//��д��Ŀ��� $0 �żĴ���
		begin
			regts[waddr] <= wdata;//д������
			$display($time, , "WB/reg: write %h to Reg %h", wdata, waddr);
		end
	end		  
	always @(*)//���˿� 1
	begin
		if (oc == 1'b1)//��ֹ���
			rdata1 = 32'bz;
		else if (raddr1 == 5'b00000)// $0 �żĴ���ֻ���� 0
			rdata1 = 32'b0;
		else
			rdata1 = regts[raddr1];//�����������
		$monitor($time, , "WB/reg: read Reg %h -> data1 = %h", raddr1, rdata1);
	end
	always @(*)//���˿� 2
	begin
		if (oc == 1'b1)//��ֹ���
			rdata2 = 32'bz;
		else if (raddr2 == 5'b00000)// $0 �żĴ���ֻ���� 0
			rdata2 = 32'b0;
		else
			rdata2 = regts[raddr2];//�����������
		$monitor($time, , "WB/reg: read Reg %h -> data2 = %h", raddr2, rdata2);
	end  
endmodule