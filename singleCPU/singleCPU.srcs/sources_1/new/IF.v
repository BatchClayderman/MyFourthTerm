`timescale 1ns / 1ps

module IF(
		input clk,//时钟信号
		input rst,//复位信号
		input [1:0] pcindex,// pc 来源
		input [15:0] immediate,//立即数
		input [25:0] j_addr,// J 类指令地址
		input [31:0] jr_addr,// jr 指令跳转地址
		output wire [31:0] pc4,//顺序下一条指令 pc + 4
		output wire [31:0] instrument//指令
	);
	reg [31:0] next_addr;//下一 PC
	wire [31:0] addr;//当前 PC
	
	PC mypc(rst, clk, next_addr, addr);//实例化 PC
	rom myrom(addr, instrument);//实例化 Rom
	
	assign pc4 = addr + 32'b100;// PC = PC + 4
	always @(*)
		begin
			case(pcindex)//根据 pcindex 选择 PC 下一地址
				2'b00://默认状态
					next_addr = pc4;// pc + 4
				2'b01:// beq、bne 指令
					next_addr = addr + ({{16{immediate[15]}},immediate} << 2'b10);// pc + offset(符号扩展)<< 2
				2'b10:// jr 指令
					next_addr = jr_addr;
				2'b11:// j、jal 指令
					next_addr = {addr[31:28], {j_addr, 2'b00}};//{pc[31:28], addr << 2}
			endcase
		end
	initial
		$monitor($time, , "IF: pcindex = %h", pcindex);
endmodule