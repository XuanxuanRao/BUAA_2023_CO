`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:33:58 11/12/2023 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input [31:0] PC_next,
    input clk,
    input flush,
    input reset,
    output reg [31:0] PC_F
    );

    initial begin
        PC_F <= 32'h00003000;
    end

    always @(posedge clk) begin
        if (reset)  begin
            PC_F <= 32'h00003000;
        end

        else if (!flush)    begin
            PC_F <= PC_next;
        end
    end


endmodule
