`timescale 1ns / 1ps

module sim_1(

	);
	reg clk;
	reg oc = 1'b0;
	reg [4:0] ra1, ra2, wa;
	reg [31:0] wd;
	wire we = 1'b1;
	wire [31:0] a, b, f;
	parameter op = 4'b0001;//¼Ó·¨
    
	initial
	begin
		clk = 1'b0;
		forever #4 clk = ~clk;
	end
	
	reg [3:0] n = 4'b1010;// n = 10
	reg [1:0] state = 2'b00;
	reg [3:0] count = 4'b0010;
	reg rst = 1'b1;
	
	always@(posedge clk)
	begin
		if (rst == 1'b0)//¸´Î»
		begin
			state <= 2'b00;
			count <= 2;
		end
		else
		begin
			case(state)
			2'b00:
				begin
					ra1 <= 5'b1;
					ra2 <= 5'b10;
					wa <= 5'b1;
					wd <= 32'b1;
					state <= 2'b01;
				end
			2'b01:
				begin
					wa <= 2'b10;
					wd <= 32'b1;
					state <= 2'b10;
				end
			2'b10:
				begin
					wa <= ra2 + 1;
					wd = f;
					state = 2'b11;
					count = count + 1;
				end
			2'b11:
				begin
					if (count < n)
					begin
						ra1 <= ra2;
						ra2 <= wa;
						state <= 2'b10;
					end
				end
			default:
				begin
					state <= 2'b00;
				end
			endcase
		end
	end
	alu alu(a, b, op, f);
	registers rgs(clk, oc, ra1, ra2, wa, wd, we, a, b);
endmodule