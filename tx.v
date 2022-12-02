`timescale 1ns / 1ps

module tx
#( 
    parameter                  NB_DATA     = 8,       // Numero de bits del dato
    parameter                  SB_TICK     = 16       // Ticks for stop bits  
)
(
    // INPUTS         
    input wire                  i_tick,
    input wire                  i_clk,
    input wire                  i_reset,
    input wire                  i_tx_start,                
    input wire [NB_DATA-1:0]    i_data,
    
    // OUTPUTS
    output reg 	                o_tx_done_tick,
    output wire                 o_tx
);

    // LOCAL_PARAMETERS
    localparam                  IDLE        = 4'b0001;
    localparam                  START    	= 4'b0010;
    localparam                  DATA        = 4'b0100;
    localparam                  STOP        = 4'b1000;
    
    reg            [3:0]       state_reg, state_next;
    reg            [3:0]       s_reg, s_next;         // Contador s: TickCounter (del BRGenerator)
    reg            [3:0]       n_reg, n_next;         // Contador n: mantiene la cuenta de los bits recibidos
    reg        [NB_DATA-1:0]   b_reg, b_next;         // Buffer de datos a transmitir
    reg                        tx_reg, tx_next;
    
    // MEMORY
    always @(posedge i_clk, posedge i_reset) begin
        if (i_reset)  begin  
            state_reg     <= IDLE;  
            s_reg         <= 0;  
            n_reg         <= 0;  
            b_reg         <= 0;  
        end 
        else begin  
            state_reg     <= state_next;
            s_reg         <= s_next;  
            n_reg         <= n_next;  
            b_reg         <= b_next; 
            tx_reg        <= tx_next;   
        end 
    end
    
    always @(*) begin    
        state_next = state_reg;
        o_tx_done_tick = 1'b0;                          // Reseteo el flag DONE (valid).
        s_next = s_reg;
        n_next = n_reg;
        b_next = b_reg;
        tx_next = tx_reg;

     
        case(state_reg)
            IDLE: begin                                 // IDLE_STATE:
                tx_next = 1'b1;                         // Seteo tx_next=1 ya que no se envia nada
                if(i_tx_start) begin                    // Comienza a transmitir bit a bit cuando la se?al de    ->
                    state_next = START;                 // entrada i_tx_start = 1 y paso al estado START.
                    s_next = 4'b0000;                   // Reinicio TickCounter.
                    b_next = i_data;                    // Asigno el dato de entrada i_data a transmitir al buff ->
                end                                     // buffer de datos a transmitir
            end
                    
            START: begin                                // START_STATE:
                tx_next = 1'b0;                         // Seteo tx_next=0 para enviar el bit de START.
                if(i_tick)                              // Entro cada vez que llega un tick del BRGenerator.
                    if(s_reg == (SB_TICK-1)) begin      // Si es igual a 15 la se?al indica que se calibro.
                        s_next = 4'b0000;               // Reinicio TickCounter.
                        n_next = 3'b000;                // Reinicio el contador de bits transmititdos.
                        state_next = DATA;              // Paso al estado DATA para comenzar a enviar bits
                    end
                    else                                // En caso de que TickCounter no haya llegado a '15'      ->
                        s_next = s_reg + 1;             // lo incremento. (Para calibrarlo)
            end     
                     
            DATA: begin                                 // DATA_STATE:
                tx_next = b_reg[0];                     // Seteo tx_next=LSB para enviar el bit bajo (D0 primero)
                if(i_tick)                              // Entro cada vez que llega un tick del BRGenerator.
                    if(s_reg == (SB_TICK-1)) begin      // Si es igual a 15 la se?al indica que se calibro.
                        s_next = 4'b0000;               // Reinicio TickCounter.
                        b_next = b_reg >> 1;            // Desplazo b_reg a la derecha y lo asigno a b_next.
                        if(n_reg == (NB_DATA-1))        // Si es igual a 7 es porque ya envie todos los bits de ->
                                state_next = STOP;      // datos, por lo que paso al estado de STOP.
                        else                            // En caso que no haya llegado, incremento el contador de->
                                n_next = n_reg + 1;     // bits recibidos.
                    end
                    else                                // En caso de que TickCounter no haya llegado a '15'     ->
                    s_next = s_reg + 1;                 // lo incremento. (Se deben enviar datos cada 15 ticks).
            end
                            
            STOP: begin                                 // STOP_STATE:
                tx_next = 1'b1;                         // Seteo tx_next=1 para enviar el bit de STOP.
                if(i_tick)                              // Entro cada vez que llega un tick del BRGenerator.
                    if(s_reg == (SB_TICK-1)) begin      // Si es igual a 15 la se?al indica que se calibro.
                        o_tx_done_tick = 1'b1;          // Pongo el alto el flag DONE.
                        state_next = IDLE;              // Paso al estado de IDLE.
                    end
                    else                                // En caso de que TickCounter no haya llegado a '15'     ->
                        s_next = s_reg + 1;             // lo incremento. (Se deben enviar datos cada 15 ticks).
                end  
            default : begin                             // DEFAULT: Fault Recovery
                state_next = IDLE;                      // Vuelvo al estado IDLE.
                s_next     = 1'b0;                      // Reinicio TickCounter.
                n_next     = 1'b0;                      // Reinicio contador de bits recibidos.
                b_next     = 1'b0;                      // Reinicio buffer de datos recibidos.
                tx_next    = 1'b1;                      // Pongo en alto la salida para no enviar bit de START.
            end                                         
        endcase
    end
    
    // OUTPUT    
    assign o_tx = tx_reg ;                              // Asigno el bit a transmitir a la salida del transmisor.
        
endmodule