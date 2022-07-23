`timescale 1ns / 1ps

module fib(
        input clk,
        input rst,
        input [3:0] n,
        output [31:0] result
    );
    reg [31:0] ra,rb;
    wire [31:0] wf;
    reg [3:0] count;
    ALU myalu(.a(ra), .b(rb), .op(4'b0001), .f(wf)); 
    always @(posedge clk)
    begin
        if (rst == 1'b1)
        begin
            ra <= 32'b1;
            rb <= 32'b1;
            count <= 4'b0011;
        end
        else
            if (count < n)
            begin
                ra <= rb;
                rb <= wf;
                count <= count + 1'b1;
            end
    end
    
    assign result = wf;
endmodule