`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/16 18:51:35
// Design Name: 
// Module Name: Sim
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


module Sim(

    );
reg g1;
reg g2a_l;
reg g2b_l;
reg [2:0] a;
wire [7:0] y_l;
v74x138 diaoyong(g1,g2a_l,g2b_l,a,y_l);  //这个调用模块里的值是来自上面的reg g2a_1等
    initial begin
        g1=0;
        g2a_l=0;
        g2b_l=0; //此时使能端没有打开
        a = 0;
        # 100;  
        g1=1; //100纳秒以后使能端打开
        g2a_l=0;
        g2b_l=0;
    end
    always #100 a = a + 1;
endmodule