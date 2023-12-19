`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:03:47 11/09/2023 
// Design Name: 
// Module Name:    CMP 
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

module CMP(
    input [31:0] srcA,
    input [31:0] srcB,
    input mode,
    output reg res
    );
	 
    always @(*) begin
        case (mode)
            `CMPBEQ:    res = srcA == srcB; 
            default:    res = srcA == srcB; 
        endcase
    end


endmodule
