`timescale 1ns / 1ps

module x7seg_msg(
		input wire [15:0] x,
		input wire cclk,
		input wire clr,
		output reg [6:0] a_to_g,
		output reg [3:0] an
	);
	reg [1:0] s;
	reg [3:0] digit;
	always @(*)
		case(s)
			0: digit = x[3:0];
			1: digit = x[7:4];
			2: digit = x[11:8];
			3: digit = x[15:12];
			default: digit = x[3:0];
		endcase
	
	always @(*)
		case(digit)
			0: a_to_g = 7'b1111110;
			1: a_to_g = 7'b0110000;
			2: a_to_g = 7'b1101101;
			3: a_to_g = 7'b1111001;
			4: a_to_g = 7'b0110011;
			5: a_to_g = 7'b1011011;
			6: a_to_g = 7'b1011111;
			7: a_to_g = 7'b1110000;
			8: a_to_g = 7'b1111111;
			9: a_to_g = 7'b1111011;
			'hA: a_to_g = 7'b0000000;// NULL
			'hB: a_to_g = 7'b0001001;// = 
			'hC: a_to_g = 7'b1001110;// [
			'hD: a_to_g = 7'b1111000;// ]
			'hE: a_to_g = 7'b1001111;// E
			'hF: a_to_g = 7'b1000111;// F
			default: a_to_g = 7'b0000000;
		endcase
	
	always @(*)
	begin
		an = 4'b0000;
		an[s] = 1;
	end
	
	always @(posedge cclk or posedge clr)
	begin
		if (clr == 1)
			s <= 0;
		else
			s <= s + 1;
	end
endmodule