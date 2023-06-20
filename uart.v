// Code your design here
`timescale 1ns / 1ps

module uart
	
	#(  // Default setting:
		// 38,400 baud, 8 data bits, 1 stop bit, 2^2 FIFO 
		parameter 	DBIT = 8,			// # data bits
					SB_TICK = 16, 		// # ticks for stop bits,
										// 16/24/32 for 1/1.5/2 bits
					DVSR = 163,			// baud rate divisor
										// DVSR = 100MHZ/(16 * baud rate)
					DVSR_BIT = 8, 		// # bits of DVSR
					FIFO_W = 2	,		// # addr bits of FIFO
										// # words i n FIFO=2"FIFO-W
										
					
					NB_DATA = 8,                   
       				NB_CODE = 6,                  
       				NB_STATE = 2
	)
	(
		input	wire 			clk, reset,
		input 	wire 			rd_uart, rx,
		output 	wire 	[7:0] 	r_data,
		output  wire 	[7:0] 	tx_fifo_out,
		output 	wire 			tx_full, tx,
		input   wire            wr_uart
	);

	// signal declaration
	wire 			tick, rx_done_tick, tx_done_tick;
	wire 	[7:0] 	rx_data_out;
	//wire 			wr_uart;
    //wire 	[7:0] 	tx_fifo_out;  //como output para mostrar en los leds
    wire            tx_fifo_not_empt;
    wire 			tx_empty;
    wire   [7:0]    data;

	//body
	mod_m_counter #(.M(DVSR), .N(DVSR_BIT)) baud_gen_unit
		( .clk(clk), .reset(reset), .q(), .max_tick(tick));

	uart_rx #( .DBIT(DBIT), .SB_TICK(SB_TICK)) uart_rx_unit
		( .clk(clk), .reset(reset), .rx(rx), .s_tick(tick),
		.rx_done_tick(rx_done_tick), .dout(rx_data_out));

	fifo #(.B(DBIT), .W(FIFO_W)) fifo_rx_unit
		(.clk(clk), .reset(reset), .rd(rd_uart),
		.wr(rx_done_tick), .w_data(rx_data_out), 
		.empty(rx_empty), .full(), .r_data(r_data));
  //TX		 
	fifo #(.B(DBIT), .W(FIFO_W)) fifo_tx_unit
		(.clk(clk), .reset(reset), .rd(tx_done_tick),
		.wr(wr_uart), .w_data(data), .empty(tx_empty),
		.full(tx_full), .r_data(tx_fifo_out));

	uart_tx #( .DBIT(DBIT), .SB_TICK(SB_TICK)) uart_tx_unit
		( .clk(clk), .reset(reset), .tx_start(tx_fifo_not_empty), 
		.s_tick(tick), .din(tx_fifo_out),
		.tx_done_tick(tx_done_tick), .tx(tx));	

	
  interfaz
    #(
        .NB_DATA        (NB_DATA),
        .NB_CODE        (NB_CODE),
        .NB_STATE       (NB_STATE)
    )
    u_interfaz
    (
        .i_clk          (clk),
        .i_reset        (reset),
        .i_rx_done		(rx_done_tick),                        
    	.i_data			(rx_data_out), 
        .o_data         (data)
        //.o_data_ready    (wr_uart)
    );
    
    assign tx_fifo_not_empty = ~tx_empty;

//mapear clk,reset,rx input, rd_uart = ? input pulsador, rx_empty = debug, r_data = 7 leds

endmodule


