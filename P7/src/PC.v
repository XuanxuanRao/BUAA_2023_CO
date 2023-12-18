`timescale 1ns / 1ps
`include "param.v"

module PC(
    input [31:0] PC_next,
    input clk,
    input ERET_D,
    input Req,
    input flush,
    input reset,
    input [31:0] EPC_M,
    output [31:0] PC_F
    );

    reg [31:0] PCtmp;

    assign PC_F = ERET_D ? EPC_M : PCtmp;

//    initial begin
//        PC_F <= 32'h00003000;
//    end

    always @(posedge clk) begin
        if (reset) 
            PCtmp <= 32'h00003000;
        else if (!flush || Req)   
            PCtmp <= PC_next;
    end


endmodule
