`timescale 1ns / 1ps

module ROM(
		input [31:0] addr,
		output reg [31:0] ins
    );
	always @(*)
	begin
		case(addr[31:0])
			32'h0:ins = 32'h34020002;
			32'h4:ins = 32'h8c030020;
			32'h8:ins = 32'h34040001;
			32'hc:ins = 32'h34050401;
			32'h10:ins = 32'h00853020;
			32'h14:ins = 32'h00052026;
		endcase
	end
endmodule
