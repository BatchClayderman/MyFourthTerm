`timescale 1ns/1ps

module resp_gen(
		input             clk_rx,			// Clock input
		input             rst_clk_rx,		// Active HIGH reset - synchronous to clk_rx
	
		/* From Character FIFO */
		input             char_fifo_full,	// The char_fifo is full
	
		/* To/From the Command Parser */
		input             send_char_val,	// A character is ready to be sent
		input      [7:0]  send_char,		// Character to be sent
	
		input             send_resp_val,	// A response is requested
		input      [1:0]  send_resp_type,	// Type of response - see localparams
		input      [15:0] send_resp_data,	// Data to be output
	
		output reg        send_resp_done,	// The response generation is complete
	
		/* To character FIFO */
		output reg [7:0]  char_fifo_din,	// Character to push into the FIFO
											// char_fifo_din is NOT from a flop
		output            char_fifo_wr_en	// Write enable (push) for the FIFO
);
	
	
	//***************************************************************************
	// Parameter definitions
	//***************************************************************************
	
	`include "clogb2.txt"

	function [31:0] max;
		input [31:0] a;
		input [31:0] b;
		begin
			max = (a >= b) ? a : b;//求最大值
		end
	endfunction

	function [7:0] to_digit;// char -> int
		input [3:0] val;
		begin
		if (val < 4'd10)//数字字符
			to_digit = 8'h30 + val; // 8'h30 is the character '0'
		else//英文字母
			to_digit = 8'h57 + val; // 8'h57 + 10 is 8'h61 - the character 'a' 
		end
	endfunction
	
	
	//***************************************************************************
	// Parameter definitions
	//***************************************************************************

	localparam [1:0]
	RESP_OK   = 2'b00,
	RESP_ERR  = 2'b01,
	RESP_DATA = 2'b11;

	localparam
	STR_OK_LEN   = 5,  // -OK\n
	STR_ERR_LEN  = 6,  // -ERR\n
	STR_DATA_LEN = 13; // -HHHH DDDDD\n

	localparam STR_LEN = max(max(STR_OK_LEN, STR_ERR_LEN), STR_DATA_LEN);

	localparam CNT_WID = clogb2(STR_LEN);   // Must hold 0 to STR_LEN-1

	localparam LEN_WID = clogb2(STR_LEN+1); // Must hold the value STR_LEN

	localparam
	IDLE    = 1'b0,
	SENDING = 1'b1;
	
	 
	//***************************************************************************
	// Reg declarations
	//***************************************************************************
	reg               state;    // State variable
	reg [CNT_WID-1:0] char_cnt; // Current character being sent
	
	
	//***************************************************************************
	// Wire declarations
	//***************************************************************************
	/* From to_dec */
	wire [5*4-1-1:0]     bcd_out;         // 0 to 6 只需要 3 比特
	wire [LEN_WID-1:0]   str_to_send_len; // 发出字符串的长度
	
	
	//***************************************************************************
	// Code
	//***************************************************************************
	/* Instantiate the Binary Coded Decimal converter */

	to_bcd to_bcd_i0(
		.clk_rx     (clk_rx),
		.rst_clk_rx (rst_clk_rx),
		.value_val  (send_resp_val && (send_resp_type == RESP_DATA)),
		.value      (send_resp_data),
		.bcd_out    (bcd_out)
	);
	
	
	assign str_to_send_len = (send_resp_type == RESP_OK)  ? STR_OK_LEN  :
							 (send_resp_type == RESP_ERR) ? STR_ERR_LEN : 
															STR_DATA_LEN;

	/* Echo the incoming character to the output if there is room in the FIFO */
	always @(posedge clk_rx)
	begin
		if (rst_clk_rx)
		begin
			state           <= IDLE;
			char_cnt        <= 0;
			send_resp_done  <= 1'b0;
		end
		else if (state == IDLE)
		begin
			send_resp_done <= 1'b0;
			if (send_resp_val && !send_resp_done)  // A new response is requested
			begin
				state    <= SENDING;
				char_cnt <= 0;
			end
		end 
		else // Not in IDLE state
		begin // So are in sending state
			if (!char_fifo_full)
			begin
				if (char_cnt == (str_to_send_len - 1'b1))// We will send a character this clock 
				begin// This will be the last one
					state          <= IDLE; // Return to IDLE
					send_resp_done <= 1'b1; // Signal cmd_parse that we are done
				end
				else
				begin
					char_cnt <= char_cnt + 1'b1;
				end
			end // end if !char_fifo_full
		end // end if STATE
	end // end always

	assign char_fifo_wr_en = 
			((state == IDLE) && send_char_val) ||
			((state == SENDING) && !char_fifo_full) ;

	always @(*)
	begin
		if (state == IDLE)
		begin
			char_fifo_din = send_char;
		end
		else
		begin
			if (send_resp_type == RESP_OK) 
			begin
				case (char_cnt) // synthesis full_case
					0: char_fifo_din = "-"; // Dash
					1: char_fifo_din = "O";
					2: char_fifo_din = "K";
					3: char_fifo_din = 8'h0d; // Newline
					4: char_fifo_din = 8'h0a; // LineFeed
				endcase
			end
			else if (send_resp_type == RESP_ERR)
			begin
				case (char_cnt) // synthesis full_case
					0: char_fifo_din = "-"; // Dash
					1: char_fifo_din = "E";
					2: char_fifo_din = "R";
					3: char_fifo_din = "R";
					4: char_fifo_din = 8'h0d; // Newline
					5: char_fifo_din = 8'h0a; // LineFeed
				endcase
			end
			else // It is RESP_DATA
			begin
				case(char_cnt) // synthesis full_case
					0: char_fifo_din = "-"; // Dash
					1: char_fifo_din = to_digit(send_resp_data[15:12]);
					2: char_fifo_din = to_digit(send_resp_data[11:8 ]);
					3: char_fifo_din = to_digit(send_resp_data[ 7:4 ]);
					4: char_fifo_din = to_digit(send_resp_data[ 3:0 ]);
					5: char_fifo_din = " "; // Space
					6: char_fifo_din = to_digit({1'b0,bcd_out[18:16]});
					7: char_fifo_din = to_digit(bcd_out[15:12]);
					8: char_fifo_din = to_digit(bcd_out[11:8 ]);
					9: char_fifo_din = to_digit(bcd_out[ 7:4 ]);
					10: char_fifo_din = to_digit(bcd_out[ 3:0 ]);
					11: char_fifo_din = 8'h0d; // Newline
					12: char_fifo_din = 8'h0a; // LineFeed
				endcase
			end // if RESP_DATA
		end // end if send_char
	end // end always


endmodule