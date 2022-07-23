`timescale 1ns / 1ps

module sim_1(

    );
    
    reg a, b, c;
    wire f;
    v74x138 uut(a, b, c, f);
    initial
    begin
    	a = 0;
    	b = 0;
    	c = 0;
    end
    always #10 {a, b, c} = {a, b, c} + 1;
endmodule
