`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:12:10 11/02/2023 
// Design Name: 
// Module Name:    NPC 
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
module NPC(
    input [31:0] PC,
    input [25:0] imm26,
    input zero,
    input [1:0] mode,
    input [31:0] regValue,
    output [31:0] PC4,
    output reg [31:0] PC_next
    );

    parameter NEXT = 2'b00, BRANCH = 2'b01, J = 2'b10, JR = 2'b11;

    always @(*) begin
        case (mode)
            NEXT:       PC_next = PC + 4;
            BRANCH: begin
                if (zero)   PC_next = PC + 4 + {{14{imm26[15]}} ,imm26[15:0], 2'b00};
                else        PC_next = PC + 4;
            end
            J:          PC_next = {PC[31:28], imm26, 2'b00};
            JR:         PC_next = regValue;
            default:    PC_next = 32'h00003000;
        endcase
    end


    assign PC4 = PC + 4;


endmodule
