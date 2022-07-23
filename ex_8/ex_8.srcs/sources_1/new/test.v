`timescale 1ns / 1ps
module test(

    );
    reg [7:0] data[0:31];
    reg [7:0] temp;
    reg [4:0] i;
    initial
    i = 5'b00000;
    always #10
        begin
            data[i] = i;
            #5 data[31 - i] = 31 - i;
            #5 temp = data[i];
            #5 data[i] = data[31 - i];
            #5 data[31 - i] = temp;
            #5 $display($time, , "success: [%d\t] <-->[%d\t]", data[i], data[31 - i]);
            #5 i = i + 1;
        end
    initial
    #640 $stop;
endmodule