`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:14:10 11/11/2023 
// Design Name: 
// Module Name:    ForwardController 
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
module ForwardController(
    input [4:0] regRA1_D,
    input [4:0] regRA2_D,
    input [4:0] regRA1_E,
    input [4:0] regRA2_E,
    input [4:0] regWA_E,
    input regWE_E,
    input [4:0] regRA2_M,           // [$rt] (maybe write to the memory)
    input [4:0] regWA_M,
    input regWE_M,
    input [4:0] regWA_W,
    input regWE_W,
    output [1:0] F_MUX_regA1Data_D,
    output [1:0] F_MUX_regA2Data_D,
    output [1:0] F_MUX_regA1Data_E,
    output [1:0] F_MUX_regA2Data_E,
    output [1:0] F_MUX_regA2Data_M
    );

    `define ZERO 5'b00000

    // CMP or NPC 
    assign F_MUX_regA1Data_D =  (regRA1_D == regWA_E && regWE_E && regWA_E != `ZERO) ? 2'd2 : 
                                (regRA1_D == regWA_M && regWE_M && regWA_M != `ZERO) ? 2'd1 : 2'd0;

    assign F_MUX_regA2Data_D =  (regRA2_D == regWA_E && regWE_E && regWA_E != `ZERO) ? 2'd2 : 
                                (regRA2_D == regWA_M && regWE_M && regWA_M != `ZERO) ? 2'd1 : 2'd0;

    // ALU
    assign F_MUX_regA1Data_E =  (regRA1_E == regWA_M && regWE_M && regWA_M != `ZERO) ? 2'd2 :
                                (regRA1_E == regWA_W && regWE_W && regWA_W != `ZERO) ? 2'd1 : 2'd0;

    assign F_MUX_regA2Data_E =  (regRA2_E == regWA_M && regWE_M && regWA_M != `ZERO) ? 2'd2 :
                                (regRA2_E == regWA_W && regWE_W && regWA_W != `ZERO) ? 2'd1 : 2'd0;
    
    // DM
    assign F_MUX_regA2Data_M =  (regRA2_M == regWA_W && regWE_W && regWA_W != `ZERO) ? 2'd1 : 2'd0;


    


endmodule
