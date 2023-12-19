`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:04:44 11/02/2023 
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
module mips(
    input clk,
    input reset
    );
	 
	parameter RA = 5'b11111;
	
//////////////////////////////////////////////////////////////////////////////////
	/*		IFU		*/
	wire [31:0] instr;		
	wire [31:0] PC;
	wire [31:0] NPC;
	wire [31:0] PC4;
	wire [1:0] npcMode;
	wire [31:0] instrAddr;
	assign instrAddr = PC - 32'h00003000;

	/*		CMP		*/
	wire [1:0] cmpOp;
	wire cmpRes;
	assign cmpOp = 2'b00;

	/*		GRF		*/
	wire [1:0] regWAMux;			// MUX, 0-rt / 1-rd / 2-$ra
	wire [1:0] regWDMux;			// MUX, 0-aluRes / 1-memRD / 2-PC4
	wire [4:0] regWA;		
	wire [31:0] reg1Value;
	wire [31:0] reg2Value;
	wire [31:0] regWD;
	assign regWA = regWAMux == 2'b01 ? instr[15:11] : regWAMux == 2'b10 ? RA : instr[20:16];
	assign regWD = regWDMux == 2'b01 ? memRD : regWDMux == 2'b10 ? PC4 : aluRes;

	/*		ALU		 */
	wire aluSrcMux;			// MUX, 0-reg2Value / 1-imm as srcB
	wire [31:0] srcA;
	wire [31:0] srcB;
	wire [2:0] aluOp;
	wire [31:0] aluRes;
	assign srcA = reg1Value;
	assign srcB = aluSrcMux ? ext_imm : reg2Value;

	/*		DM		*/
	wire [31:0] memAddr;
	wire [31:0] memWD;
	wire [31:0] memRD;
	wire memMode;
	assign memAddr = aluRes;
	assign memWD = reg2Value;

	/*		EXT		*/
	wire extMode;
	wire [31:0]	ext_imm;
//////////////////////////////////////////////////////////////////////////////////

	PC pcInstance (
		.PC_next(NPC),
		.clk(clk),
		.reset(reset),
		.PC(PC)
	);

	IM imInstance (
		.addr(instrAddr[13:2]),
		.instr(instr)
	);

	GRF grfInstance (
		.regA1(instr[25:21]),
		.regA2(instr[20:16]),
		.regWA(regWA),
		.clk(clk),
		.reset(reset),
		.PC(PC),
		.regWE(regWE),
		.regRD1(reg1Value),
		.regRD2(reg2Value),
		.regWD(regWD)
	);
	 
	ALU aluInstance (
		.srcA(srcA),
		.srcB(srcB),
		.shamt(instr[10:6]),
		.aluOp(aluOp),
		.aluRes(aluRes)
	);
	
	DM dmInstance (
		.memAddr(memAddr),
		.memWD(memWD),
		.memWE(memWE),
		.PC(PC),
		.clk(clk),
		.reset(reset),
		.mode(memMode),
		.memRD(memRD)
	);

	Controller cuInstance (
		.opCode(instr[31:26]),
		.funct(instr[5:0]),
		.aluOp(aluOp),
		.regWE(regWE),
		.memWE(memWE),
		.memMode(memMode),
		.aluSrcMux(aluSrcMux),
		.extMode(extMode),
		.regWAMux(regWAMux),
		.regWDMux(regWDMux),
		.npcMode(npcMode)
	);
	
	CMP cmpInstance (
		.num1(reg1Value),
		.num2(reg2Value),
		.cmpOp(cmpOp),
		.cmpRes(cmpRes)
	);

	NPC npcInstance (
		.PC(PC),
		.imm26(instr[25:0]),
		.zero(cmpRes),
		.mode(npcMode),
		.regValue(reg1Value),
		.PC4(PC4),
		.PC_next(NPC)
	);

	EXT extInstance (
		.imm(instr[15:0]),
		.extMode(extMode),
		.ext_imm(ext_imm)
	);


endmodule
