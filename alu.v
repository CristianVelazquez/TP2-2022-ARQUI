`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.09.2020 21:17:11
// Design Name: 
// Module Name: alu
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


module alu 
#(
    parameter NB_CODE = 6,
    parameter NB_DATA = 8,
    parameter NB_DATA_OUT = 9
)

(   
    // INPUTS
    input wire      [NB_DATA-1:0]      i_a,
    input wire      [NB_DATA-1:0]      i_b,
    input wire      [NB_CODE-1:0]      i_op,
    
    // OUTPUTS
    output wire     [NB_DATA_OUT-1:0]  o_r
);
    
    // LOCAL_PARAMETERS
    localparam  ADD = 6'b100000;
    localparam  SUB = 6'b100010;
    localparam  AND = 6'b100100;
    localparam  OR  = 6'b100101;
    localparam  XOR = 6'b100110;
    localparam  SRA = 6'b000011;
    localparam  SRL = 6'b000010;
    localparam  NOR = 6'b100111;
    
    // INTERNAL 
    reg             [NB_DATA_OUT-1:0]  o_res;
    
    assign o_r = o_res;
    
    always @(*)
        begin
            case(i_op)
                // ADD
                ADD:
                o_res = i_a + i_b;
                // SUB
                SUB:
                o_res = i_a - i_b;
                // AND
                AND:
                o_res = i_a & i_b;
                // OR
                OR:
                o_res = i_a | i_b;
                // XOR
                XOR:
                o_res = i_a ^ i_b;
                // SRA
                SRA:
                o_res = i_a >>> i_b;
                // SRL
                SRL:
                o_res = i_a >> i_b;
                // NOR
                NOR:
                o_res = ~(i_a | i_b);  
                //DEFAULT
                default:
                o_res = {NB_DATA_OUT{1'b0}};
            endcase
        end			
endmodule
