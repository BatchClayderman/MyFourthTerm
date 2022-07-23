`timescale 1ns/1ps

module debouncer(
		input            clk,          // Clock input
		input            rst,          // Active HIGH reset - synchronous to clk
		
		input            signal_in,    // Undebounced signal
		output           signal_out    // Debounced signal
	);
	
	
	//***************************************************************************
	// Function definitions
	//***************************************************************************
	`include "clogb2.txt"
	
	
	//***************************************************************************
	// Parameter definitions
	//***************************************************************************
	parameter	FILTER = 200_000_000;     // Number of clocks required for a switch
	localparam
	RELOAD = FILTER - 1,
	FILTER_WIDTH = clogb2(FILTER);
	
	
	//***************************************************************************
	// Reg declarations
	//***************************************************************************
	reg signal_out_reg;//当前输出
	reg [FILTER_WIDTH-1:0] cnt;//计数器
	
	
	//***************************************************************************
	// Wire declarations
	//***************************************************************************
	wire signal_in_clk; // Synchronized to clk


	//***************************************************************************
	// Code
	//***************************************************************************
	meta_harden meta_harden_signal_in_i0 (// signal_in is not synchronous to clk - use a metastability hardener to synchronize it
		.clk_dst       (clk),
		.rst_dst       (rst),
		.signal_src    (signal_in),
		.signal_dst    (signal_in_clk)
	);

	always @(posedge clk)
	begin
		if (rst)
		begin
			signal_out_reg <= signal_in_clk;
			cnt            <= RELOAD;
		end
		else // !rst
		begin
			if (signal_in_clk == signal_out_reg)
			begin
				// The input is not different then the current filtered value. 
				// Reload the counter so that it is ready to count down in case it is different during the next clock. 
				cnt <= RELOAD;
			end
			else if (cnt == 0) // The counter expired and we are still not equal
			begin // Take the new value, and reload the counter
				signal_out_reg <= signal_in_clk;
				cnt            <= RELOAD;
			end
			else // The counter is not 0
			begin
				cnt <= cnt - 1'b1; // decrement it
			end
		end // end if rst
	end // end always
	assign signal_out = signal_out_reg;
	
	
	
endmodule