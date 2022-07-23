`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/05 21:31:21
// Design Name: 
// Module Name: choose
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


module choose(
    input we,
    input [3:0] code,
    output reg [5:0] maddr,
    output reg [2:0] mm
    );
    always@(*)
    case(code)
    4'b0000:
        begin
        maddr<=6'b0;
        mm<=3'b0;
        end
    4'b0001:
        begin
        maddr<=6'b0;
        mm<=3'b001;
        end
    4'b0010:
        begin
        maddr<=6'b0;
        mm<=3'b010;
        end
    4'b0011:
        begin
        maddr<=6'b0;
        mm <=3'b011;
        end
    4'b0100:
        begin
        maddr<=6'b0;
        mm<=3'b100;
        end
    4'b0101:
        begin
        maddr<=6'b000100;
        mm <=3'b101;
        end
    4'b0110:
        begin
        maddr<=6'b001000;
        mm<=3'b110;
        end
    4'b0111:
        begin
        maddr<=6'b0;
        mm<=3'b111;
        end
    4'b1000:
        begin
        maddr<=6'b000100;
        mm <=3'b011;
        end
    4'b1001:
        begin
        maddr<=6'b001000;
        mm <=3'b100;
        end
    endcase
endmodule
