`timescale 1ns / 1ps

module alu 
#(
    parameter NB_OP = 6,  
    parameter NB_DATA = 8,
    parameter NB_DATA_OUT = 9
)

(   
    input wire      [NB_DATA-1:0]      i_data_a,
    input wire      [NB_DATA-1:0]      i_data_b,
    input wire      [NB_OP-1:0]        i_code,
    output wire     [NB_DATA_OUT-1:0]  o_led,
    output wire     [NB_DATA_OUT-1:0]  o_data_debug
);
    
    localparam  ADD = 6'b100000;
    localparam  SUB = 6'b100010;
    localparam  AND = 6'b100100;
    localparam  OR  = 6'b100101;
    localparam  XOR = 6'b100110;
    localparam  SRA = 6'b000011;
    localparam  SRL = 6'b000010;
    localparam  NOR = 6'b100111;
    
    //auxiliar salida
    reg             [NB_DATA_OUT-1:0]  o_result;
    
    assign o_led = o_result;/////////////////////////////////////////////////////////////
    o_data_debug = o_result;/////////////////////////////////////////////////////////////


    //Se simplifico el always a solo operaciones
    always @(*)
        begin
            case(i_code)
                ADD:
                o_result = i_data_a + i_data_b;
                SUB:
                o_result = i_data_a - i_data_b;
                AND:
                o_result = i_data_a & i_data_b;
                OR:
                o_result = i_data_a | i_data_b;
                XOR:
                o_result = i_data_a ^ i_data_b;
                SRA:
                o_result = i_data_a >>> i_data_b;
                SRL:
                o_result = i_data_a >> i_data_b;
                NOR:
                o_result = ~(i_data_a | i_data_b);  
                default:
                o_result = {NB_DATA_OUT{1'b0}};
            endcase
        end			
endmodule