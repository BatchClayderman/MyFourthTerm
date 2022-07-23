`timescale 1ns / 1ps

module sim_1(
		
    );
    reg clk = 1'b0;
    reg rst = 1'b0;
    reg [3:0] n;
    reg [4:4] s;
    wire [11:0] result;
    wire [6:0] a_to_g_0;
    wire [6:0] a_to_g_1;
	wire [7:0] an;
	wire led;
    initial//设置 CLK
        forever
            #10 clk = ~clk;// forever #10 相当于 100MHz，即 P17 接口
    initial
    begin
    	s = 0;
    	//n = 4'b0101;
    	n = 4'b1101;
    	#11 rst = 1'b1;//重置复位
    	#50 s = 1;
    	#50 s = 0;
    end
    
    /* 实例化 filter */
    filter f(clk, s, rst, n, result, a_to_g_0, a_to_g_1, an, led);
endmodule