`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:14:29 11/10/2023 
// Design Name: 
// Module Name:    D 
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

module D(
    input [31:0] instr,
    input [31:0] PC,
	input clk,
    input reset,
    input flush,
    output reg [31:0] instr_D,
    output reg [31:0] PC_D,
    output [15:0] imm16_D,
    output [4:0] regRA1_D,
    output [4:0] regRA2_D,
    output [4:0] regWA_D,
    output regWE_E,
    output [2:0] npcMode,
    output cmpMode,
    output [1:0] extMode
    );

    `define NOP 32'h00000000

    always @(posedge clk) begin
        if (reset)  begin
            instr_D <= `NOP;
        end

        else if (!flush)  begin
            instr_D <= instr;
            PC_D <= PC;
        end
    end


    Controller cu (
		  .instr(instr_D),
        .regRA1(regRA1_D),
        .regRA2(regRA2_D),
        .regWA(regWA_D),
        .regWE(regWE_D),
        .npcMode(npcMode),
        .cmpMode(cmpMode),
        .extMode(extMode),
        .imm16(imm16_D)
    );

    


endmodule
