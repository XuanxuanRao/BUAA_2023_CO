`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:35:40 11/12/2023 
// Design Name: 
// Module Name:    mips 
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

module mips(
    input clk,
    input reset,
    input [31:0] i_inst_rdata,      // instr_F
    input [31:0] m_data_rdata,      
    output [31:0] i_inst_addr,      // PC_F
    output [31:0] m_data_addr,      // E-M   aluRes_M
    output [31:0] m_data_wdata,     // BE
    output [3 :0] m_data_byteen,    // BE
    output [31:0] m_inst_addr,      // E-M   PC_M
    output w_grf_we,                // M-W
    output [4:0] w_grf_addr,        // M-W
    output [31:0] w_grf_wdata,      // M-W
    output [31:0] w_inst_addr       // M-W   PC_W
);

    assign i_inst_addr = PC_F;
    assign m_inst_addr = PC_M;

    assign m_data_addr = aluRes_M;

    assign w_grf_we = regWE_W;
    assign w_grf_addr = regWA_W;
    assign w_grf_wdata = regWD_W;
	 
	wire start = instr_E[31:26] == `R && (instr_E[5:0]==`MULT || instr_E[5:0]==`MULTU || instr_E[5:0]==`DIV || instr_E[5:0]==`DIVU);
	
	
	
	wire [1:0] extMode;
	wire [1:0] memMode;
	wire [2:0] Tuse_rs, Tuse_rt, Tnew_E, Tnew_M;
    wire [4:0] regRA1_D, regRA2_D, regWA_D;
    wire [4:0] regRA1_E, regRA2_E, regWA_E;
    wire [31:0] instr_D, instr_E, instr_M, instr_W;
    wire [31:0] PC_F, PC_next, PC_D, PC_E, PC_M;
    wire [1:0] cmpMode;
    wire [2:0] npcMode;
    wire [2:0] aluMode;
    wire [31:0] muldivRes;
    wire [31:0] muldivRes_M, muldivRes_W;
    wire [31:0] aluRes_M, aluRes_W;
    wire [4:0] regRA1_M, regRA2_M, regWA_M;
    wire [31:0] regRD1_E, regRD2_E, extRes_E;
    wire [1:0] MUX_aluSrc;
    wire [4:0] regWA_W;
    wire [2:0] MUX_regWD_M, MUX_regWD_W;
    wire [1:0] F_MUX_regA1Data_D, F_MUX_regA2Data_D;
    wire [1:0] F_MUX_regA1Data_E, F_MUX_regA2Data_E;
    wire [1:0] F_MUX_regA2Data_M;
	wire [31:0] memRD_W, regRD1_W, regRD2_W;
	wire [31:0] extRes_D, regWD_D, regRD1_D, regRD2_D;
	wire [31:0] aluRes;
    wire [31:0] regRD1_M, regRD2_M;
	wire [31:0] extRes_M, extRes_W;
    wire [31:0] memRD_M;
	

    Stall SU (
        .Tuse_rs(Tuse_rs),
        .Tuse_rt(Tuse_rt),
        .RA1_D(regRA1_D),
        .RA2_D(regRA2_D),
        .WA_D(regWA_D),
        .Tnew_E(Tnew_E),
        .WA_E(regWA_E),
        .WE_E(regWE_E),
        .Tnew_M(Tnew_M),
        .WA_M(regWA_M),
        .WE_M(regWE_M),
        .busy(busy),
        .start(start),
        .instr_muldiv(instr_D_muldiv),
        .stall(flush)         
    );

    ForwardController FU(
        .regRA1_D(regRA1_D),
        .regRA2_D(regRA2_D),
        .regRA1_E(regRA1_E),
        .regRA2_E(regRA2_E),
        .regWA_E(regWA_E),
        .regWE_E(regWE_E),
        .regRA2_M(regRA2_M),
        .regWA_M(regWA_M),
        .regWE_M(regWE_M),
        .regWA_W(regWA_W),
        .regWE_W(regWE_W),
        .F_MUX_regA1Data_D(F_MUX_regA1Data_D),
        .F_MUX_regA2Data_D(F_MUX_regA2Data_D),
        .F_MUX_regA1Data_E(F_MUX_regA1Data_E),
        .F_MUX_regA2Data_E(F_MUX_regA2Data_E),
        .F_MUX_regA2Data_M(F_MUX_regA2Data_M)
    );

    wire [31:0] F_regA1Data_D = F_MUX_regA1Data_D == 2'd2 ? extRes_E : F_MUX_regA1Data_D == 2'd1 ? regWD_M : regRD1_D;
    wire [31:0] F_regA2Data_D = F_MUX_regA2Data_D == 2'd2 ? extRes_E : F_MUX_regA2Data_D == 2'd1 ? regWD_M : regRD2_D; 
    wire [31:0] F_regA1Data_E = F_MUX_regA1Data_E == 2'd2 ? regWD_M : F_MUX_regA1Data_E == 2'd1 ? regWD_W : regRD1_E;
    wire [31:0] F_regA2Data_E = F_MUX_regA2Data_E == 2'd2 ? regWD_M : F_MUX_regA2Data_E == 2'd1 ? regWD_W : regRD2_E;
    wire [31:0] F_regA2Data_M = F_MUX_regA2Data_M == 2'd1 ? regWD_W : regRD2_M; 


    wire [31:0] aluSrcA = F_regA1Data_E;
    wire [31:0] aluSrcB = MUX_aluSrc == 2'd1 ? extRes_E : F_regA2Data_E; 
    
	wire [31:0] regWD_M = MUX_regWD_M == 3'd4 ? muldivRes_M : MUX_regWD_M == 3'd3 ? extRes_M : MUX_regWD_M == 3'd2 ? m_inst_addr + 8 : aluRes_M; 
    wire [31:0] regWD_W = MUX_regWD_W == 3'd4 ? muldivRes_W : MUX_regWD_W == 3'd3 ? extRes_W : MUX_regWD_W == 3'd2 ? w_inst_addr + 8 : MUX_regWD_W == 3'd1 ? memRD_W : aluRes_W; 
	wire [15:0] imm16_D;

    PC pcInstance (
        .clk(clk),
        .reset(reset),
        .flush(flush),
        .PC_next(PC_next),
        .PC_F(PC_F)
    );

    wire [31:0] instrAddr = PC_F - 32'h00003000;


    D DREG (
        .instr(i_inst_rdata),
        .PC(PC_F),
        .clk(clk),
        .reset(reset),
        .flush(flush),
        .instr_D(instr_D),
        .PC_D(PC_D),
        .imm16_D(imm16_D),
        .regRA1_D(regRA1_D),
        .regRA2_D(regRA2_D),
        .regWA_D(regWA_D),
        .regWE_E(regWE_E),
        .npcMode(npcMode),
        .cmpMode(cmpMode),
        .instr_D_muldiv(instr_D_muldiv),
        .extMode(extMode)
    );

    EXT extInstance (
        .imm(imm16_D),
        .mode(extMode),
        .res(extRes_D)
    );

    NPC npcInstance (
        .PC_F(PC_F),
        .PC_D(PC_D),
        .mode(npcMode),
        .cmpRes(cmpRes),
        .imm26_D(instr_D[25:0]),
        .regRD1_D(F_regA1Data_D),
        .PC_next(PC_next)
    );

    CMP cmpInstance (
        .srcA(F_regA1Data_D),
        .srcB(F_regA2Data_D),
        .mode(cmpMode),
        .res(cmpRes)
    );

    GRF grfInstance (
        .clk(clk),
        .reset(reset),
        .PC(w_inst_addr),
        .regRA1(regRA1_D),
        .regRA2(regRA2_D),
        .regWA(regWA_W),
        .regWD(regWD_W),
        .regWE(regWE_W),
        .regRD1(regRD1_D),
        .regRD2(regRD2_D)
    );

    Tuse TuseCount (
        .instr(instr_D),
        .Tuse_rs(Tuse_rs),
        .Tuse_rt(Tuse_rt)
    );


		

    E EREG (
        .clk(clk),
        .reset(reset),
        .flush(flush),
        .instr(instr_D),
        .PC(PC_D),
        .F_regA1Data_D(F_regA1Data_D),
        .F_regA2Data_D(F_regA2Data_D),
        .extRes_D(extRes_D),
        .regRA1_E(regRA1_E),
        .regRA2_E(regRA2_E),
        .regWA_E(regWA_E),
        .regWE_E(regWE_E),
        .regRD1_E(regRD1_E),
        .regRD2_E(regRD2_E),
        .extRes_E(extRes_E),
        .aluMode(aluMode),
        .MUX_aluSrc(MUX_aluSrc),
        .Tnew_E(Tnew_E),
        .instr_E(instr_E),
        .PC_E(PC_E)
    );

    ALU aluInstance (
        .srcA(aluSrcA),
        .srcB(aluSrcB),
        .aluOp(aluMode),
        .res(aluRes)
    );

    MulDiv MDU (
        .instr(instr_E),
		  .start(start),
        .srcA(F_regA1Data_E),
        .srcB(F_regA2Data_E),
        .clk(clk),
        .reset(reset),
        .busy(busy),
        .muldivRes(muldivRes)
    );



    M MREG (
        .clk(clk),
        .reset(reset),
        .instr(instr_E),
        .PC(PC_E),
        .F_regA1Data_E(F_regA1Data_E),
        .F_regA2Data_E(F_regA2Data_E),
        .aluRes_E(aluRes),
        .muldivRes_E(muldivRes),
        .instr_M(instr_M),
		.extRes_E(extRes_E),
        .PC_M(m_inst_addr),
        .memWE_M(memWE_M),
        .memMode(memMode),
        .regRA1_M(regRA1_M),
        .regRA2_M(regRA2_M),
        .regRD1_M(regRD1_M),
        .regRD2_M(regRD2_M),
        .regWA_M(regWA_M),
        .regWE_M(regWE_M),
        .Tnew_M(Tnew_M),
		.extRes_M(extRes_M),
        .aluRes_M(aluRes_M),
        .muldivRes_M(muldivRes_M),
        .MUX_regWD_M(MUX_regWD_M)
    );


    DM_bridge dmbridge (
        .memWE(memWE_M),
        .memMode(memMode),
        .memWD(F_regA2Data_M),
        .m_data_rdata(m_data_rdata),
        .addr(m_data_addr[1:0]),
        .byteen(m_data_byteen),
        .m_data_wdata(m_data_wdata),
        .memRD(memRD_M)
    );

    

    W WREG (
        .clk(clk),
        .reset(reset),
        .instr(instr_M),
        .PC(m_inst_addr),
        .memRD_M(memRD_M),
		.extRes_M(extRes_M),
        .aluRes_M(aluRes_M),
        .muldivRes_M(muldivRes_M),
        .F_regA1Data_M(regRD1_M),
        .F_regA2Data_M(F_regA2Data_M),
        .instr_W(instr_W),
        .PC_W(w_inst_addr),
        .memRD_W(memRD_W),
        .aluRes_W(aluRes_W),
        .regRD1_W(regRD1_W),
        .regRD2_W(regRD2_W),
		.extRes_W(extRes_W),
        .muldivRes_W(muldivRes_W),
        .regWE_W(regWE_W),
        .regWA_W(regWA_W),
        .MUX_regWD_W(MUX_regWD_W)
    );
    






endmodule
