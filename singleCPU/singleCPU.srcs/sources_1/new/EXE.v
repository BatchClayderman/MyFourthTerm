`timescale 1ns / 1ps

module EXE(
    	input clk,
    	input [31:0] rdata1,	// rs 读出数据
    	input [31:0] rdata2,	// rt 读出数据
    	input shift,			//位移信号
    	input ramWE,			// Ram 写入信号
    	input ram2reg,			// Ram 写入 Reg
	    input imm,				//立即数信号
	    input sign_ext,			//是否符号扩展
	    input [4:0] rs,			// rs 地址
	    input [4:0] rt,			// rt 地址
	    input [4:0] sa,			//位移位数
	    input [15:0] immediate,	//立即数
	    input [3:0] aluOP,		// alu 运算类型
	    output wire [31:0] f,	//运算结果
	    output wire z			//运算结果是否为 0
    );
    reg [31:0] a;				// alu 输入 a 端
    reg [31:0] b;				// alu 输入 b 端
    always @(posedge clk)
	begin
       	#1
		if (shift == 1'b0)	//是否涉及位移操作
			a <= rdata1;	//将 rs 读出数据赋值给 a
		else				//涉及位移操作
			a <= sa;		//将位移位数赋给 a    
		if (imm == 1'b1)	//是否涉及立即数操作
		begin
			if (sign_ext == 1'b1)//是否需要符号扩展
				b <= {{16{immediate[15]}}, immediate};//符号扩展至 32 位
			else//不需要符号扩展
				b <= {16'b0, immediate};//零扩展至 32 位
		end
		else//不涉及立即数操作
			b <= rdata2;//将 rt 读出数据赋值给 b
	end    
    alu myalu(a, b, aluOP, f, z);//实例化 ALU
endmodule