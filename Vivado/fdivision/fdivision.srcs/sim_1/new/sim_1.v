`timescale 1ns / 1ps

module test(

    );
    reg reset = 1'b0;
    reg f10m = 1'b0;
    wire f500k;
    initial
    #10 reset = 1;
    always #1
    begin
        f10m <= ~f10m;
    end
    fdivision fdivision(reset, f10m, f500k);
endmodule