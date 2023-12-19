`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:50:43 11/09/2023 
// Design Name: 
// Module Name:    Controller 
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

module Controller(
    input [31:0] instr,                
    output reg [1:0] extMode,              
    output reg regWE,               
    output reg memWE,
    output reg [1:0] MUX_regWD,     // 0-alu   1-mem   2-PC+4   3-extRes
    output reg [2:0] aluMode,       // 
    output reg [1:0] MUX_aluSrc,    // 0-[$rt] 1-ext(imm)
    output reg [2:0] npcMode,
    output reg [4:0] regRA1,
    output reg [4:0] regRA2,
    output reg [4:0] regWA,
    output reg cmpMode,
    output [15:0] imm16,
	 output reg memMode
    );

    `define R 6'b000000

    assign imm16 = instr[15:0];

    always @(*) begin
        case (instr[31:26])
            `R:  begin
                if (instr[5:0] == `ADD)      begin
                    regWE = 1;
                    memWE = 0;
                    regRA1 = instr[25:21];
                    regRA2 = instr[20:16];
                    regWA = instr[15:11];   // write to $rd
                    MUX_regWD = 2'd0;       
                    MUX_aluSrc = 2'd0;      // [$rt] as src@ALU
                    aluMode = `ALUADD;                 
                    npcMode = `NPCNEXT;
                end
                else if (instr[5:0] == `SUB) begin
                    regWE = 1;
                    memWE = 0;
                    regRA1 = instr[25:21];
                    regRA2 = instr[20:16];
                    regWA = instr[15:11];   // write to $rd
                    MUX_regWD = 2'd0;
                    MUX_aluSrc = 2'd0;      // [$rt] as src@ALU
                    aluMode = `ALUSUB;  
                    npcMode = `NPCNEXT;
                end
                else if (instr[5:0] == `JR)  begin
                    regWE = 0;
                    memWE = 0;
                    regRA1 = instr[25:21];
                    npcMode = `NPCJREG;
                end
                else                        begin
                    regWE = 0;
                    memWE = 0;
                    npcMode = `NPCNEXT;
                end
            end
            `ORI:   begin
                regWE = 1;
                memWE = 0;
                regRA1 = instr[25:21];
                regRA2 = 5'b00000;
                regWA = instr[20:16];       // write to $rt
                MUX_regWD = 2'd0;           // res@ALU
                MUX_aluSrc = 2'd1;          // ext(imm) as srcB@ALU
                extMode = `EXTZERO;         // Zero_extend
                aluMode = `ALUOR;
                npcMode = `NPCNEXT;
            end
            `LUI:   begin
                regWE = 1;
                memWE = 0;
                regRA1 = 5'b00000;
                regRA2 = 5'b00000;
                regWA = instr[20:16];       // write to $rt
                MUX_regWD = 2'd3;           // res@EXT
                MUX_aluSrc = 2'd1;          // ext(imm) as srcB@ALU
                extMode = `EXTLUI;
                npcMode = `NPCNEXT;
            end
            `SW:    begin
                regWE = 0;
                memWE = 1;         
                regRA1 = instr[25:21];
                regRA2 = instr[20:16];
                regWA = 5'b00000;     
                MUX_aluSrc = 2'd1;          // ext(imm) as srcB@ALU
                extMode = `EXTSIGN;         // Sign_extend
                aluMode = `ALUADD;
                npcMode = `NPCNEXT;
					 memMode = 1'b0;
            end
            `LW:    begin
                regWE = 1;
                memWE = 0;
                regRA1 = instr[25:21];
                regRA2 = 5'b00000;
                regWA = instr[20:16];       // write to $rt
                MUX_regWD = 2'd1;           // RD@Memory
                MUX_aluSrc = 2'd1;          // ext(imm) as srcB@ALU
                extMode = `EXTSIGN;         // Sign_extend
                aluMode = `ALUADD;
                npcMode = `NPCNEXT;
					 memMode = 1'b0;
            end
            `BEQ:   begin
                regWE = 0;
                memWE = 0;
                regRA1 = instr[25:21];
                regRA2 = instr[20:16];
                regWA = 5'b00000;
                npcMode = `NPCBRANCH;
                cmpMode = `CMPBEQ;
            end
            `JAL:   begin
                regWE = 1;
			    memWE = 0;
                regRA1 = 5'b00000;
                regRA2 = 5'b00000;
                regWA = `RA;
                npcMode = `NPCJTYPE;
					 MUX_regWD = 2'd2;
            end
            default:begin
			    regWE = 0;
				memWE = 0;
                npcMode = `NPCNEXT;
            end
        endcase        
    end


endmodule
