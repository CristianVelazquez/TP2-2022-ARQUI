`timescale 1ns / 1ps

module uart
#(
    parameter   NB_DATA     = 8,                      // # data bits 
	parameter   SB_TICK     = 16,                      // # ticks for stop bits
	parameter   NB_STATE    = 2      
)
(
    input wire                         i_clk,              
    input wire                         i_reset,
    input wire                         i_rx,               
    input wire                         i_tx_start,          
    input wire  [NB_DATA-1:0]          i_tx,              
    
    output wire                        o_tx,        
    output wire                        o_tx_done_tick,  
    output wire                        o_rx_done_tick,   
    output wire [NB_DATA -1 : 0]       o_rx         
    
);
 
    localparam BAUD_RATE = 9600;
    localparam CLK_FREC = 50000000;
              
    wire                               tick;                      
                                
    baudRateGenerator
    #(
        .BAUD_RATE (BAUD_RATE),
        .CLK_FREC (CLK_FREC)
    )
    u_baud_rate_generator
    (
        .i_reset      (i_reset),
        .i_clk        (i_clk),
        .o_tick       (tick)
    );
    
    rx
    #(
        .NB_DATA      (NB_DATA),
        .SB_TICK      (SB_TICK),
        .NB_STATE     (NB_STATE)
    )
    u_rx
    (
        .i_reset          (i_reset),
        .i_clk            (i_clk),
        .i_tick           (tick),
        .i_rx             (i_rx),
        .o_rx_done_tick   (o_rx_done_tick),
        .o_data           (o_rx)
    );
    
    tx
    #(
        .NB_DATA      (NB_DATA),
        .SB_TICK      (SB_TICK),
        .NB_STATE     (NB_STATE)
    )
    u_tx
    (
        .i_clk        (i_clk),
        .i_reset      (i_reset),
        .i_tick       (tick),
        .i_tx_start   (i_tx_start),
        .i_data       (i_tx),
        .o_tx_done_tick(o_tx_done_tick),
        .o_tx         (o_tx)
    );                               
endmodule