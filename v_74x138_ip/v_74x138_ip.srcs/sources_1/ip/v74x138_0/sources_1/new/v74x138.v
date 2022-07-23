`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/16 18:50:57
// Design Name: 
// Module Name: v74x138
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


module v74x138(
g1,g2a_l,g2b_l,a,y_l);
input g1,g2a_l,g2b_l;
input [2:0] a;
output [7:0] y_l;
reg [7:0] y_l = 0; // 因为后面要用到always模块，always里的必须是reg型
always @ (g1,g2a_l,g2b_l,a)
begin
    if (g1 && ~g2a_l && ~g2b_l)
        case(a) 
        7:y_l = 8'b01111111;
        6:y_l = 8'b10111111;
        5:y_l = 8'b11011111;
        4:y_l = 8'b11101111;
        3:y_l = 8'b11110111;
        2:y_l = 8'b11111011;
        1:y_l = 8'b11111101;
        0:y_l = 8'b11111110;
        default:y_l = 8'b11111111;
        endcase
    else
    y_l = 8'b11111111;
end
endmodule