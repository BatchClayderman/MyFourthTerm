`timescale 1ns / 1ps

module clkdiv(
		input wire clk_100MHz,
		input wire clr,
		output wire clk_190Hz,
		output wire clk_3Hz
	);
	reg [24:0] q;
	
	always @(posedge clk_100MHz or posedge clr)
	begin
		if (clr == 1)
			q <= 0;
		else
			q <= q + 1;
	end
	assign clk_190Hz = q[18];// 190Hz
	assign clk_3Hz = q[24];// 3Hz
endmodule