`timescale 1ns / 1ps

module sim_1(

    );
	reg a,b,c;				//�����Ĵ���
	wire d;
	biaojue v(a, b, c, d);	//ʵ�������˱��Դ�ļ�����
	initial
	begin
		a = 0;
		b = 0;
		c = 0;			//��ʼֵΪ0
	end
	always #10 {a, b, c} = {a, b, c} + 1;		//ÿ�ӳ�10����abc���м�1������0-7֮��ѭ��
endmodule
