`timescale 1ns / 1ps

module seg7decimal(
		input [15:0] x,
		input clk,
		input clr,
		output reg [6:0] a_to_g,
		output reg [3:0] an,
		output wire dp 
	);
	
	wire [1:0] s;     
	reg [3:0] digit;
	wire [3:0] aen;
	reg [19:0] clkdiv;
	
	assign dp = 0;
	assign s = clkdiv[19:18];
	assign aen = 4'b1111; // all turned off initially
	// quad 4to1 MUX.

	always @(posedge clk)// or posedge clr)
	case(s)
		0:digit = x[15:12]; // s is 00 -->0 ;  digit gets assigned 4 bit value assigned to x[3:0]
		1:digit = x[11:8]; // s is 01 -->1 ;  digit gets assigned 4 bit value assigned to x[7:4]
		2:digit = x[7:4]; // s is 10 -->2 ;  digit gets assigned 4 bit value assigned to x[11:8
		3:digit = x[3:0]; // s is 11 -->3 ;  digit gets assigned 4 bit value assigned to x[15:12]
  		default:digit = x[3:0];
	endcase

	/* decoder or truth-table for 7a_to_g display values */
	always @(*)
		case(digit)
			/* <---MSB-LSB<--- gfecbda */
			0: a_to_g = 7'b0111111;
			1: a_to_g = 7'b0000110;
			2: a_to_g = 7'b1011011;
			3: a_to_g = 7'b1001111;
			4: a_to_g = 7'b1100110;
			5: a_to_g = 7'b1101101;
			6: a_to_g = 7'b1111101;
			7: a_to_g = 7'b0000111;
			8: a_to_g = 7'b1111111;
			9: a_to_g = 7'b1101111;
			'hA: a_to_g = 7'b0000000;// NULL
			'hB: a_to_g = 7'b1001000;// = 
			'hC: a_to_g = 7'b0111001;// [
			'hD: a_to_g = 7'b0001111;// ]
			'hE: a_to_g = 7'b1111001;// E
			'hF: a_to_g = 7'b1110001;// F
			default: a_to_g = 7'b0000000;
		endcase

	always @(*)
	begin
		an = 4'b0000;
		if (aen[s] == 1)
			an[s] = 1;
	end

	/* clkdiv */
	always @(posedge clk or posedge clr)
	begin
		if (clr == 1)
			clkdiv <= 0;
		else
			clkdiv <= clkdiv+1;
	end

endmodule
