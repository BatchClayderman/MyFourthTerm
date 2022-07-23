`timescale 1ns / 1ps
module ex08(

    );
    reg [5:0] data[0:31];
    reg [4:0] i;
    initial
    i = 5'b00000;
    always #10
        begin
            data[i] = i;
            #5 data[31 - i] = 31 - i;
            #5 data[i] = data[i] + data[31 - i];
            #5 data[31 - i] = data[i] - data[31 - i];
            #5 data[i] = data[i] - data[31 - i];
            #5 $display($time, , "swap successfully: [%d] <--> [%d]", data[i], data[31 - i]);
            #5 i = i + 1;
        end
endmodule