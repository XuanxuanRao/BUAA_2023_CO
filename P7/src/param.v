`timescale 1ns / 1ps

`define R   6'b000000
`define RA  5'b11111
`define HANDLER 32'h00004180


/********   ALU   ********/	 
`define ALUADD  3'd1
`define ALUSUB  3'd2
`define ALUOR	3'd3
`define ALUAND  3'd4
`define ALUSLT  3'd5
`define ALUSLTU 3'd6
/************************/	


/********   NPC   ********/
`define NPCNEXT   3'b000          
`define NPCBRANCH 3'b001
`define NPCJTYPE  3'b010
`define NPCJREG   3'b011
`define NPCEPC    3'b100
/*************************/


/********   MEM  *********/
`define MEMWORD   2'd0
`define MEMHALF   2'd1
`define MEMBYTE   2'd2
/*************************/


/********   EXT   ********/
`define EXTZERO 2'b00
`define EXTSIGN 2'b01
`define EXTLUI  2'b10
/*************************/


/********   CMP   ********/	 
`define CMPEQ      2'd0
`define CMPNEQ     2'd1
/************************/	


/***************   INSTR   ***************/	 
`define ADD     6'b100000   // funct
`define SUB     6'b100010   // funct
`define AND     6'b100100   // funct
`define OR      6'b100101   // funct
`define SLT     6'b101010   // funct
`define SLTU    6'b101011   // funct
`define LUI     6'b001111   // opcode

`define ORI     6'b001101   // opcode
`define ANDI    6'b001100   // opcode
`define ADDI    6'b001000   // opcode

`define LW      6'b100011   // opcode
`define SW      6'b101011   // opcode
`define LH      6'b100001   // opcode
`define SH      6'b101001   // opcode
`define LB      6'b100000   // opcode
`define SB      6'b101000   // opcode

`define BEQ     6'b000100   // opcode
`define BNE     6'b000101   // opcode
`define JAL     6'b000011   // opcode
`define JR      6'b001000   // funct

`define MTHI    6'b010001   // funct
`define MTLO    6'b010011   // funct
`define MULT    6'b011000   // funct
`define MULTU   6'b011001   // funct
`define DIV     6'b011010   // funct
`define DIVU    6'b011011   // funct     
`define MFHI    6'b010000   // funct
`define MFLO    6'b010010   // funct    

`define SYSCALL 6'b001100   // funct
`define CP0     6'b010000   // opcode
`define MFCP0   5'b00000
`define MTCP0   5'b00100
/*****************************************/	


/******   ExcCode   ******/
`define Int     5'd0
`define AdEL    5'd4
`define AdES    5'd5
`define Syscall 5'd8
`define RI      5'd10
`define Ov      5'd12
`define NONE    5'd31
/*************************/


/**********   MEMADDR   ***********/
`define DMBEGIN     32'h00000000
`define DMEND       32'h00002fff
`define TC0BEGIN    32'h00007f00
`define TC0END      32'h00007f0b
`define TC1BEGIN    32'h00007f10
`define TC1END      32'h00007f1b
`define IGBEGIN     32'h00007f20
`define IGEND       32'h00007f23
/**********************************/	
