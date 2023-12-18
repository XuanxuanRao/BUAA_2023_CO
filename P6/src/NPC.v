`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:36:50 11/12/2023 
// Design Name: 
// Module Name:    NPC 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

`include "param.v"

module NPC(
    input [31:0] PC_F,
    input [31:0] PC_D,
    input [2:0] mode,
    input cmpRes,
    input [25:0] imm26_D,
    input [31:0] regRD1_D,
    output reg [31:0] PC_next
    );

    always @(*) begin
        case (mode)
            `NPCNEXT:    PC_next = PC_F + 4;
            `NPCBRANCH:  begin
                if (cmpRes)
                    PC_next = PC_D + 4 + {{14{imm26_D[15]}}, imm26_D[15:0], 2'b00};
                else
                    PC_next = PC_F + 4;
            end 
            `NPCJTYPE:   
                PC_next = {PC_D[31:28], imm26_D, 2'b00};
            `NPCJREG:
                PC_next = regRD1_D;
            default: 
                PC_next = PC_F + 4;
        endcase
    end


endmodule
