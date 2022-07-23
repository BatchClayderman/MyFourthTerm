`timescale 1ns / 1ps

module sim_1(

    );
	reg a,b,c;				//三个寄存器
	wire d;
	biaojue v(a, b, c, d);	//实例化三人表决源文件对象
	initial
	begin
		a = 0;
		b = 0;
		c = 0;			//初始值为0
	end
	always #10 {a, b, c} = {a, b, c} + 1;		//每延迟10，对abc进行加1，即在0-7之间循环
endmodule
