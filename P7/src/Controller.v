`timescale 1ns / 1ps
`include "param.v"

module Controller(
    input [31:0] instr,                
    output reg [1:0] extMode,              
    output reg regWE,               
    output reg memWE,
    output reg [2:0] MUX_regWD,     // 0-alu   1-mem   2-PC+4   3-extRes   4-muldivRes   5-CP0
    output reg [2:0] aluMode,       
    output reg [1:0] MUX_aluSrc,    // 0-[$rs] 1-ext(imm)
    output reg [2:0] npcMode,
    output reg [4:0] regRA1,
    output reg [4:0] regRA2,
    output reg [4:0] regWA,
    output reg [1:0] cmpMode,
    output [15:0] imm16,
    output muldiv,
    output reg RI,
	output reg [1:0] memMode
    );

    wire [5:0] funct = instr[5:0];

    assign imm16 = instr[15:0];
    assign muldiv = instr[31:26] == `R && 
                    (funct==`MTHI||funct==`MTLO||funct==`MULT||funct==`MULTU||funct==`DIV||funct==`DIVU||funct==`MFHI||funct==`MFLO);

    always @(*) begin
        case (instr[31:26])
            `R:  begin
                if (funct == `ADD || funct == `SUB || funct == `AND || funct == `OR || funct == `SLT || funct == `SLTU)      begin
                    RI = 0;
                    regWE = 1;  memWE = 0;
                    npcMode = `NPCNEXT;
                    regRA1 = instr[25:21];
                    regRA2 = instr[20:16];
                    regWA = instr[15:11];   // write to $rd
                    MUX_regWD = 3'd0;       // res@ALU as WD@GRF
                    MUX_aluSrc = 2'd0;      // [$rt] as src@ALU
                    aluMode = funct == `ADD ? `ALUADD : funct == `SUB ? `ALUSUB : funct == `AND ? `ALUAND : funct == `OR ? `ALUOR : funct == `SLT ? `ALUSLT : `ALUSLTU;                 
                end
                else if (funct == `MFHI || funct == `MFLO)  begin
                    RI = 0;
                    regWE = 1;  memWE = 0;
                    npcMode = `NPCNEXT;
                    regWA = instr[15:11];   // write to $rd
                    MUX_regWD = 3'd4;       // res@MulDiv as WD@GRF
                    aluMode = 0;
                end
                else if (funct == `MTHI || funct == `MTLO)  begin
                    RI = 0;
                    regWE = 0;  memWE = 0;
                    npcMode = `NPCNEXT;
                    regRA1 = instr[25:21];
                    aluMode = 0;
                end
                else if (funct == `MULT || funct == `MULTU || funct == `DIV || funct == `DIVU)    begin
                    RI = 0;
                    regWE = 0;  memWE = 0;
                    npcMode = `NPCNEXT;
                    regRA1 = instr[25:21];
                    regRA2 = instr[20:16];
                    aluMode = 0;
                end
                else if (funct == `JR)  begin
                    RI = 0;
                    regWE = 0;  memWE = 0;
                    npcMode = `NPCJREG;
                    regRA1 = instr[25:21];
                    aluMode = 0;
                end
                else if (funct == `SYSCALL)     begin
                    RI = 0;
                    regWE = 0;  memWE = 0;
                    npcMode = `NPCNEXT;
                    aluMode = 0;
                end
                else if (funct == 6'b000000)    begin
                    RI = 0;
                    regWE = 0;  memWE = 0;
                    npcMode = `NPCNEXT;
                    aluMode = 0;
                end
                else                    begin
                    RI = 1;
                    regWE = 0;  memWE = 0;
                    aluMode = 0;
                end
            end
            `CP0:   begin
                if (instr[25:21] == `MFCP0)         begin
                    RI = 0;
                    regWE = 1;  memWE = 0;
                    npcMode = `NPCNEXT;
                    regRA1 = instr[15:11];
                    regWA = instr[20:16];   
                    MUX_regWD = 3'd5;       // CP0out@CP0 as WD@GRF
                    aluMode = 0;
                end
                else if (instr[25:21] == `MTCP0)    begin
                    RI = 0;
                    regWE = 0;  memWE = 0;
                    npcMode = `NPCNEXT;
                    regRA2 = instr[20:16];
                    regWA = instr[15:11];
                    aluMode = 0;
                end
                else if (instr[5:0] == 6'b011000)   begin
                    RI = 0;
                    regWE = 0;  memWE = 0;
                    npcMode = `NPCEPC;
                    aluMode = 0;
                end
                else    begin
                    RI = 1;
                    regWE = 0;  memWE = 0;
                    aluMode = 0;
                end
            end
            `ADDI, `ANDI, `ORI:   begin
                RI = 0;
                regWE = 1;  memWE = 0;
                npcMode = `NPCNEXT;
                regRA1 = instr[25:21];
                regWA = instr[20:16];       // write to $rt
                MUX_regWD = 3'd0;           // res@ALU as WD@GRF
                MUX_aluSrc = 2'd1;          // ext(imm) as srcB@ALU
                extMode = instr[31:26] == `ADDI ? `EXTSIGN : `EXTZERO;
                aluMode = instr[31:26] == `ADDI ? `ALUADD : instr[31:26] == `ANDI ? `ALUAND : `ALUOR;
            end
            `LUI:               begin
                RI = 0;
                regWE = 1;  memWE = 0;
                npcMode = `NPCNEXT;
                regWA = instr[20:16];       // write to $rt
                MUX_regWD = 3'd3;           // res@EXT as WD@GRF
                MUX_aluSrc = 2'd1;          // ext(imm) as srcB@ALU
                extMode = `EXTLUI;
                aluMode = 0;
            end
            `SW, `SH, `SB:      begin
                RI = 0;
                regWE = 0;  memWE = 1;     
                npcMode = `NPCNEXT;    
                regRA1 = instr[25:21];
                regRA2 = instr[20:16]; 
                MUX_aluSrc = 2'd1;          // ext(imm) as srcB@ALU
                extMode = `EXTSIGN;         // Sign_extend
                aluMode = `ALUADD;
				memMode = instr[31:26] == `SW ? `MEMWORD : instr[31:26] == `SH ? `MEMHALF : `MEMBYTE;
            end
            `LW, `LH, `LB:       begin
                RI = 0;
                regWE = 1;  memWE = 0;
                regRA1 = instr[25:21];
                regWA = instr[20:16];       // write to $rt
                MUX_regWD = 3'd1;           // RD@Memory as WD@GRF
                MUX_aluSrc = 2'd1;          // ext(imm) as srcB@ALU
                extMode = `EXTSIGN;         // Sign_extend
                aluMode = `ALUADD;
                npcMode = `NPCNEXT;
				memMode = instr[31:26] == `LW ? `MEMWORD : instr[31:26] == `LH ? `MEMHALF : `MEMBYTE;
            end
            `BEQ, `BNE:         begin
                RI = 0;
                regWE = 0;  memWE = 0;
                npcMode = `NPCBRANCH;
                regRA1 = instr[25:21];
                regRA2 = instr[20:16];
                cmpMode = instr[31:26] == `BEQ ? `CMPEQ : `CMPNEQ;
                aluMode = 0;
            end
            `JAL:               begin
                RI = 0;
                regWE = 1;  memWE = 0;
                npcMode = `NPCJTYPE;
                regWA = `RA;
				MUX_regWD = 3'd2;           // PC+4 as WD@GRF
                aluMode = 0;
            end
            default:            begin
                RI = 1;
                regWE = 0;  memWE = 0;
                aluMode = 0;
            end
        endcase        
    end


endmodule
