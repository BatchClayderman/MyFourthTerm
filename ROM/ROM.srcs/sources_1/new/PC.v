`timescale 1ns / 1ps

module PC(
		input reset,
		input clk,
		output reg [31:0] insAddr
    );
    always@(posedge clk)
    if(reset)
        insAddr <= 32'b0;
    else
        insAddr <= insAddr + 4;
endmodule