`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2020 07:18:57 PM
// Design Name: 
// Module Name: interfaz
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module interfaz
#(
    parameter   NB_DATA = 8,                                      // # data bits
    parameter   NB_CODE = 6,                                      // Bits de codigo
    parameter   NB_STATE = 4        
)
(
    //INPUTS
    input   wire                i_clk,                             // Clock
                                i_reset,                           // Bit de reset 
                                i_rx_done,                         // Bit que indica que el receptor tiene listo el dato. 
                 [NB_DATA-1:0]  i_data,                            // Dato del receptor.
     
    //OUTPUTS
    output  reg                o_data_ready,                      // Bit para indicar que el calculo se realizo correctamente
            wire[NB_DATA-1:0]  o_data                             // Dato luego de realizar el calculo.
                                
);
    //LOCAL PARAMETERS
    localparam                  SAVE_A 		    = 4'b0001;         // Estado donde se guarda el primer operando
    localparam                  SAVE_B 		    = 4'b0010;         // Estado donde se guarda el segundo operando
    localparam                  SAVE_OP         = 4'b0100;         // Estado donde se guarda la operacion
    localparam                  MAKE_RESULT 	= 4'b1000;         //Estado donde se calcula y obtiene el resultado
    
    //INTERNAL
    reg        [NB_DATA-1:0]      data_A, next_data_A;            // Primer operando de la ALU
    reg        [NB_DATA-1:0]      data_B, next_data_B;            // Segundo operando de la ALU 
    reg        [NB_CODE-1:0]      operation, next_operation;      // Operacion para la ALU 
    reg        [NB_STATE-1:0]     state = SAVE_A;                 // Estado. Inicia en guardar el operando A 
    reg        [NB_STATE-1:0]     next_state = SAVE_B;            // Siguiente estado. Inicia en guardar el operando B. 

    //Maquina de estados
always @(posedge i_clk, posedge i_reset) begin
	if(i_reset) begin                                              // En el reset vuelvo al primer estado e inicializo los registros.   
        data_A          <= 8'b00000000;
        data_B          <= 8'b00000000;
        operation       <= 5'b00000;
        state           <= SAVE_A;
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
		SAVE_A:                                                       //En el primer estado guardamos el primer operando y pasamos al siguiente estado.
            if(i_rx_done) begin              
                next_data_A= i_data;
                next_state = SAVE_B;
            end
		SAVE_B:	                                                      //En el segundo estado 
            if(i_rx_done) begin    
                next_data_B= i_data;
                next_state = SAVE_OP;
            end	
		SAVE_OP: 
			if(i_rx_done) begin    
                next_operation  = i_data;
                next_state      = MAKE_RESULT;
            end
		MAKE_RESULT:	 
            if(~i_rx_done) begin 
                o_data_ready    = 1'b1;
                next_state      = SAVE_A;		
            end
		default: begin
            next_state      = SAVE_A;
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
    alu_1 
    (	
        .i_a(data_A), 
        .i_b(data_B),
        .i_op(operation),
        .o_r(o_data)
    );

endmodule
