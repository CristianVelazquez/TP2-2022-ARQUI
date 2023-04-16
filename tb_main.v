`timescale 1ns / 1ps

module tb_main();

    localparam NB_STATE    = 2;
    localparam NB_DATA     = 8;   //Cantidad de bits
    localparam SB_TICK     = 16; //Numero de Ticks que dura un bit 
    localparam NB_CODE     = 6;
    localparam I_DATA_A    = 8'b11; //3
    localparam I_DATA_B    = 8'b11; //8
    localparam OP_CODE     = 6'b100000;// SUMA

    reg                     i_clk;
    reg                     i_reset;
    reg [NB_DATA - 1 : 0]   interface_data_in;
    wire                    o_tx;  
    reg                    rd_uart;  
    reg                    o_tx_done;
    wire    [NB_DATA-1:0]   o_rx_uart;
    wire                    tx_full;
    reg                    rx;
    reg                    rx_done_tick;
    reg                    rx_data_out;
   
     uart
    #(
        .NB_CODE        (NB_CODE),
        .DBIT            (8),
        .DVSR              (163),
        .DVSR_BIT         (8),
        .FIFO_W           (2),
        .SB_TICK        (SB_TICK),
        .NB_DATA        (NB_DATA),
        .NB_STATE       (NB_STATE)
    )
    u_uart
    (
        .clk          (i_clk),
        .reset        (i_reset),
        .rd_uart       (rd_uart),
        .tx            (o_tx),
        .tx_full        (tx_full),  //no estoy seguro de que es
        //.rx_empty        (rx_empty), lo deje como interno
        .rx              (rx)
    );
    

    
    initial begin
        i_clk = 1'b0;
        i_reset = 1'b1; //para reiniciar reg
        rx=1'b0;
        #10
        i_reset = 1'b0;
        rd_uart=1'b0;
        //ENVIO EL PRIMER DATO        
        #10
        rd_uart=1'b1;
        //interface_data_in = I_DATA_A;
        rx=1'b1;
        #10
        
        #20
        rd_uart=1'b0; 
        #20
        rd_uart=1'b1;
  
        $display("********** Test TERMINADO **********");
        $finish();
    end
    
         
   always #10 i_clk = ~i_clk;

endmodule