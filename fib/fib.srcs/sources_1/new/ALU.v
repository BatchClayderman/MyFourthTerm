`timescale 1ns / 1ps

module ALU(
    input [31:0] a,
    input [31:0] b,
    input [3:0] op,
    output reg [31:0] f,
    output reg c
    );
    always @(*)
        begin
            c = 0;
            case(op)
                4'b0000: f = 32'b0;
                4'b0001: {c, f} = a + b;
                4'b0010: f = a - b;
                4'b0011: f = a & b;
                4'b0100: f = a | b;
                4'b0101: f = a ^ b;
                default: f = 32'b0;
            endcase
        end
endmodule