`timescale 1ns / 1ps

module shumaguan(
	//input clk,
	//input rst_n,
	input wire [3:0] x,
	output reg [6:0] a_to_g, //段信号
	output wire an//位选信号
);

	assign an = 1;
	always @(*)
		case(x)
	 		0:a_to_g = 7'b1111110;//段码位序由高到低为a-g
	 		1:a_to_g = 7'b0110000;
	 		2:a_to_g = 7'b1101101;
	 		3:a_to_g = 7'b1111001;
	 		4:a_to_g = 7'b0110011;
	 		5:a_to_g = 7'b1011011;
	 		6:a_to_g = 7'b1011111;
	 		7:a_to_g = 7'b1110000;
	 		8:a_to_g = 7'b1111111;
	 		9:a_to_g = 7'b1111011;
	 		default:a_to_g = 7'b1001111;
	 	endcase
endmodule