`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:18:54 10/12/2023 
// Design Name: 
// Module Name:    ext 
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
module ext(
    input [15:0] imm,
    input [1:0] EOp,
    output reg [31:0] ext
    );

    always @(*) begin
        case (EOp)
            2'b00:
                ext = {{16{imm[15]}}, imm};
            2'b01:
                ext = {16'h0000, imm};
            2'b10:
                ext = {imm, 16'h0000};
            2'b11:
                ext = {{14{imm[15]}}, imm, 2'b00};
            default:   begin
					ext = 32'h00000000;
				end
        endcase
    end


endmodule
