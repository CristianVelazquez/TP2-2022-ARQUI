`timescale 1ns / 1ps

module interfaz
#(
    parameter   NB_DATA = 8,                                      
    parameter   NB_CODE = 6,                                      
    parameter   NB_STATE = 2        
)
(
    input   wire                i_clk,                            
    input   wire                i_reset,                           
    input   wire                i_rx_done,                        
    input   wire [NB_DATA-1:0]  i_data,                           
    output  wire [NB_DATA-1:0]  o_data,         
    output  reg                 o_data_ready,
    output  wire [NB_DATA-1:0]  o_data_debug
);
    //En ellas puedo salvar el dato de A,B, OPERACIONES y el resultado obtenido
    localparam                  STATE_A 		    = 2'b00;        
    localparam                  STATE_B 		    = 2'b01;         
    localparam                  STATE_OP            = 2'b10;         
    localparam                  RESULT 	            = 2'b11;     
    
    reg        [NB_DATA-1:0]      data_A, next_data_A;           
    reg        [NB_DATA-1:0]      data_B, next_data_B;            
    reg        [NB_CODE-1:0]      operation, next_operation;     
    reg        [NB_STATE-1:0]     state = STATE_A;                 
    reg        [NB_STATE-1:0]     next_state = STATE_B;            

always @(posedge i_clk, posedge i_reset) begin
	if(i_reset) begin                                     //Se inicializan los datos  
        data_A          <= 8'b00000000;                   
        data_B          <= 8'b00000000;
        operation       <= 5'b00000;
        state           <= STATE_A;
    end
	else begin
        data_A    <= next_data_A;
        data_B    <= next_data_B;
        operation <= next_operation;
        state     <= next_state; 
    end
end

always @(*) begin
	next_data_A    = data_A;
	next_data_B    = data_B;
	next_operation = operation;
	next_state     = state;
	
	o_data_ready   = 1'b0;
	
	case (state)
		STATE_A:                                                      //El primer dato se guarda en STATE_A   
            if(i_rx_done) begin                                       //El segundo en STATE_B y el ultimo en STATE_OP
                next_data_A= i_data;
                next_state = STATE_B;
            end
		STATE_B:	                                                       
            if(i_rx_done) begin    
                next_data_B= i_data;
                next_state = STATE_OP;
            end	
		STATE_OP: 
			if(i_rx_done) begin    
                next_operation  = i_data;
                next_state      = RESULT;
            end
		RESULT:	 
            if(~i_rx_done) begin 
                o_data_ready    = 1'b1;
                next_state      = STATE_A;		
            end
		default: begin                 //Caso en el que no haya un estado conocido
            next_state      = STATE_A;
            next_data_A     = 8'b00000000;
            next_data_B     = 8'b00000000;
            next_operation  = 5'b00000;
        end
	endcase
end

alu 
    #(
        .NB_DATA    (NB_DATA),
        .NB_DATA_OUT(NB_DATA)
    )
    u_alu
    (	
        .i_data_a(data_A),
        .i_data_b(data_B),
        .i_code(operation),
        .o_led(o_data),
        .o_data_debug(o_data_debug)
    );

endmodule

