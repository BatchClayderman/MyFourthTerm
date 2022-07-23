`timescale 1ns / 1ps

module seq(
		input [3:0] n,
		input clk,
		input rst,
		output led
	);
	
	reg [31:0] divclk_cnt = 0;
	reg divclk = 0;
	reg error = 0;
	always@(posedge clk)
	begin
		if (rst == 1'b1)
		begin
			if (n == 0 || n == 1)
				error <= 1;
			else
				error <= 0;
		end
	  	if (divclk_cnt == 12500000)
		begin
			if (error == 1)
				divclk <= ~divclk;//故障闪烁
			else
				divclk <= 0;//正常使用
			divclk_cnt <= 0;//清空计数
		end
		else
		begin
			divclk_cnt <= divclk_cnt + 1'b1;
		end
	end
	assign led = divclk;
endmodule