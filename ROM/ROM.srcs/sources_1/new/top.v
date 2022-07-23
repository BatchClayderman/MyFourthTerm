`timescale 1ns / 1ps

module top(
		input reset,
		input clk,
		output [11:0] res
    );
    wire [31:0] addr;
    wire [31:0] insdata;
    PC pc(reset, clk, addr);
    ROM rom(addr, insdata);
    assign res = insdata[11:0];
endmodule
