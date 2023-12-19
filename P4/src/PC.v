`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:22:30 11/02/2023 
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
    input reset,
    output [31:0] PC
    );

    reg [31:0] tmp;

    always @(posedge clk) begin
        if (reset)  begin
            tmp <= 32'h00003000;
        end

        else    begin
            tmp <= PC_next;
        end
    end

    assign PC = tmp;

    
endmodule
