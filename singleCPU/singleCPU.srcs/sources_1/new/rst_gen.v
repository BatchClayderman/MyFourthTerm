`timescale 1ns/1ps

module rst_gen(
		input             clk_rx,          // Receive clock
		input             clk_tx,          // Transmit clock
		input             clk_samp,        // Sample clock
		input             rst_i,           // Asynchronous input - from IBUF
		input             clock_locked,    // Locked signal from clk_core
		
		output            rst_clk_rx,      // Reset, synchronized to clk_rx
		output            rst_clk_tx,      // Reset, synchronized to clk_tx
		output            rst_clk_samp     // Reset, synchronized to clk_samp
	);
	wire int_rst;
	assign int_rst = rst_i || !clock_locked;
	
	
	/* สตภýปฏ reset bridges */
	reset_bridge reset_bridge_clk_rx_i0(// clk_rx
		.clk_dst   (clk_rx),
		.rst_in    (int_rst),
		.rst_dst   (rst_clk_rx)
	);
	
	reset_bridge reset_bridge_clk_tx_i0(// clk_tx
		.clk_dst   (clk_tx),
		.rst_in    (int_rst),
		.rst_dst   (rst_clk_tx)
	);
		
	reset_bridge reset_bridge_clk_samp_i0(// clk_samp
		.clk_dst   (clk_samp),
		.rst_in    (int_rst),
		.rst_dst   (rst_clk_samp)
	);


endmodule