`timescale 1ns / 1ps

module registers(
		input clk,
		input oc,
		input [4:0] raddr1,
		input [4:0] raddr2,
		input [4:0] waddr,
		input [31:0] wdata,
		input we,
		output reg [31:0] rdata1,
		output reg [31:0] rdata2
	);
	reg [31:0] regts[1:31];
	
	always@(*)
	begin
		if (oc == 1'b1)
		begin
			rdata1 <= 32'bz;
		end
		else if (raddr1 == 5'b00000)
		begin
			rdata1 <= 32'b0;
		end
		else
		begin
			rdata1 <= regts[raddr1];
			rdata2 <= regts[raddr2];
		end
	$monitor($time, , "read data1 = %d, data2 = %d", rdata1, rdata2);
	end
	
	always@(posedge clk)//ÏÂ½µÑØÓĞĞ§
	begin
		#1 if (we == 1'b1 && waddr != 5'b00000)
		begin
			regts[waddr] <= wdata;
			$monitor($time, , "write %h to %d", wdata, waddr);
		end
	end
endmodule