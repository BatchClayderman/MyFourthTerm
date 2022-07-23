`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/05 22:17:52
// Design Name: 
// Module Name: ramsim
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


module ramsim(
    output [31:0] result
    );
    reg [3:0] code;
    reg rst;
    reg clk;
    wire we=1'b1;
    initial
    begin
    clk=1'b0;
    code=4'b0000;
    rst=1'b0;
    #10 rst=1'b1;
    end
    always#5
    clk=~clk;
    always#10
    code=code+1'b1;
    top mytop(.clk(clk),.we(we),.code(code),.rst(rst),.result(result));
endmodule