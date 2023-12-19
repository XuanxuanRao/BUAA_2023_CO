`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:50:39 11/02/2023 
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
module Controller(
    input [5:0] opCode,
    input [5:0] funct,
    output [2:0] aluOp,
    output regWE,
    output memWE,
    output memMode,
    output aluSrcMux,           // imm as srcB
    output extMode,             // Sign Extend
    output [1:0] regWAMux,            // 0-rt / 1-rd / 2-$ra
    output [1:0] regWDMux,            // 0-aluRes / 1-memRD / 2-PC4
    output [1:0] npcMode
    );

    parameter NPCNEXT = 2'b00, NPCBRANCH = 2'b01, NPCJ = 2'b10, NPCJR = 2'b11;
    parameter ALUADD = 3'b000, ALUSUB = 3'b001, ALUOR = 3'b010, ALUHIGH = 3'b011, ALUNOP = 3'b111;

    parameter NOP = 4'd0, ADD = 4'd1, SUB = 4'd2, ORI = 4'd3, LW = 4'd4, SW = 4'd5, BEQ = 4'd6, LUI = 4'd7, J = 4'd8, JAL = 4'd9, JR = 4'd10;
    reg [3:0] instrKind;

    always @(*) begin
        case (opCode)
            6'b000000:  begin
                if (funct == 6'b100000)         instrKind = ADD;  
                else if (funct == 6'b100010)    instrKind = SUB;
                else if (funct == 6'b001000)    instrKind = JR;
                else                            instrKind = NOP;
            end 
            6'b001101:                          instrKind = ORI;
            6'b100011:                          instrKind = LW;
            6'b101011:                          instrKind = SW;
            6'b000100:                          instrKind = BEQ;
            6'b001111:                          instrKind = LUI;
            6'b000010:                          instrKind = J;
            6'b000011:                          instrKind = JAL;
            default:                            instrKind = NOP;
        endcase 
    end


    assign  regWE = instrKind == ADD || instrKind == SUB || instrKind == ORI || instrKind == LW || instrKind == JAL || instrKind == LUI;
    assign  memWE = instrKind == SW;
    assign  aluOp = (instrKind == ADD || instrKind == LW || instrKind == SW) ? ALUADD : 
                    (instrKind == SUB) ? ALUSUB : 
                    (instrKind == ORI)  ? ALUOR : 
                    (instrKind == LUI) ? ALUHIGH : ALUNOP;
    assign  extMode = instrKind == LW || instrKind == SW;
    assign  aluSrcMux = instrKind == ORI || instrKind == LW || instrKind == SW || instrKind == LUI;
    assign  memMode = 0;
    assign  npcMode = (instrKind == BEQ) ? NPCBRANCH :
                      (instrKind == J || instrKind == JAL)   ? NPCJ :
                      (instrKind == JR)  ? NPCJR : NPCNEXT;
    assign  regWAMux = (instrKind == ADD || instrKind == SUB) ? 2'b01 :
                       (instrKind == JAL) ? 2'b10 : 2'b00;
    assign  regWDMux = (instrKind == LW)  ? 2'b01 :
                       (instrKind == JAL) ? 2'b10 : 2'b00;
    

endmodule
