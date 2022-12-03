`timescale 1ns / 1ps

module tx
#( 
    parameter                  NB_DATA     = 8,        // # data bits
    parameter                  SB_TICK     = 16,       // # ticks for stop bits
    parameter                  NB_STATE    = 2   
)
(       
    input wire                  i_clk,
    input wire                  i_reset,
    input wire                  i_tick,               //Ticks de entrada del baudGen
    input wire                  i_tx_start,           //Habilita el comienzo de transmision     
    input wire [NB_DATA-1:0]    i_data,               
    
    output reg 	                o_tx_done_tick,
    output wire                 o_tx
);

    localparam                  IDLE        = 2'b00;
    localparam                  START    	= 2'b01;
    localparam                  DATA        = 2'b10;
    localparam                  STOP        = 2'b11;
     // signal declaration
    reg        [NB_STATE-1:0]   state_reg, state_next;
    reg        [3:0]            s_reg, s_next;         // Contador de ticks del baudGen
    reg        [3:0]            n_reg, n_next;         // Contador de bits transmitidos
    reg        [NB_DATA-1:0]    b_reg, b_next;         // Buffer de datos a transmitir
    reg                         tx_reg, tx_next;
    //reg                         o_tx_done_tick_reg, o_tx_done_tick_next;
    
    // MEMORIA
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
        o_tx_done_tick = 1'b0;                          // Reseteo el flag DONE
        s_next = s_reg;
        n_next = n_reg;
        b_next = b_reg;
        tx_next = tx_reg;
  
        case(state_reg)
            IDLE: begin                                 //## IDLE:
                tx_next = 1'b1;                         //tx_next=1 Porque no envio nada
                if(i_tx_start) begin                   
                    state_next = START;                 // i_tx_start = 1, comienzo a enviar y paso al estado START
                    s_next =0;                          // Reinicio TickCounter
                    b_next = i_data;                    // Asigno el dato a transmitir al buff de datos a enviar##
                end                                     
            end                    
            START: begin                                // START:
                tx_next = 1'b0;                         // tx_next=0 para enviar el bit de START.
                if(i_tick)                              
                    if(s_reg == (SB_TICK-1)) begin      // Para calibrar la signal debe ser igual a 15
                        s_next = 0;                     // Reinicio TickCounter.
                        n_next = 3'b000;                // Reinicio el contador de bits transmititdos
                        state_next = DATA;              //Cuando es 15 paso al estado DATA para enviar
                    end
                    else                                //Si no es 15 sigo incrementando para que se calibre
                        s_next = s_reg + 1;             
            end                          
            DATA: begin                                 // DATA:
                tx_next = b_reg[0];                     // tx_next=LSB envio el bit menos significativo
                if(i_tick)                              
                    if(s_reg == (SB_TICK-1)) begin      // Para calibrar la signal debe ser igual a 15
                        s_next = 0;                     // Reinicio TickCounter
                        b_next = b_reg >> 1;            // Desplazo b_reg a la derecha y lo asigno a b_next
                        if(n_reg == (NB_DATA-1))        // Si es igual a 7 se enviaron todos los bits de datps
                                state_next = STOP;      // Paso al estado STOP
                        else                            
                                n_next = n_reg + 1;     // Si no enviaron todos incremento el reg de bit enviados
                    end
                    else                                
                    s_next = s_reg + 1;                 // cuando no es 15 sigo incrementado, se envian cada 15 ticks
            end                            
            STOP: begin                                 // STOP:
                tx_next = 1'b1;                         // tx_next=1 para enviar el bit de STOP.
                if(i_tick)                              
                    if(s_reg == (SB_TICK-1)) begin      // Para calibrar la signal debe ser igual a 15
                        o_tx_done_tick = 1'b1;          // bit que indica que termino
                        state_next = IDLE;              // Paso al estado de IDLE.
                    end
                    else                                
                        s_next = s_reg + 1;             
                end  
            default : begin                             // DEFAULT:
                state_next = IDLE;                      // reinicio los registros
                s_next     = 1'b0;                      
                n_next     = 1'b0;                      
                b_next     = 1'b0;                     
                tx_next    = 1'b1;                      
            end                                         
        endcase
    end
    
    // OUTPUT    
    assign o_tx = tx_reg ;                              //Salida del transmisor
 //assign o_tx_done_tick = o_tx_done_tick_reg;   
endmodule