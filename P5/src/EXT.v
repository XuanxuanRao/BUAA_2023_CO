`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:32:56 11/12/2023 
// Design Name: 
// Module Name:    EXT 
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

module EXT(
    input [15:0] imm,
    input [1:0] mode,
    output [31:0] res
    );

    assign res = (mode == `EXTZERO) ? {16'h0000, imm} : (mode == `EXTSIGN) ? {{16{imm[15]}}, imm} : 
                 (mode == `EXTLUI) ? {imm, 16'h0000} : 32'h00000000;


endmodule
