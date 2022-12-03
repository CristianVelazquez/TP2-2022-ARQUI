`timescale 1ns / 1ps

module top
#(
    parameter   NB_DATA         = 8,                    
    parameter   NB_CODE         = 6,                    
    parameter   NB_STATE        = 2,                             
    parameter   SB_TICK         = 16    
 )
 (
    input wire                  i_clk,
    input wire                  i_reset,
    input wire                  i_rx,                  
    output wire                 o_tx                    
 );
 
    wire                        rx_done;                
    wire                        alu_done;               
    wire                        tx_done;               
    wire    [NB_DATA - 1 : 0]   interface_data_out;    // Conectamos la interfaz con UART. DATA a transmitir cuando se recibe la signal alu_done.
    wire    [NB_DATA - 1 : 0]   interface_data_in;     // Conectamos la UART con la interfaz. DATA recibida por el receptor, se recibe cuando se recibe la signal rx_done.
                                      
    uart
    #(
        .NB_DATA        (NB_DATA),
        .SB_TICK        (SB_TICK),
        .NB_STATE       (NB_STATE)
    )
    u_uart
    (
        .i_clk          (i_clk),
        .i_reset        (i_reset),
        .i_rx           (i_rx),
        .i_tx_start     (alu_done),
        .i_tx           (interface_data_out),
        .o_tx           (o_tx),
        .o_tx_done_tick (tx_done),
        .o_rx_done_tick (rx_done),
        .o_rx           (interface_data_in)
    );
 
    interfaz
    #(
        .NB_DATA        (NB_DATA),
        .NB_CODE        (NB_CODE),
        .NB_STATE       (NB_STATE)
    )
    u_interfaz
    (
        .i_clk          (i_clk),
        .i_reset        (i_reset),
        .i_rx_done      (rx_done),
        .i_data         (interface_data_in),
        .o_data_ready   (alu_done),
        .o_data         (interface_data_out)
    );

endmodule