`timescale 1ns / 1ps
`include "param.v"
`define OpCode_M instr_M[31:26]

module CPU(
    input clk,
    input reset,
    input [5:0] HWInt,              // interrupt signal from IG, TC
    input [31:0] i_inst_rdata,      // instr_F
    input [31:0] m_mem_rdata,       // notes: a word read from memory, it needs to be processed before using
    output [31:0] i_inst_addr,      // PC_F
    output [31:0] m_mem_addr,       // memRA_M
    output [31:0] m_mem_wdata,      // notes: a word writing to memory, it has been processed by MEMFIX
    output [3 :0] m_mem_byteen,     // 
    output [31:0] m_inst_addr,      // PC_M
    output w_grf_we,                // regWE_W
    output [4:0] w_grf_addr,        // regWA_W
    output [31:0] w_grf_wdata,      // regWD_W
    output [31:0] w_inst_addr,      // PC_W
    output [31:0] macroscopic_pc	
);

    assign macroscopic_pc = m_inst_addr;

    assign m_mem_addr = aluRes_M;

    assign w_grf_wdata = regWD_W;
	 
	wire start = instr_E[31:26] == `R && (instr_E[5:0]==`MULT || instr_E[5:0]==`MULTU || instr_E[5:0]==`DIV || instr_E[5:0]==`DIVU);
	
    assign m_mem_byteen = Req ? 4'b0000 : m_byteen;
	
    wire [31:0] instr_F = ExcCode_F == `AdEL ? 32'd0 : i_inst_rdata; 
    wire [31:0] CP0out_M, EPC_M, CP0out_W;
    wire [3:0] m_byteen;
    wire [4:0] Raw_ExcCode_D, Raw_ExcCode_E, Raw_ExcCode_M;
	wire [1:0] extMode; wire [1:0] memMode; wire [1:0] cmpMode; wire [2:0] npcMode; wire [2:0] aluMode;
	wire [2:0] Tuse_rs, Tuse_rt, Tnew_E, Tnew_M;
    wire [4:0] regRA1_D, regRA2_D, regWA_D, regRA1_E, regRA2_E, regWA_E, regRA1_M, regRA2_M, regWA_M;
    wire [31:0] instr_D, instr_E, instr_M, instr_W;
    wire [31:0] PC_next, PC_D, PC_E;
    wire [31:0] muldivRes, muldivRes_M, muldivRes_W;
    wire [31:0] aluRes, aluRes_M, aluRes_W;
    wire [31:0] regRD1_E, regRD2_E, extRes_E;
    wire [1:0] MUX_aluSrc;
    wire [2:0] MUX_regWD_M, MUX_regWD_W;
    wire [1:0] F_MUX_regA1Data_D, F_MUX_regA2Data_D, F_MUX_regA1Data_E, F_MUX_regA2Data_E, F_MUX_regA2Data_M;
	wire [31:0] memRD_W, regRD1_W, regRD2_W;
	wire [31:0] extRes_D, regRD1_D, regRD2_D;
    wire [31:0] regRD1_M, regRD2_M;
	wire [31:0] extRes_M, extRes_W;
    wire [31:0] memRD_M;
	

    Stall SU (
        .Tuse_rs(Tuse_rs),
        .Tuse_rt(Tuse_rt),
        .RA1_D(regRA1_D),
        .RA2_D(regRA2_D),
        .WA_D(regWA_D),
        .ERET_D(ERET_D),
        .instr_E(instr_E),
        .Tnew_E(Tnew_E),
        .WA_E(regWA_E),
        .WE_E(regWE_E),
        .instr_M(instr_M),
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
        .regWA_W(w_grf_addr),
        .regWE_W(w_grf_we),
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
    wire [31:0] regWD_W = MUX_regWD_W == 3'd5 ? CP0out_W : MUX_regWD_W == 3'd4 ? muldivRes_W : MUX_regWD_W == 3'd3 ? extRes_W : MUX_regWD_W == 3'd2 ? w_inst_addr + 8 : MUX_regWD_W == 3'd1 ? memRD_W : aluRes_W;


    wire AccessTimer_M = m_mem_addr>=`TC0BEGIN && m_mem_addr<=`TC0END || m_mem_addr>=`TC1BEGIN && m_mem_addr<=`TC1END;
    wire AccessCount_M = m_mem_addr==32'h00007f08 || m_mem_addr==32'h00007f18;
    wire AccessDM_M = m_mem_addr>=`DMBEGIN && m_mem_addr<=`DMEND;
    wire AccessIG_M = m_mem_addr>=`IGBEGIN && m_mem_addr<=`IGEND; 
    wire ADEL_M =   (`OpCode_M==`LW && m_mem_addr[1:0]!=2'b00) || (`OpCode_M==`LH && m_mem_addr[0]) || ((`OpCode_M==`LH || `OpCode_M==`LB) && AccessTimer_M) || 
                    ((`OpCode_M==`LW || `OpCode_M==`LH || `OpCode_M==`LB) && !AccessTimer_M && !AccessDM_M && !AccessIG_M);
    wire ADES_M =   (`OpCode_M==`SW && m_mem_addr[1:0]!=2'b00) || (`OpCode_M==`SH && m_mem_addr[0]) || ((`OpCode_M==`SH || `OpCode_M==`SB) && AccessTimer_M) || 
                    ((`OpCode_M==`SW || `OpCode_M==`SH || `OpCode_M==`SB) && !AccessTimer_M && !AccessDM_M && !AccessIG_M) || (`OpCode_M==`SW && AccessCount_M);
    
    wire [4:0] ExcCode_F =  (!ERET_D && (i_inst_addr[1:0]!=2'b00 || i_inst_addr<32'h00003000 || i_inst_addr>32'h00006fff)) ? `AdEL : `NONE;
    wire [4:0] ExcCode_D =  Raw_ExcCode_D != `NONE ? Raw_ExcCode_D : 
                            (instr_D[31:26]==`R&&instr_D[5:0]==`SYSCALL) ? `Syscall : RI_D ? `RI : `NONE;
    wire [4:0] ExcCode_E =  Raw_ExcCode_E != `NONE ? Raw_ExcCode_E :
                            OV_E ? `Ov : ADEL_E ? `AdEL : ADES_E ? `AdES : `NONE;
    wire [4:0] ExcCode_M =  Raw_ExcCode_M != `NONE ? Raw_ExcCode_M : 
                            ADEL_M ? `AdEL : ADES_M ? `AdES : `NONE;
    
    wire BD_F = npcMode == `NPCBRANCH || npcMode == `NPCJTYPE || npcMode == `NPCJREG;

    
 
	wire [15:0] imm16_D;

    PC pcInstance (
        .clk(clk),
        .reset(reset),
        .flush(flush),
		.Req(Req),
        .ERET_D(ERET_D),
        .PC_next(PC_next),
        .EPC_M(EPC_M),
        .PC_F(i_inst_addr)
    );



    D DREG (
        .instr_F(instr_F),
        .PC_F(i_inst_addr),
        .clk(clk),
        .Req(Req),
        .reset(reset),
        .flush(flush),
        .ExcCode_F(ExcCode_F),
        .Raw_ExcCode_D(Raw_ExcCode_D),
        .instr_D(instr_D),
        .BD_F(BD_F),
        .PC_D(PC_D),
        .imm16_D(imm16_D),
        .regRA1_D(regRA1_D),
        .regRA2_D(regRA2_D),
        .regWA_D(regWA_D),
        .regWE_E(regWE_E),
        .npcMode(npcMode),
        .cmpMode(cmpMode),
        .instr_D_muldiv(instr_D_muldiv),
        .extMode(extMode),
        .RI_D(RI_D),
        .BD_D(BD_D),
        .ERET_D(ERET_D)
    );

    EXT extInstance (
        .imm(imm16_D),
        .mode(extMode),
        .res(extRes_D)
    );

    NPC npcInstance (
        .PC_F(i_inst_addr),
        .PC_D(PC_D),
        .mode(npcMode),
        .Req(Req),
        .cmpRes(cmpRes),
        .imm26_D(instr_D[25:0]),
        .regRD1_D(F_regA1Data_D),
        .EPC_M(EPC_M),
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
        .regWA(w_grf_addr),
        .regWD(regWD_W),
        .regWE(w_grf_we),
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
        .instr_D(instr_D),
        .Req(Req),
        .PC_D(PC_D),
        .BD_D(BD_D),
        .ExcCode_D(ExcCode_D),
        .Raw_ExcCode_E(Raw_ExcCode_E),
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
        .BD_E(BD_E),
        .PC_E(PC_E)
    );

    ALU aluInstance (
        .srcA(aluSrcA),
        .srcB(aluSrcB),
        .aluOp(aluMode),
        .instr(instr_E),
        .res(aluRes),
        .OV(OV_E),
        .ADEL(ADEL_E),
        .ADES(ADES_E)
    );

    MulDiv MDU (
        .instr(instr_E),
		.start(start),
        .Req(Req),
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
        .instr_E(instr_E),
        .PC_E(PC_E),
        .ExcCode_E(ExcCode_E),
        .Req(Req),
        .BD_E(BD_E),
        .Raw_ExcCode_M(Raw_ExcCode_M),
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
        .MUX_regWD_M(MUX_regWD_M),
        .BD_M(BD_M),
        .ERET_M(ERET_M),
        .CP0WE_M(CP0WE_M)
    );


    MEMFIX memfix (
        .memWE(memWE_M),
        .memMode(memMode),
        .memWD(F_regA2Data_M),
        .m_mem_rdata(m_mem_rdata),
        .addr(m_mem_addr[1:0]),
        .byteen(m_byteen),
        .m_mem_wdata(m_mem_wdata),
        .memRD(memRD_M)
    );


    CP0 CP0Reg (
        .clk(clk),
        .reset(reset),
        .WE(CP0WE_M),
        .CP0in(F_regA2Data_M), 
        .HWInt(HWInt),
        .PC(m_inst_addr),
        .BDIn(BD_M),
        .EXLClr(ERET_M),
        .ExcCodeIn(ExcCode_M),
        .regRA(regRA1_M),
        .regWA(regWA_M),
        .Req(Req),
        .CP0out(CP0out_M),
        .EPCout(EPC_M)
    );

    

    W WREG (
        .clk(clk),
        .reset(reset),
        .instr_M(instr_M),
        .PC_M(m_inst_addr),
        .memRD_M(memRD_M),
        .Req(Req),
        .CP0out_M(CP0out_M),
		.extRes_M(extRes_M),
        .aluRes_M(aluRes_M),
        .muldivRes_M(muldivRes_M),
        .F_regA1Data_M(regRD1_M),
        .F_regA2Data_M(F_regA2Data_M),
        .instr_W(instr_W),
        .PC_W(w_inst_addr),
        .memRD_W(memRD_W),
        .aluRes_W(aluRes_W),
        .CP0out_W(CP0out_W),
        .regRD1_W(regRD1_W),
        .regRD2_W(regRD2_W),
		.extRes_W(extRes_W),
        .muldivRes_W(muldivRes_W),
        .regWE_W(w_grf_we),
        .regWA_W(w_grf_addr),
        .MUX_regWD_W(MUX_regWD_W)
    );
    






endmodule
