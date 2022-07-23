`timescale 1ns/1ps

module uart_tx_ctl(
	input            clk_tx,          // Clock input
	input            rst_clk_tx,      // Active HIGH reset - synchronous to clk_tx
	input            baud_x16_en,     // 16x bit oversampling pulse
	input            char_fifo_empty, // Empty signal from char FIFO (FWFT)
	input      [7:0] char_fifo_dout,  // Data from the char FIFO
	output           char_fifo_rd_en, // Pop signal to the char FIFO
	output reg       txd_tx           // The transmit serial signal
);
	
	
	//***************************************************************************
	// Parameter definitions
	//***************************************************************************
	localparam// State encoding for main FSM 
	IDLE  = 2'b00,
	START = 2'b01,
	DATA  = 2'b10,
	STOP  = 2'b11;
	
	
	//***************************************************************************
	// Reg declarations
	//***************************************************************************
	reg [1:0]    state;             // Main state machine
	reg [3:0]    over_sample_cnt;   // Oversample counter - 16 per bit
	reg [2:0]    bit_cnt;           // Bit counter - which bit are we RXing
	reg          char_fifo_pop;     // POP indication to FIFO
									// ANDed with baud_x16_en before module
									// output
	
	
	//***************************************************************************
	// Wire declarations
	//***************************************************************************
	wire         over_sample_cnt_done; // We are in the middle of a bit
	wire         bit_cnt_done;         // This is the last data bit
	
	
	//***************************************************************************
	// Code
	//***************************************************************************	
	always @(posedge clk_tx)// Main state machine
	begin
		if (rst_clk_tx)
		begin
			state         <= IDLE;
			char_fifo_pop <= 1'b0;
		end
		else
		begin
			if (baud_x16_en) 
			begin
				char_fifo_pop <= 1'b0;
				case (state)
					IDLE:
					begin// When the character FIFO is not empty, transition to the START state
						if (!char_fifo_empty)
						begin
							state <= START;
						end
					end // IDLE state
					START:
					begin
						if (over_sample_cnt_done)
						begin
							state <= DATA;
						end // if over_sample_cnt_done
					end // START state
					DATA:
					begin// Once the last bit has been transmitted, send the stop bit and, we need to POP the FIFO as well
			 			if (over_sample_cnt_done && bit_cnt_done)
						begin
							char_fifo_pop <= 1'b1;
							state         <= STOP;
						end
					end // DATA state
					STOP:
					begin
						if (over_sample_cnt_done)
						begin// If there is no new character to start, return to IDLE, else start it right away
							if (char_fifo_empty)
							begin
								state <= IDLE;
							end
							else
							begin
								state <= START;
							end
						end
					end // STOP state
				endcase
			end // end if baud_x16_en
		end // end if rst_clk_tx
	end // end always 

	/* Assert the rd_en to the FIFO for only ONE clock period */
	assign char_fifo_rd_en = char_fifo_pop && baud_x16_en;
	always @(posedge clk_tx)
	begin
		if (rst_clk_tx)
		begin
			over_sample_cnt <= 4'd0;
		end
		else
		begin
			if (baud_x16_en) 
			begin
				if (!over_sample_cnt_done)
				begin
					over_sample_cnt <= over_sample_cnt - 1'b1;
				end
				else
				begin
					if (((state == IDLE) && !char_fifo_empty) ||
						(state == START) || 
						(state == DATA)  ||
						((state == STOP) && !char_fifo_empty))
					begin
						over_sample_cnt <= 4'd15;
					end
				end
			end // end if baud_x16_en
		end // end if rst_clk_tx
	end // end always 

	assign over_sample_cnt_done = (over_sample_cnt == 4'd0);
	always @(posedge clk_tx)
	begin
		if (rst_clk_tx)
		begin
			bit_cnt <= 3'b0;
		end
		else
		begin
			if (baud_x16_en) 
			begin
				if (over_sample_cnt_done)
				begin
					if (state == START)
					begin
						bit_cnt <= 3'd0;
					end
					else if (state == DATA)
					begin
						bit_cnt <= bit_cnt + 1'b1;
					end
				end // end if over_sample_cnt_done
			end // end if baud_x16_en
		end // end if rst_clk_tx
	end // end always 

	assign bit_cnt_done = (bit_cnt == 3'd7);
	always @(posedge clk_tx)// Generate the output
	begin
		if (rst_clk_tx)
		begin
			txd_tx <= 1'b1;
		end
		else
		begin
			if (baud_x16_en)
			begin
				if ((state == STOP) || (state == IDLE))
				begin
					txd_tx <= 1'b1;
				end
				else if (state == START)
				begin
					txd_tx <= 1'b0;
				end
				else // we are in DATA
				begin
					txd_tx <= char_fifo_dout[bit_cnt];
				end
			end // end if baud_x16_en
		end // end if rst
	end // end always



endmodule