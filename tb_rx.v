`timescale 1ns / 1ps

module tb_rx();
    
    localparam BAUD_RATE = 9600;
    localparam CLK_FREC = 50000000;
    localparam NB_DATA  = 8;
    localparam SB_TICK  = 16;
    localparam resultado_esperado   = 8'b11100101;        
    
    reg                                 clk;
    reg                                 test_start;
    reg                                 reset;
    wire                                tick;

    reg                                 rx;
    wire                                done_tick;
    wire [NB_DATA-1:0]                  data;
    
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
    rx
    #(
        .NB_DATA      (NB_DATA),
        .SB_TICK      (SB_TICK)
    )
    u_rx
    (
        .i_clk        (clk),
        .i_reset      (reset),
        .i_tick       (tick),
        .i_rx         (rx),
        .o_rx_done_tick(done_tick),
        .o_data       (data)
    );
    
    initial begin
        clk = 1'b0;
        reset = 1'b1;
        test_start = 1'b0;
        rx = 1'b1;      
       
        #10
        reset = 1'b0;
        test_start = 1'b1;
        rx = 1'b0;                      
        //Mando primero el menos significativo 
        #104160
        rx = 1'b1;                     
        
        #104160
        rx = 1'b0;                      
        
        #104160
        rx = 1'b1;                     
        
        #104160
        rx = 1'b0;                     
        
        #104160
        rx = 1'b0;                      
        
        #104160
        rx = 1'b1;                      
        
        #104160
        rx = 1'b1;                      
        
        #104160
        rx = 1'b1;                      // D7 MSB
        
        #104160
        rx = 1'b1;                      // Bit de Stop
                
        #104160        
        
        $display("********** Test TERMINADO **********");
        $finish();
    end
    
    
    always #10 clk = ~clk;
    
    always @(posedge clk) begin
        if ((done_tick) && (resultado_esperado != data)) begin
            $display("********** Test FALLO, resultado = %b **********",data);
            $finish();
        end
        if ((done_tick) && (resultado_esperado == data)) begin
            $display("**********Test CORRECTO, resultado = %b **********",data);
            $finish();
        end
    end
  
endmodule