`timescale 1ns / 1ps

module shift_array(
		input wire clk,
		input wire clr,
		input wire [3:0] numbers,
		output wire [31:0] x
    );
    reg [0:63] msg_array;//³¤¶È 16
    wire [3:0] Hundreds;
    wire [3:0] Tens;
    wire [3:0] Ones;
    BCD bcd({4'b0000, numbers}, Hundreds, Tens, Ones);
    
    always @(posedge clk or posedge clr)
    begin
    	if (clr == 1)
    	begin
      		case(numbers)
      			4'b0, 4'b1: msg_array <= 64'hEEEEEEEEEEEEEEEE;
      			4'b10: msg_array <= {32'hAAAAAAAA, 8'hFC, numbers, 16'hDABA, 4'h1};
      		    4'b11: msg_array <= {32'hAAAAAAAA, 8'hFC, numbers, 16'hDABA, 4'h2};
      		 	4'b100: msg_array <= {32'hAAAAAAAA, 8'hFC, numbers, 16'hDABA, 4'h3};
      		    4'b101: msg_array <= {32'hAAAAAAAA, 8'hFC, numbers, 16'hDABA, 4'h5};
      		    4'b110: msg_array <= {32'hAAAAAAAA, 8'hFC, numbers, 16'hDABA, 4'h8};
      		    4'b111: msg_array <= {28'hAAAAAAA, 8'hFC, numbers, 16'hDABA, 8'h13};
      		    4'b1000: msg_array <= {28'hAAAAAAA, 8'hFC, numbers, 16'hDABA, 8'h21};
      		    4'b1001: msg_array <= {28'hAAAAAAA, 8'hFC, numbers, 16'hDABA, 8'h34};
      		    4'b1010: msg_array <= {24'hAAAAAA, 8'hFC, Tens, Ones, 16'hDABA, 8'h55};
      		    4'b1011: msg_array <= {24'hAAAAAA, 8'hFC, Tens, Ones, 16'hDABA, 8'h89};
      		    4'b1100: msg_array <= {20'hAAAAA, 8'hFC, Tens, Ones, 16'hDABA, 12'h144};
      		    4'b1101: msg_array <= {20'hAAAAA, 8'hFC, Tens, Ones, 16'hDABA, 12'h233};
      		    4'b1110: msg_array <= {20'hAAAAA, 8'hFC, Tens, Ones, 16'hDABA, 12'h377};
      		    4'b1111: msg_array <= {20'hAAAAA, 8'hFC, Tens, Ones, 16'hDABA, 12'h610};
      		    default: msg_array <= 64'hAAAAA0FFAAAAA0FF;
       		endcase
       	end
    	else
    	begin
    		msg_array[0:59] <= msg_array[4:63];
    		msg_array[60:63] <= msg_array[0:3];
    	end
    end
    assign x = msg_array[0:31];
endmodule