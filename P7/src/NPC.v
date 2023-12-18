`timescale 1ns / 1ps
`include "param.v"

module NPC(
    input [31:0] PC_F,
    input [31:0] PC_D,
    input [2:0] mode,
    input cmpRes,
    input Req,
    input [25:0] imm26_D,
    input [31:0] regRD1_D,
    input [31:0] EPC_M,
    output reg [31:0] PC_next
    );


    always @(*)     begin
        if (Req)    PC_next = `HANDLER;
        else    begin
            case (mode)
                `NPCEPC:    PC_next = EPC_M + 4;
                `NPCNEXT:   PC_next = PC_F + 4;
                `NPCBRANCH: PC_next = cmpRes ? (PC_D + 4 + {{14{imm26_D[15]}}, imm26_D[15:0], 2'b00}) : (PC_F + 4);
                `NPCJTYPE:  PC_next = {PC_D[31:28], imm26_D, 2'b00};
                `NPCJREG:   PC_next = regRD1_D;
                default:    PC_next = PC_F + 4;
            endcase
        end
    end

endmodule
