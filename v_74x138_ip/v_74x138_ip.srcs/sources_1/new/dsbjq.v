`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/16 18:58:03
// Design Name: 
// Module Name: dsbjq
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


module dsbjq(
    input a,input b, input c, output f
    );
    wire [7:0] y_l;
    assign f = ~(y_l[3]&y_l[5]&y_l[6]&y_l[7]);
    v74x138_0 uutl(
        .g1(1),
        .g2a_l(0),
        .g2b_l(0),
        .a({a,b,c}),
        .y_l(y_l)
    );
endmodule
