module baudRateGenerator
#(
    parameter                  M = 326,         // Realacion tick/clock
    parameter                  N = $clog2(M)    // Cantidad de bits del contador log2(326)
)
// El clock de la Basys3 es de 100MHz y se quiere un BR=19200 entonces, 100 MHz/(19200*16) = 326
(
    // INPUTS
    input                       i_clk,
    input                       i_reset,
    
    // OUTPUTS
    output                      o_tick
    
);
    
    // INTERNAL
    reg         [N-1:0]         counter;
	
    always @(posedge i_clk, posedge i_reset) begin
        if (i_reset)
            counter <= 0;
        else if (counter == M)
            counter <= 0;  
        else
          counter <= counter + 1;
    end
    
    // OUTPUT
    assign o_tick = (counter == M);

endmodule