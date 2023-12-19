`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:32:22 11/11/2023 
// Design Name: 
// Module Name:    DM 
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

module DM(
    input clk,
    input reset,
    input [31:0] PC,
    input [31:0] memAddr,
    input memWE,
    input [31:0] memWD,
    input mode,
    output reg [31:0] memRD
    );

    reg [31:0] memory [3071:0];

    integer i;

    initial begin
        for (i = 0; i < 3072; i = i + 1)
            memory[i] <= 32'h00000000;
    end

    always @(posedge clk) begin
        if (reset)  begin
            for (i = 0; i < 3072; i = i + 1)
                memory[i] <= 32'h00000000; 
        end

        else if (memWE) begin
            if (mode == 1'b0)   begin
                memory[memAddr[13:2]] <= memWD;
                $display("%d@%h: *%h <= %h", $time, PC, memAddr, memWD);  
            end 
        end
    end

    always @(*) begin
        if (mode == 1'b0)   
            memRD = memory[memAddr[13:2]];
        else
            memRD = 32'h00000000;
    end

endmodule
