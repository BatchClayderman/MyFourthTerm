`timescale 1ns / 1ps

module PC(
		input rst,
		input clk,
		input [31:0] next_addr,
		output reg [31:0] addr
	);
	always@(posedge clk)
	begin
		if (rst == 1'b0)
			addr <= 32'h0;//���õ�ַΪ 0
		else
			addr <= next_addr;//���� PC ��ַ
	end
	initial
		$monitor($time, , "IF/PC: addr = %h", addr);
	initial
		$monitor($time, , "IF/PC: next_addr = %h", next_addr);
endmodule