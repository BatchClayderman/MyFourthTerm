`timescale 1ns / 1ps

module rom(
		input [31:0] addr,  //输入地址
		output [31:0] data  //读出指令
	);
	reg [31:0] romdata;
	always @(*)
		case(addr[31:2])	//舍去地址末两位以便按一递增
			30'h0: romdata = 32'h8c030020; //lw $0,$3,20h--ram(20h)->$3
			30'h1: romdata = 32'h20010001; //addi $0,$1,1--$0+1->$1
			30'h2: romdata = 32'h20020001; //addi $0,$2,1--$0+1->$2
			30'h3: romdata = 32'h20050002; //addi $0,$5,2--$0+2->$5
			30'h4: romdata = 32'h20a50001; //addi $5,$5,1--$5+1->$5
			30'h5: romdata = 32'h00222020; //add $1,$2,$4--$1+$2->$4
			30'h6: romdata = 32'h20410000; //addi $2,$1,0--$2+0->$1
			30'h7: romdata = 32'h20820000; //addi $4,$2,0--$4+0->$2
			30'h8: romdata = 32'haca40000; //sw $5,$4,0--$4->ram($5)
			30'h9: romdata = 32'hac040010; //sw $0,$4,10h--$4->ram(10h)
			30'ha: romdata = 32'h1465fffa;  //bne $3,$5,-6--if($3!=$5) jump -6
			default: romdata =32'h0;
		endcase	
	initial
		$monitor($time, , "IF/rom: read Rom %h -> data = %h", addr, data); 
	assign data = romdata;
endmodule