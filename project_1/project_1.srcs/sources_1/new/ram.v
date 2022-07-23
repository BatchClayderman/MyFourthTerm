`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/05 21:15:14
// Design Name: 
// Module Name: ram
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


module ram( 
    input [5:0] maddr,
    input [31:0] mwdata,
    input clk,
    input we,
    output [31:0] mdata
    );
    reg [31:0] data [0:63];
    assign mdata=data[maddr];
    always@(posedge  clk)
    begin
    if(we)
        begin
        data[maddr]<=mwdata;
        end
    end
    initial
    $monitor($time,,"mdata =%h",mdata);
endmodule
