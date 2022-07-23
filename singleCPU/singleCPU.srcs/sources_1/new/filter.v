`timescale 1ns / 1ps

module filter(
		input clk,
		input wire [4:4] s,
		input rst,
		input [3:0] n,
		output reg [11:0] result,
		output [6:0] a_to_g_0,
		output [6:0] a_to_g_1,
		output [7:0] an,
		output led
	);
	wire [11:0] out;
	always@(*)
	begin
	   if (rst == 1'b1)
	   begin
			if (n == 4'b0000 || n == 4'b0001)
				result = 12'b0;//π ’œ…¡À∏º¥ø…
			else if (n == 4'b0010)
				result = 12'b1;
			else
				result = out;
		end
		else
			result = 12'bz;
	end

	top mytop(clk, rst, n, out);
	scroll_top stop(clk, s, n, a_to_g_0, a_to_g_1, an);
	seq seq(n, clk, rst, led);
	//initial
		//$monitor($time, , "filter: result = %h", result);
endmodule