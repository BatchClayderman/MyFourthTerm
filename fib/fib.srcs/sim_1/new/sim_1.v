`timescale 1ns / 1ps

module sim_1(

    );
    reg clk = 0;
    always #10
        clk = ~clk;
        reg rst = 1'b1;
        reg [3:0] n = 4'b1010;
        wire [7:0] result;
        top t(clk, rst, n, result);
        initial
            #11 rst = 1'b0;
endmodule