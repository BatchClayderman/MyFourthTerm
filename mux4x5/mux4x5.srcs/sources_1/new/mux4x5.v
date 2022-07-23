`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2021 07:17:53 PM
// Design Name: 
// Module Name: mux4x5
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


module mux4x5(
    input [4:0] data0,
    input [4:0] data1,
    input [4:0] data2,
    input [4:0] data3,
    input sel0,
    input sel1,
    output [4:0] result
    );
    assign result = (sel0 == 0) ? (sel1 == 0 ? data0 : data1) : (sel1 == 1 ? data2 : data3); 
endmodule
