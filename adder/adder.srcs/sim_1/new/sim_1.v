`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2021 07:14:33 PM
// Design Name: 
// Module Name: sim_1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sim_1(

    );
    reg [1:0] a, b;
    wire [2:0] sum;
    reg clk = 1'b0;
    always #8
        clk = ~clk;
        initial
        begin
            a = 2'b01;
            b = 2'b10;
            #10 a = 2'b11;
            #10 b = 2'b01;
        end
        adder adder(a, b, clk, sum);
endmodule
