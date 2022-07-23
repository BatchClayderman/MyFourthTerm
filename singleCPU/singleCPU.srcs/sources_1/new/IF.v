`timescale 1ns / 1ps

module IF(
		input clk,//ʱ���ź�
		input rst,//��λ�ź�
		input [1:0] pcindex,// pc ��Դ
		input [15:0] immediate,//������
		input [25:0] j_addr,// J ��ָ���ַ
		input [31:0] jr_addr,// jr ָ����ת��ַ
		output wire [31:0] pc4,//˳����һ��ָ�� pc + 4
		output wire [31:0] instrument//ָ��
	);
	reg [31:0] next_addr;//��һ PC
	wire [31:0] addr;//��ǰ PC
	
	PC mypc(rst, clk, next_addr, addr);//ʵ���� PC
	rom myrom(addr, instrument);//ʵ���� Rom
	
	assign pc4 = addr + 32'b100;// PC = PC + 4
	always @(*)
		begin
			case(pcindex)//���� pcindex ѡ�� PC ��һ��ַ
				2'b00://Ĭ��״̬
					next_addr = pc4;// pc + 4
				2'b01:// beq��bne ָ��
					next_addr = addr + ({{16{immediate[15]}},immediate} << 2'b10);// pc + offset(������չ)<< 2
				2'b10:// jr ָ��
					next_addr = jr_addr;
				2'b11:// j��jal ָ��
					next_addr = {addr[31:28], {j_addr, 2'b00}};//{pc[31:28], addr << 2}
			endcase
		end
	initial
		$monitor($time, , "IF: pcindex = %h", pcindex);
endmodule