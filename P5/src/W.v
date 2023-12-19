`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:00:08 11/12/2023 
// Design Name: 
// Module Name:    W 
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
module W(
    input clk,
    input reset,
    input [31:0] instr,
    input [31:0] PC,
    input [31:0] memRD_M,
    input [31:0] aluRes_M,
    input [31:0] F_regA1Data_M,
    input [31:0] F_regA2Data_M,
	 input [31:0] extRes_M, 
    output reg [31:0] instr_W,
    output reg [31:0] PC_W,
    output reg [31:0] memRD_W,
    output reg [31:0] aluRes_W,
    output reg [31:0] regRD1_W,
    output reg [31:0] regRD2_W,
	 output reg [31:0] extRes_W,
    output regWE_W,
    output [4:0] regWA_W,
    output [1:0] MUX_regWD_W
    );

    `define NOP 32'h00000000

    always @(posedge clk) begin
        if (reset)  begin
            PC_W <= `NOP;
        end

        else        begin
            instr_W  <= instr;
            PC_W     <= PC;
            aluRes_W <= aluRes_M;
            memRD_W  <= memRD_M;
            regRD1_W <= F_regA1Data_M;
            regRD2_W <= F_regA2Data_M;
			extRes_W <= extRes_M;
        end
    end


    Controller cu (
		  .instr(instr_W),
        .regWA(regWA_W),
        .regWE(regWE_W),
        .MUX_regWD(MUX_regWD_W)
    );


endmodule
