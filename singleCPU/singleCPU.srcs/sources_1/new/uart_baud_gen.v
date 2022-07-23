`timescale 1ns/1ps

module uart_baud_gen ( // Write side inputs
		input        clk,          // Clock input
		input        rst,          // Active HIGH reset - synchronous to clk
		output       baud_x16_en   // Oversampled Baud rate enable
	);
	
	
	//***************************************************************************
	// Constant Functions
	//***************************************************************************
	function integer clogb2;
	input [31:0] value;
	reg [31:0] my_value;
	begin
		my_value = value - 1;
		for (clogb2 = 0; my_value > 0; clogb2 = clogb2 + 1)
			my_value = my_value >> 1;
	end
	endfunction
	
	
	//***************************************************************************
	// Parameter definitions
	//***************************************************************************
	parameter BAUD_RATE    = 57_600;              // Baud rate
	parameter CLOCK_RATE   = 50_000_000;

	/* The OVERSAMPLE_RATE is the BAUD_RATE times 16 */
	localparam OVERSAMPLE_RATE = BAUD_RATE * 16;

	/* The divider is the CLOCK_RATE / OVERSAMPLE_RATE - rounded up */
	localparam DIVIDER = (CLOCK_RATE+OVERSAMPLE_RATE/2) / OVERSAMPLE_RATE;// (so add 1/2 of the OVERSAMPLE_RATE before the integer division)

	/* The value to reload the counter is DIVIDER - 1; */
	localparam OVERSAMPLE_VALUE = DIVIDER - 1;

	/* The required width of the counter is the ceiling of the base 2 logarithm of the DIVIDER */
	localparam CNT_WID = clogb2(DIVIDER);
	
	
	//***************************************************************************
	// Reg declarations
	//***************************************************************************
	reg [CNT_WID-1:0] internal_count;
	reg               baud_x16_en_reg;
	
	
	//***************************************************************************
	// Wire declarations
	//***************************************************************************
	wire [CNT_WID-1:0] internal_count_m_1; // Count minus 1


	//***************************************************************************
	// Code
	//***************************************************************************
	assign internal_count_m_1 = internal_count - 1'b1;
	always @(posedge clk)
	begin
		if (rst)
		begin
			internal_count <= OVERSAMPLE_VALUE;
			baud_x16_en_reg <= 1'b0;
		end
		else
		begin
			/* Assert baud_x16_en_reg in the next clock when internal_count will be zero in that clock (thus when internal_count_m_1 is 0) */
			baud_x16_en_reg <= (internal_count_m_1 == {CNT_WID{1'b0}});
			
			/* Count from OVERSAMPLE_VALUE down to 0 repeatedly */
			if (internal_count == {CNT_WID{1'b0}}) 
			begin
				internal_count <= OVERSAMPLE_VALUE;
			end
			else // internal_count is not 0
			begin
				internal_count <= internal_count_m_1;
			end
		end // end if rst
	end // end always 
	assign baud_x16_en = baud_x16_en_reg;
endmodule
