`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:06:43 11/09/2023 
// Design Name: 
// Module Name:    param 
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


/********   ALU   ********/	 
`define ALUADD  3'b001
`define ALUSUB  3'b010
`define ALUOR	3'b011
/************************/	


/********   NPC   ********/
`define NPCNEXT 3'b000          
`define NPCBRANCH 3'b001
`define NPCJTYPE  3'b010
`define NPCJREG 3'b011
/*************************/

/********   EXT   ********/
`define EXTZERO 2'b00
`define EXTSIGN 2'b01
`define EXTLUI  2'b10
/*************************/



/********   CMP   ********/	 
`define CMPBEQ  1'b0
/************************/	

/********   INSTR   ********/	 
`define ADD   6'b100000     // funct
`define SUB   6'b100010     // funct
`define ORI   6'b001101     // opcode
`define LUI   6'b001111     // opcode
`define LW    6'b100011     // opcode
`define SW    6'b101011     // opcode
`define BEQ   6'b000100     // opcode
`define JAL   6'b000011     // opcode
`define JR    6'b001000     // funct
/***************************/	




`define RA 5'b11111



