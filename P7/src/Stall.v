`timescale 1ns / 1ps
`include "param.v"

module Stall(
    input [2:0] Tuse_rs,
    input [2:0] Tuse_rt,
    input instr_muldiv,
    input [4:0] RA1_D,
    input [4:0] RA2_D,
    input [4:0] WA_D,
    input ERET_D,
    input [2:0] Tnew_E,
    input [31:0] instr_E,
    input [4:0] WA_E,
    input WE_E,
    input [31:0] instr_M,
    input [2:0] Tnew_M,
    input [4:0] WA_M,
    input WE_M,
    input busy, 
    input start, 
    output stall
    );



    wire stall_rs_E = (RA1_D == WA_E && WA_E != 5'd0) && WE_E && (Tnew_E > Tuse_rs);
    wire stall_rt_E = (RA2_D == WA_E && WA_E != 5'd0) && WE_E && (Tnew_E > Tuse_rt);
    
    wire stall_rs_M = (RA1_D == WA_M && WA_M != 5'd0) && WE_M && (Tnew_M > Tuse_rs);
    wire stall_rt_M = (RA2_D == WA_M && WA_M != 5'd0) && WE_M && (Tnew_M > Tuse_rt);

    wire stall_muldiv_E = (busy || start) && instr_muldiv;

    wire stall_ERET = ERET_D && ((instr_E[31:26]==`CP0 && instr_E[25:21]==`MTCP0 && WA_E == 5'd14) || (instr_M[31:26]==`CP0 && instr_M[25:21]==`MTCP0 && WA_M == 5'd14));

    assign stall = stall_rs_E | stall_rt_E | stall_rs_M | stall_rt_M | stall_muldiv_E | stall_ERET;

endmodule
