`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2021 07:30:08 PM
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
    initial
    begin
    end
    wire data0 = 4'b0000;
    wire data1 = 4'b0001;
    wire data2 = 4'b0010;
    wire data3 = 4'b0011;
    wire sel0 = 0;
    wire sel1 = 1;
    wire result;
    mux4x5 mux4x5(data0, data1, data2, data3, sel0, sel1, result);
endmodule
