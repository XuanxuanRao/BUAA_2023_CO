`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:10:21 10/31/2023 
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
module CMP(
    input [31:0] num1,
    input [31:0] num2,
    input [1:0] cmpOp,
    output reg cmpRes
    );

    parameter EQUAL = 2'b00, GREAT = 2'b01;

    always @(*) begin
        case (cmpOp)
            EQUAL:      cmpRes = (num1 == num2);
            GREAT:      cmpRes = (num1 > num2);
            default:    cmpRes = (num1 == num2); 
        endcase
    end
    
endmodule
