`timescale 1ns / 1ps
`include "param.v"

module W(
    input clk,
    input reset,
    input Req,
    input [31:0] CP0out_M,
    input [31:0] instr_M,
    input [31:0] PC_M,
    input [31:0] memRD_M,
    input [31:0] aluRes_M,
    input [31:0] F_regA1Data_M,
    input [31:0] F_regA2Data_M,
	input [31:0] extRes_M,
    input [31:0] muldivRes_M, 
    output reg [31:0] CP0out_W,
    output reg [31:0] instr_W,
    output reg [31:0] PC_W,
    output reg [31:0] memRD_W,
    output reg [31:0] aluRes_W,
    output reg [31:0] regRD1_W,
    output reg [31:0] regRD2_W,
	output reg [31:0] extRes_W,
    output reg [31:0] muldivRes_W,
    output regWE_W,
    output [4:0] regWA_W,
    output [2:0] MUX_regWD_W
    );

    `define NOP 32'h00000000

    always @(posedge clk) begin
        if (reset || Req)  begin
            instr_W <= `NOP;
            PC_W <= reset ? 32'd0 : Req ? `HANDLER : 32'd0;
        end

        else        begin
            instr_W  <= instr_M;
            PC_W     <= PC_M;
            aluRes_W <= aluRes_M;
            memRD_W  <= memRD_M;
            regRD1_W <= F_regA1Data_M;
            regRD2_W <= F_regA2Data_M;
			extRes_W <= extRes_M;
            muldivRes_W <= muldivRes_M;
            CP0out_W <= CP0out_M;
        end
    end


    Controller cu (
		.instr(instr_W),
        .regWA(regWA_W),
        .regWE(regWE_W),
        .MUX_regWD(MUX_regWD_W)
    );


endmodule
