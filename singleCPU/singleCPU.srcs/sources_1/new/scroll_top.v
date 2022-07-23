`timescale 1ns / 1ps

module scroll_top(
		input wire clk_100MHz,
    	input wire [4:4] s,
    	input wire [3:0] numbers,
    	output [6:0] a_to_g_0,
    	output [6:0] a_to_g_1,
    	output [7:0] an
    );
    wire clr, clk_190Hz, clk_3Hz;
    wire [31:0] x;
    assign clr = s;
    clkdiv U1(.clk_100MHz(clk_100MHz), .clr(clr), .clk_3Hz(clk_3Hz), .clk_190Hz(clk_190Hz));
    shift_array U2(.clk(clk_3Hz), .clr(clr), .numbers(numbers), .x(x));
    x7seg_msg U3(.x(x[15:0]), .cclk(clk_190Hz), .clr(clr), .a_to_g(a_to_g_0), .an(an[3:0]));
    x7seg_msg U4(.x(x[31:16]), .cclk(clk_190Hz), .clr(clr), .a_to_g(a_to_g_1), .an(an[7:4]));
endmodule
