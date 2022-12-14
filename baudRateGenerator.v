`timescale 1ns / 1ps

module baudRateGenerator
#(
    parameter BAUD_RATE = 9600,
    parameter CLK_FREC = 50000000
)
// El clock de la Basys3 es de 100MHz y se quiere un BR=19200 entonces, 100 MHz/(19200*16) = 326
(
    input                       i_clk,
    input                       i_reset,
    output                      o_tick
    
);
    localparam RESULTADO = CLK_FREC/(BAUD_RATE*16);     //Para 9600 da 325
	reg [15:0] contador=0;
	
    always @(posedge i_clk, posedge i_reset) begin
        if (i_reset)
            contador <= 0;
        else if (contador == RESULTADO)
            contador <= 0;  
        else
          contador <= contador + 1;
    end
    
    assign o_tick = (contador == RESULTADO);

endmodule