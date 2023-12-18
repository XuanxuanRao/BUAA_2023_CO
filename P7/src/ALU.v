`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:16:31 11/11/2023 
// Design Name: 
// Module Name:    ALU 
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

module ALU(
    input [31:0] srcA,
    input [31:0] srcB,
    input [2:0] aluOp,
    input [31:0] instr,
    output OV, ADEL, ADES,
    output reg [31:0] res
    );

    wire [32:0] tmpAdd = {srcA[31], srcA} + {srcB[31], srcB};
    wire [32:0] tmpSub = {srcA[31], srcA} - {srcB[31], srcB};
    wire isLoad  = instr[31:26] == `LW || instr[31:26] == `LH || instr[31:26] == `LB;
    wire isStore = instr[31:26] == `SW || instr[31:26] == `SH || instr[31:26] == `SB;

    always @(*) begin
        case (aluOp)
            `ALUADD:    begin
                res = srcA + srcB;
            end
            `ALUSUB:    begin
                res = srcA - srcB;
            end
            `ALUOR:     begin
                res = srcA | srcB;
            end
            `ALUAND:    begin
                res = srcA & srcB;
            end
            `ALUSLT:    begin
                res = $signed(srcA) < $signed(srcB) ? 32'd1 : 32'd0;
            end
            `ALUSLTU:   begin
                res = srcA < srcB ? 32'd1 : 32'd0;
            end
            default:    res = 32'h00000000;
        endcase
    end

    assign ADEL =  (tmpAdd[32]!=tmpAdd[31]) && (aluOp == `ALUADD) && isLoad;
    assign ADES =  (tmpAdd[32]!=tmpAdd[31]) && (aluOp == `ALUADD) && isStore;
    assign OV   =  !isLoad && !isStore && ((tmpAdd[32]!=tmpAdd[31] && aluOp == `ALUADD) || (tmpSub[32]!=tmpSub[31] && aluOp == `ALUSUB));

endmodule
