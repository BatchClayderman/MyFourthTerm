`timescale 1ns / 1ps

module seq_11001_1(
		input clk,
		output led
    );
    
    reg [31:0] divclk_cnt = 0;
    reg divclk = 0;
    reg q0 = 0;
    reg q1 = 0;
    reg q2 = 0;
    always@(posedge clk)
    begin
    	if (divclk_cnt == 25000000)
    	begin
    		divclk = ~divclk;
    		divclk_cnt = 0;
    	end
    	else
    	begin
    		divclk_cnt = divclk_cnt + 1'b1;
    	end
    end
    always@(posedge divclk)
    begin
		q0 <= q1 & q2;
		q1 <= ~q1 & q2 | q1 & ~q2;
		q2 <= ~q0 & ~q2;
    end
    assign led = ~q1;
endmodule
