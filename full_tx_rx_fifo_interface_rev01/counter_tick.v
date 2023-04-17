// Code your design here
`timescale 1ns / 1ps

module mod_m_counter
	#(
		parameter 	N = 4, 	// number of bits in counter
					M = 10	// mod-M

	)
	(
		input 	wire 				clk, reset,
		output	wire 				max_tick,
		output 	wire 	[N-1:0] 	q
	);

	reg 	[N-1:0] r_reg;
	wire 	[N-1:0] r_next;

	//register
	always @( posedge clk, posedge reset)
		if (reset)
			r_reg <= 0 ;
		else
			r_reg <= r_next;

// next-state logic
	assign r_next = (r_reg == (M-1)) ? 0 : r_reg + 1;

// output logic
	assign q = r_reg;
	assign max_tick = (r_reg == (M-1)) ? 1'b1 : 1'b0;

endmodule