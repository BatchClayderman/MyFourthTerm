`timescale 1ns / 1ps

module IOManager(
		input [5:0] addr,				//��ַ
		input [31:0] din,				//�ڴ���������
		output [31:0] dout,				//�ڴ�򿪹ػ������
		input we,						//�ڴ�ʹ�ܶ�
		input clk,						//ʱ���ź�
		input [3:0] switch,				//������������
		output reg [31:0] displaydata	// IO �������
	);
	wire [31:0] ramdout;// Ram ��������
	wire ramWE;// Ram д���ź�
	wire ce;// Ram Ƭѡ�ź�(ֵΪ 0 ʱѡ��)
	assign ce = (|addr[5:4]);//�Ȳ�д�� f(n) Ҳ������ n ʱѡ��
	assign dout = addr[5] ? {{28{1'b0}}, switch} : ramdout;//���ݵ� 5 λ��� n �� Ram ������
	assign ramWE = we && (~addr[4]);//��д�� f(n) �� IO ��дʱ Ram ��д
	ram myram(clk, ce, addr[3:0], din, ramWE, ramdout);//ʵ���� ram
	always @(posedge clk)
	begin
		if ((addr[4] == 1'b1) && we)//��Ҫд�� f(n) �� IO ��д
			displaydata <= din;//��� IO ������
	end
	initial
		$monitor($time, , "MEM/IOManager: displaydata = %h", displaydata);
endmodule