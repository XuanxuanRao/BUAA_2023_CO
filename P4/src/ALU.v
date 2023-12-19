`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:19:09 10/31/2023 
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
module ALU(
    input [31:0] srcA,
    input [31:0] srcB,
    input [4:0] shamt,
    input [2:0] aluOp,
    output reg [31:0] aluRes
    );


    parameter ADD = 3'b000, SUB = 3'b001, OR = 3'b010, HIGH = 3'b011;

    always @(*) begin
        case (aluOp)
            ADD:        aluRes = srcA + srcB;
            SUB:        aluRes = srcA - srcB;
            OR:         aluRes = srcA | srcB;
            HIGH:       aluRes = {srcB[15:0], {16{1'b0}}}; 
            default:    aluRes = 32'h00000000;
        endcase
    end

endmodule
