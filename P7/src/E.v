`timescale 1ns / 1ps
`include "param.v"

module E(
    input clk,
    input reset,
    input flush,
    input Req,
    input BD_D,
    input [31:0] instr_D,
	input [31:0] PC_D,
    input [31:0] F_regA1Data_D,
    input [31:0] F_regA2Data_D, 
    input [31:0] extRes_D,
    input [4:0] ExcCode_D,
    output [4:0] regRA1_E,
    output [4:0] regRA2_E,
    output [4:0] regWA_E,
    output regWE_E,
    output reg [31:0] regRD1_E,
    output reg [31:0] regRD2_E,
    output reg [31:0] extRes_E,
    output [2:0] aluMode,
    output reg [4:0] Raw_ExcCode_E,
    output [1:0] MUX_aluSrc,
    output reg BD_E,
    output reg [2:0] Tnew_E,
    output reg [31:0] instr_E,
    output reg [31:0] PC_E
    );
	 
    `define NOP 32'h00000000

    wire [5:0] funct = instr_E[5:0];

    always @(*) begin
        case (instr_E[31:26])
            `R:     begin
                if (funct == `ADD || funct == `SUB || funct == `OR || funct == `AND || funct == `SLT || funct == `SLTU)
                    Tnew_E = 3'd1;
                else if (funct == `MFHI || funct == `MFLO)  Tnew_E = 3'd1;
                else if (instr_E[5:0] == `JR)               Tnew_E = 3'd0;
                else if (instr_E[5:0] == `SYSCALL)          Tnew_E = 3'd0;
                else                                        Tnew_E = 3'd0;  
            end
            `CP0:   begin
                if (instr_E[25:21] == `MTCP0)       Tnew_E = 3'd0;
                else if (instr_E[25:21] == `MFCP0)  Tnew_E = 3'd2;
                else if (instr_E[5:0] == 6'b011000) Tnew_E = 3'd0;
                else                                Tnew_E = 3'd0;
            end
            `ORI, `ANDI, `ADDI:     Tnew_E = 3'd1;
            `LUI:                   Tnew_E = 3'd0;
            `SW, `SH, `SB:          Tnew_E = 3'd0;
            `LW, `LH, `LB:          Tnew_E = 3'd2;
            `BEQ, `BNE:             Tnew_E = 3'd0;
            `JAL:   Tnew_E = 3'd0;
            default:Tnew_E = 3'd0;
        endcase     
    end

    always @(posedge clk) begin
        if (reset || flush || Req) begin
            instr_E <= `NOP;
            PC_E <= reset ? 32'd0 : Req ? `HANDLER : flush ? PC_D : 32'd0;
            BD_E <= (reset || Req) ? 0 : flush ? BD_D : 0;
            Raw_ExcCode_E <= `NONE;
        end

        else                begin
            instr_E <= instr_D;
            PC_E    <= PC_D;
            regRD1_E <= F_regA1Data_D;
            regRD2_E <= F_regA2Data_D;
		    extRes_E <= extRes_D;
            BD_E <= BD_D;
            Raw_ExcCode_E <= ExcCode_D;
        end
    end

    Controller cu (
		.instr(instr_E),
        .regRA1(regRA1_E),
        .regRA2(regRA2_E),
        .regWA(regWA_E),
        .regWE(regWE_E),
        .aluMode(aluMode),
        .MUX_aluSrc(MUX_aluSrc)
    );

endmodule
