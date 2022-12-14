`timescale 1ns / 1ps

module tb_uart();

    localparam NB_DATA                = 8;
    localparam SB_TICK                = 16;
    localparam NB_STATE               = 2;
    localparam resultado_esperado     = 8'b11100101;        
    
    reg                     clk;
    reg                     test_start;
    reg                     reset;

    reg     [NB_DATA-1:0]   i_tx;
    reg                     i_tx_start;
    wire                    o_tx;
    wire                    o_tx_done;
    wire                    o_rx_done;
    wire    [NB_DATA-1:0]   o_rx;
    
    initial begin
        clk = 1'b0;
        reset = 1'b1;
        test_start = 1'b0;
        i_tx_start = 1'b0;
        
        
        #10
        reset = 1'b0;
                
        #10
        test_start = 1'b1;
        i_tx_start = 1'b1;  
        i_tx = resultado_esperado;
        
        #20
        i_tx_start = 1'b0; 
        
        #1041670
        
        $display("********** Test TERMINADO **********");
        $finish();
    end
    
    uart
    #(
        .NB_DATA          (NB_DATA),
        .SB_TICK          (SB_TICK),
        .NB_STATE         (NB_STATE)
    )
    u_uart
    (
        .i_clk            (clk),
        .i_reset          (reset), 
        .i_rx             (o_tx), 
        .i_tx_start       (i_tx_start),
        .i_tx             (i_tx),
        .o_tx             (o_tx),
        .o_tx_done_tick   (o_tx_done),
        .o_rx_done_tick   (o_rx_done),
        .o_rx             (o_rx)
    );
        
    always #10 clk = ~clk;
    
    always @(posedge clk) begin       
        if (o_rx_done) begin            
             if (resultado_esperado != o_rx) begin
                 $display("********** Test FALLO **********");
                 $finish();
             end
             else begin
                  $display("********** Test CORRECTO, resultado = %b **********",o_rx);
                  $finish();
             end
        end
    end
endmodule