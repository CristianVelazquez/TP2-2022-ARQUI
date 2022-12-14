`timescale 1ns / 1ps

module tb_tx();
    
    localparam BAUD_RATE = 9600;
    localparam CLK_FREC = 50000000;
 
    localparam NB_DATA  = 8;
    localparam SB_TICK  = 16;
    localparam resultado_esperado     = 8'b11100101;        
    
    reg                                 clk;
    reg                                 test_start;
    reg                                 reset;
    wire                                tick;
    reg                                 tx_start;
    wire                                done_tick;
    reg [NB_DATA-1:0]                   data;
    reg [NB_DATA-1:0]                   aux;
    reg [NB_DATA/2-1:0]                 counter;
    wire                                tx;
    
       baudRateGenerator
    #(
        .BAUD_RATE (BAUD_RATE),
        .CLK_FREC (CLK_FREC)
    )
    u_baudRateGenerator
    (
        .i_clk        (clk),
        .i_reset      (reset),
        .o_tick       (tick)
    );

    tx
    #(
        .NB_DATA      (NB_DATA),
        .SB_TICK      (SB_TICK)
    )
    u_tx
    (
        .i_clk        (clk),
        .i_reset      (reset),
        .i_tick       (tick),
        .i_tx_start   (tx_start),
        .i_data       (data),
        .o_tx_done_tick(done_tick),
        .o_tx         (tx)
    );
    
    initial begin
        clk = 1'b0;
        reset = 1'b1;
        test_start = 1'b0;
        tx_start = 1'b0;
        aux = 0;
        
        
        #10
        reset = 1'b0;
        //HABILITO para enviar        
        #10
        test_start = 1'b1;
        tx_start = 1'b1;  
        counter = 0;   
        data = resultado_esperado;
        
        #20
        tx_start = 1'b0; 
        
        #1041670
        
        $display("********** Test TERMINADO **********");
        $finish();
    end
   
    
    always #10 clk = ~clk;

    always @(posedge clk) begin 
        if (tick) begin
            counter = counter + 1;
        end
        if (counter == 0 && tick) begin //Concateno los bits transmitidos
            aux <= {tx, aux[7:1]};
        end
        
        if (done_tick) begin            
             if (resultado_esperado != aux) begin
                 $display("********** Test FALLO **********");
                 $finish();
             end
             else begin 
                 $display("**********Test CORRECTO, resultado = %b **********",aux);
                 $finish();
             end
        end
    end
  
endmodule
