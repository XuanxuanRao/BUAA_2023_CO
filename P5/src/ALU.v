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
    output reg [31:0] res
    );

    always @(*) begin
        case (aluOp)
            `ALUADD:    res = srcA + srcB;
            `ALUSUB:    res = srcA - srcB;
            `ALUOR:     res = srcA | srcB;
            default:    res = 32'h00000000;
        endcase
    end


endmodule
