`timescale 1ns / 1ps

module ram(
		input clk,
		input ce,				//Ƭѡ�ź�
		input [3:0] addr,		//������ַ��4λ��
		input [31:0] wdata,		//д������
		input we,				//д���ź�
		output reg [31:0] rdata	//��������
	);
	reg [31:0] ramdata[0:15];	//��ַ����Ϊ 4 λ��Ӧ 16 ���ڴ浥Ԫ	
	always @(posedge clk)		//д�˿�
	begin
		#2
		if ((we == 1'b1) && (ce == 1'b0))//��д����ѡ��
		begin
			ramdata[addr] <= wdata;//д������
			$display($time, , "MEM/IOManager/ram: write %h to Ram %h", wdata, addr);
		end
	end
	always @(*)//���˿�
	begin
		if (ce == 1'b1)//δѡ��״̬
			rdata = 32'bz;
		else//ѡ��״̬
		begin
			rdata = ramdata[addr];//��������
			$display($time, , "MEM/IOManager/ram: read Ram %h -> data = %h", addr, rdata);
		end
	end
endmodule