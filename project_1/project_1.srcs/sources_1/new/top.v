`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/05 21:04:16
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input we,
    input [3:0] code ,
    input rst,
    output [31:0] result
    );
    wire [15:0] temp;
    wire [31:0] mdata;
    wire [31:0] mwdata;
    wire [5:0] maddr;
    wire[2:0] mm;
    assign mwdata = 32'h123487ab;
    choose mychoose(.we(we),.code(code),.maddr(maddr),.mm(mm));
    newram mynewram(.maddr(maddr),.mwdata(mwdata),.clk(clk),.we(we),.mm(mm),.mdata(mdata));
    assign temp={mdata [31:28],mdata [24:20],mdata [15:12],mdata[7:4]};
    assign result=temp;
    endmodule













