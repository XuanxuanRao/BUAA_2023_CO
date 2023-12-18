`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:43:23 11/11/2023 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input clk,
    input reset,
    input [31:0] PC,
    input [4:0] regRA1,
    input [4:0] regRA2,
    input [4:0] regWA,
    input [31:0] regWD,
    input regWE,
    output [31:0] regRD1,
    output [31:0] regRD2
    );

    `define ZERO 5'b00000

    reg [31:0] regFile [31:0];

    integer i;

    initial begin
        for (i = 0; i < 32; i = i + 1) 
            regFile[i] <= 32'h00000000;
    end

    always @(posedge clk) begin
        if (reset)  begin
            for (i = 0; i < 32; i = i + 1)
                regFile[i] <= 32'h00000000;
        end

        else if (regWE) begin
            if (regWA == `ZERO)  begin
                regFile[regWA] <= 32'h00000000;
            end
            else                    begin
                regFile[regWA] <= regWD;
            end
        end
    end

    assign regRD1 = (regRA1 == regWA && regWE && regWA != `ZERO) ? regWD : regFile[regRA1];
    assign regRD2 = (regRA2 == regWA && regWE && regWA != `ZERO) ? regWD : regFile[regRA2]; 


endmodule
