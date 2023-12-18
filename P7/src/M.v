`timescale 1ns / 1ps
`include "param.v"

module M(
    input clk,
    input reset,
    input Req,
    input BD_E,
    input [4:0] ExcCode_E,
    input [31:0] instr_E,
    input [31:0] PC_E,
    input [31:0] F_regA1Data_E,
    input [31:0] F_regA2Data_E,
    input [31:0] aluRes_E,
	input [31:0] extRes_E,
    input [31:0] muldivRes_E,
    output reg BD_M,
    output reg [31:0] instr_M,
    output reg [31:0] PC_M,
    output memWE_M,
    output [1:0] memMode,
    output [4:0] regRA1_M,
    output [4:0] regRA2_M,
    output [4:0] regWA_M,
    output regWE_M,
    output reg [31:0] regRD1_M,
    output reg [31:0] regRD2_M,
    output reg [4:0] Raw_ExcCode_M,
    output reg [2:0] Tnew_M,
	output reg [31:0] extRes_M,
    output reg [31:0] aluRes_M,
    output reg [31:0] muldivRes_M,
    output ERET_M,
    output CP0WE_M,
    output [2:0] MUX_regWD_M
    );

    `define R 6'b000000
    `define NOP 32'h00000000

    wire [5:0] funct = instr_M[5:0];

    assign ERET_M = instr_M[31:26] == 6'b010000 && instr_M[5:0] == 6'b011000;
    assign CP0WE_M = instr_M[31:26]==`CP0 && instr_M[25:21]==`MTCP0;

    always @(*) begin
        case (instr_M[31:26])
            `R:     begin
                if (funct == `ADD || funct == `SUB || funct == `OR || funct == `AND || funct == `SLT || funct == `SLTU)
                    Tnew_M = 3'd0;
                else if (funct == `MFHI || funct == `MFLO)  Tnew_M = 3'd0;
                else if (instr_M[5:0] == `JR)               Tnew_M = 3'd0;
                else if (instr_M[5:0] == `SYSCALL)          Tnew_M = 3'd0;
                else                                        Tnew_M = 3'd0;  
            end
            `CP0:   begin
                if (instr_M[25:21] == `MTCP0)       Tnew_M = 3'd0;
                else if (instr_M[25:21] == `MFCP0)  Tnew_M = 3'd1;
                else if (instr_M[5:0] == 6'b011000) Tnew_M = 3'd0;
                else                                Tnew_M = 3'd0;
            end
            `ORI, `ANDI, `ADDI: Tnew_M = 3'd0;
            `LUI:               Tnew_M = 3'd0;
            `SW, `SH, `SB:      Tnew_M = 3'd0;
            `LW, `LH, `LB:      Tnew_M = 3'd1;
            `BEQ, `BNE:         Tnew_M = 3'd0;
            `JAL:               Tnew_M = 3'd0;
            default:            Tnew_M = 3'd0;
        endcase     
    end


    always @(posedge clk) begin
        if (reset || Req)  begin
            instr_M <= `NOP;
            PC_M <= reset ? 32'd0 : Req ? `HANDLER : 32'd0;
            BD_M <= 0;
            Raw_ExcCode_M <= `NONE;
        end

        else        begin
            instr_M <= instr_E;
            PC_M    <= PC_E;
            regRD1_M <= F_regA1Data_E;
            regRD2_M <= F_regA2Data_E;
            aluRes_M <= aluRes_E;
			extRes_M <= extRes_E;
            muldivRes_M <= muldivRes_E;
            BD_M <= BD_E;
            Raw_ExcCode_M <= ExcCode_E;
        end
    end


    Controller cu (
		.instr(instr_M),
        .regRA1(regRA1_M),
        .regRA2(regRA2_M),
        .regWA(regWA_M),
        .regWE(regWE_M),
        .memWE(memWE_M),
		.memMode(memMode),
        .MUX_regWD(MUX_regWD_M)
    );


endmodule
