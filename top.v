`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2020 07:33:25 PM
// Design Name: 
// Module Name: top
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

module top
#(
    parameter   NB_DATA         = 8,                    // # data bits
    parameter   NB_CODE         = 6,                    // Bits de codigo
    parameter   NB_STATE        = 4,                    //Permite setear la cantidad de estados.             
    parameter   SB_TICK         = 16    
 )
 (
    // INPUTS
    input wire                  i_clk,
                                i_reset,
                                i_rx,                   // Entrada serial al receptor. 
    // OUTPUTS   
    output wire                 o_tx                   // Salida serial al transmisor. 
 );
 
    // INTERNALS
    wire                        rx_done,                // Conecta la salida de UART con interfaz. Indica que se recibio un nuevo dato.Se activa por alto.
                                alu_done,               // Conecta la interfaz con la UART. Indica que el calculo esta listo para ser transmitido. Se activa por alto.
                                tx_done;                // Salida de la UART, indica que se termino de transmitir el dato.  
    wire    [NB_DATA - 1 : 0]   interface_data_out;    // Conecta la interfaz con la UART. Es el dato a transmitir cuando se recibe la senal alu_done.
    wire    [NB_DATA - 1 : 0]   interface_data_in;     // Conecta la UART con la interfaz. Es el dato recibido por el receptor, se recibe cuando se recibe la senal rx_done.
                                      
    // MODULES
    uart
    #(
        .NB_DATA        (NB_DATA),
        .SB_TICK        (SB_TICK)
    )
    u_uart
    (
        .i_clk          (i_clk),
        .i_reset        (i_reset),
        .i_rx           (i_rx),
        .i_tx_start     (alu_done),
        .i_tx           (interface_data_out),
        .o_tx           (o_tx),
        .o_tx_done      (tx_done),
        .o_rx_done      (rx_done),
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