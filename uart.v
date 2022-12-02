`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2020 05:23:03 PM
// Design Name: 
// Module Name: UART
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart
#(
    parameter   NB_DATA     = 8,                // Numero de bits del dato  
				 SB_TICK     = 16                // Ticks for stop bits   
)
(
    //INPUTS
    input wire              i_clk,              
                             i_reset,
                             i_rx,               // Entrada serial al receptor.  
                             i_tx_start,         // Senal de aviso para empezar a transmitir. Se activa por alto. 
    input wire [NB_DATA-1:0] i_tx,              // Datos a transmitir
    //OUTPUTS
    output wire                    o_tx,        // Salida serial desde el transmisor. 
                                   o_tx_done,   // Indica cuando el transmior termino de transmitir un dato.
                                   o_rx_done,   // Indica si el RX termino de recibir un nuevo dato.
                [NB_DATA -1 : 0]   o_rx         // Dato recibido por el receptor. 
    
);
 
    // LOCAL_PARAMETERS
    localparam M = 326;
    localparam N = 9;
    
    //INTERNAL            
    wire                      tick;              // Salida del baud rate generator.                   
                                
    //MODULES
    baudRateGenerator
    #(
        .M            (M),
        .N            (N)
    )
    u_baud_rate_generator
    (
        .i_clk        (i_clk),
        .i_reset      (i_reset),
        .o_tick       (tick)
    );
    
    rx
    #(
        .NB_DATA      (NB_DATA),
        .SB_TICK      (SB_TICK)
    )
    u_rx
    (
        .i_clk        (i_clk),
        .i_reset      (i_reset),
        .i_tick       (tick),
        .i_rx         (i_rx),
        .o_rx_done_tick(o_rx_done),
        .o_data       (o_rx)
    );
    
    tx
    #(
        .NB_DATA      (NB_DATA),
        .SB_TICK      (SB_TICK)
    )
    u_tx
    (
        .i_clk        (i_clk),
        .i_reset      (i_reset),
        .i_tick       (tick),
        .i_tx_start   (i_tx_start),
        .i_data       (i_tx),
        .o_tx_done_tick(o_tx_done),
        .o_tx         (o_tx)
    );                               
endmodule