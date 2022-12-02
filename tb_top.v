`timescale 1ns / 1ps

module tb_top();

    localparam NB_STATE    = 4;
    localparam NB_DATA     = 8;   //Cantidad de bits
    localparam SB_TICK     = 16; //Numero de Ticks que dura un bit 
    localparam NB_CODE     = 6;
    localparam I_DATA_A    = 8'b11; //3
    localparam I_DATA_B    = 8'b1000; //8
    localparam OP_CODE     = 6'b100000;// SUMA

    reg                     i_clk;
    reg                     i_reset;
    wire                    i_rx_top;
    wire                    o_tx_top;    
    reg     [NB_DATA-1:0]   i_tx_uart;
    reg                     i_tx_start;
    wire                    o_tx_done;
    wire                    o_rx_done;
    wire    [NB_DATA-1:0]   o_rx_uart;
    
    
    initial begin
        i_clk = 1'b0;
        i_reset = 1'b1;
        i_tx_start = 1'b0;
        
        #10
        i_reset = 1'b0;
        //ENVIO EL PRIMER DATO        
        #10
        i_tx_start = 1'b1;  
        i_tx_uart = I_DATA_A;
        
        #20
        i_tx_start = 1'b0; 
        
        #1050000
        i_tx_start = 1'b1; 
        i_tx_uart = I_DATA_B;
        
        #20
        i_tx_start = 1'b0; 
        
        #1050000
        i_tx_start = 1'b1; 
        i_tx_uart = OP_CODE;
        
        #20
        i_tx_start = 1'b0; 
        
        #1050000
             
        $display("############# Test TERMINADO ############");
        $finish();
    end
    
    top
    #(
        .NB_CODE        (NB_CODE),
        .SB_TICK        (SB_TICK),
        .NB_DATA        (NB_DATA),
        .NB_STATE       (NB_STATE)
    )
    u_top
    (
        .i_clk          (i_clk),
        .i_reset        (i_reset),
        .i_rx           (i_rx_top),
        .o_tx           (o_tx_top)
    );
    
    uart
    #(
        .NB_DATA          (NB_DATA),
        .SB_TICK          (SB_TICK)
    )
    u_uart
    (
        .i_rx             (o_tx_top), 
        .i_tx_start       (i_tx_start),
        .i_tx             (i_tx_uart),
        .i_clk            (i_clk),
        .i_reset          (i_reset), 
        .o_tx             (i_rx_top),
        .o_tx_done        (o_tx_done),
        .o_rx_done        (o_rx_done),
        .o_rx             (o_rx_uart)
    );
         
   always #10 i_clk = ~i_clk;

   // Se testea la salida
   always @(posedge i_clk) begin       
       if (o_rx_done) begin            // Verifico el dato recibido
            if (o_rx_uart != (I_DATA_A+I_DATA_B)) begin
                $display("********** Test FALLIDO **********");
                $finish();
            end
            else begin
                $display("**********Test CORRECTO, resultado = %b **********",o_rx_uart);
           end
       end
   end
endmodule
