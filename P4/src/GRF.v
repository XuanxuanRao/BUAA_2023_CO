`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:43:39 11/01/2023 
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
    input [4:0] regA1,
    input [4:0] regA2,
    input [4:0] regWA,
    input [31:0] regWD,
    input [31:0] PC,
    input regWE,
    input clk,
    input reset,
    output [31:0] regRD1,
    output [31:0] regRD2
    );

    parameter ZERO = 5'b00000;
    reg [31:0] rf [31:0];
    integer i;

    initial begin
        for (i = 0; i < 32; i = i + 1)  begin
            rf[i] <= 32'h00000000;
        end
    end

    always @(posedge clk) begin
        if(reset)   begin 
            for (i = 0; i < 32; i = i + 1) begin 
                rf[i] <= 32'h00000000;
			end
        end

        else        begin
            if(regWE)   begin
                $display("@%h: $%d <= %h", PC, regWA, regWD);
                if (regWA != ZERO) 
                    rf[regWA] <= regWD;
            end
        end
    end

    assign regRD1 = (regA1 == ZERO) ? 32'h00000000 : rf[regA1];
    assign regRD2 = (regA2 == ZERO) ? 32'h00000000 : rf[regA2];

endmodule
