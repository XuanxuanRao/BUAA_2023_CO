`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:03:40 11/10/2023 
// Design Name: 
// Module Name:    Stall 
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

module Stall(
    input [2:0] Tuse_rs,
    input [2:0] Tuse_rt,
    input [4:0] RA1_D,
    input [4:0] RA2_D,
    input [4:0] WA_D,
    input WE_D,
    input [2:0] Tnew_E,
    input [4:0] WA_E,
    input WE_E,
    input [2:0] Tnew_M,
    input [4:0] WA_M,
    input WE_M, 
    output stall
    );


    wire stall_rs_E = (RA1_D == WA_E && WA_E != 5'd0) && WE_E && (Tnew_E > Tuse_rs);
    wire stall_rt_E = (RA2_D == WA_E && WA_E != 5'd0) && WE_E && (Tnew_E > Tuse_rt);
    
    wire stall_rs_M = (RA1_D == WA_M && WA_M != 5'd0) && WE_M && (Tnew_M > Tuse_rs);
    wire stall_rt_M = (RA2_D == WA_M && WA_M != 5'd0) && WE_M && (Tnew_M > Tuse_rt);

    assign stall = stall_rs_E | stall_rt_E | stall_rs_M | stall_rt_M;

endmodule
