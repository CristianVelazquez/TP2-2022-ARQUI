`timescale 1ns / 1ps


module rx
#( 
    parameter                  NB_DATA     = 8,       // # data bits
    parameter                  SB_TICK     = 16,       // # ticks for stop bits
    parameter                  NB_STATE    = 2  
)
(
    input wire                  i_clk,
    input wire                  i_reset,
    input wire                  i_rx,
    input wire                  i_tick,                
    
    output reg 	                o_rx_done_tick,
    output wire [NB_DATA-1:0]   o_data
);

    localparam                  IDLE        = 2'b00;
    localparam                  START    	= 2'b01;
    localparam                  DATA        = 2'b10;
    localparam                  STOP        = 2'b11;
    
    reg         [NB_STATE-1:0]  state_reg   = IDLE;
    reg         [NB_STATE-1:0]  state_next  = START;
    reg         [3:0]           s_reg, s_next;         // Contador de ticks del baudGen
    reg         [3:0]           n_reg, n_next;         // Contador de bits transmitidos
    reg         [NB_DATA:0]     b_reg, b_next;         // Buffer de datos a transmitir

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
        end 
    end

    always @(*) begin    
        state_next = state_reg;
        o_rx_done_tick = 1'b0;                          // Reseteo el flag DONE
        s_next = s_reg;
        n_next = n_reg;
        b_next = b_reg;
    
        case(state_reg)
            IDLE:                                       
                if(i_rx == 1'b0) begin                  // si se cumple paso al estado START
                    state_next = START;                 
                    s_next = 0;                         // Reinicio TickCounter
                end
            START:                                     
                if(i_tick == 1)                         
                    if(s_reg == (NB_DATA-1)) begin      // Solo cuando sea igual a 7 paso al siguiente estado (MEDIO)
                        state_next = DATA;              
                        s_next = 4'b0000;               // Reinicio TickCounter
                        n_next = 4'b000;                // Reinicio el contador de bits recv
                    end    
                    else                                // Si no es 7 incremento, debo llegar a 7, mitad de la signal 
                        s_next = s_reg + 1;                                   
            DATA:                                      
                if(i_tick == 1)                        
                    if(s_reg == (SB_TICK-1)) begin      // solo si es igual a 15, recibo cada 15
                        s_next = 4'b0000;               // Reinicio TickCounter
                        b_next = {i_rx, b_reg[NB_DATA-1 : 1]}; // guardo el dato de entrada en un shift-reg. 
                        if(n_reg == (NB_DATA-1))        //Cuando llego a 7, recibi todos los datos
                            state_next = STOP;          // debo terminar
                        else                            
                            n_next = n_reg + 1;         // Incremento si no es 7
                        end
                    else                                
                        s_next = s_reg + 1;             // si no es 15 incremento
            STOP:                                       
                if(i_tick == 1)                         
                    if(s_reg == (SB_TICK-1)) begin      // Si es 15 voy al estado IDLE
                        state_next = IDLE;             
                        o_rx_done_tick = 1'b1;          // Indico que termine de recibir
                    end
                    else                                
                        s_next = s_reg + 1;             // Si no es 15 sigo incrementando
                        
            default : begin                             
                state_next = IDLE;                          //Reinicio los registros
                s_next=0;                               
                n_next=0;                              
                b_next=0;                              
            end                 
        endcase
    end
    
    // OUTPUT
    assign o_data = b_reg;                              //Asigno el reg a salida de la data

endmodule
