`timescale 1ns / 1ps
`include "param.v"

module D(
    input [31:0] instr_F,
    input [31:0] PC_F,
	input clk,
    input reset,
    input flush,
    input BD_F,
    input Req,
    input [4:0] ExcCode_F,
    output reg [31:0] instr_D,
    output reg [31:0] PC_D,
    output [15:0] imm16_D,
    output [4:0] regRA1_D,
    output [4:0] regRA2_D,
    output [4:0] regWA_D,
    output regWE_E,
    output reg BD_D,
    output reg [4:0] Raw_ExcCode_D,
    output [2:0] npcMode,
    output [1:0] cmpMode,
    output instr_D_muldiv,
    output RI_D,
    output ERET_D,
    output [1:0] extMode
    );

    `define NOP 32'h00000000

    assign ERET_D = instr_D[31:26]==6'b010000 && instr_D[5:0]==6'b011000;

    always @(posedge clk) begin
        if (reset || Req)  begin
            instr_D <= `NOP;
            PC_D <= reset ? 32'd0 : Req ? `HANDLER : 32'd0;
            BD_D <= 0;
            Raw_ExcCode_D <= `NONE;
        end

        else if (!flush)  begin
            instr_D <= instr_F;
            PC_D <= PC_F;
            BD_D <= BD_F;
            Raw_ExcCode_D <= ExcCode_F; 
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
        .muldiv(instr_D_muldiv),
        .imm16(imm16_D),
        .RI(RI_D)
    );


endmodule
