`timescale 1ns / 1ps

module sim_1(

    );
    
    reg clk_100MHz = 1'b0;
    reg [4:4] s;
    reg [3:0] numbers = 10;
    wire [6:0] a_to_g_0;
	wire [6:0] a_to_g_1;
    wire [7:0] an;
    initial//…Ë÷√ CLK
    	forever
            #10 clk_100MHz = ~clk_100MHz;
    initial
    begin
    	s = 0;
    	numbers = 12;
    	#50 s = 1;
    	#50 s = 0;
    end
	scroll_top sTop(clk_100MHz, s, numbers, a_to_g_0, a_to_g_1, an);
endmodule
