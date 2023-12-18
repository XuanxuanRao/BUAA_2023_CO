`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:42:38 11/10/2023 
// Design Name: 
// Module Name:    Tuse 
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

module Tuse(
    input [31:0] instr,
    output reg [2:0] Tuse_rs,
    output reg [2:0] Tuse_rt
    );
    
    `define NOTUSE 3'b111

    always @(*) begin
        case (instr[31:26])
            `R:  begin
                case (instr[5:0])
                    `ADD, `SUB, `OR, `AND, `MULT, `MULTU, `DIV, `DIVU, `SLT, `SLTU:  begin
                        Tuse_rs = 3'd1;     Tuse_rt = 3'd1;
                    end
                    `MTHI, `MTLO:           begin
                        Tuse_rs = 3'd1;     Tuse_rt = `NOTUSE;
                    end
                    `MFHI, `MFLO:           begin
                        Tuse_rs = `NOTUSE;  Tuse_rt = `NOTUSE;
                    end
                    `JR:                    begin
                        Tuse_rs = 3'd0;     Tuse_rt = `NOTUSE;
                    end
                    `SYSCALL:               begin
                        Tuse_rs = `NOTUSE;  Tuse_rt = `NOTUSE;
                    end
                    default:                begin
                        Tuse_rs = `NOTUSE;  Tuse_rt = `NOTUSE;
                    end
                endcase
            end
            `CP0:   begin
                if (instr[25:21] == `MFCP0)        begin
                    Tuse_rs = `NOTUSE;      Tuse_rt = `NOTUSE;
                end
                else if (instr[25:21] == `MTCP0)   begin
                    Tuse_rs = `NOTUSE;      Tuse_rt = 3'd2;
                end
                else if (instr[5:0] == 6'b011000)   begin
                    Tuse_rs = `NOTUSE;      Tuse_rt = `NOTUSE;
                end
                else                            begin
                    Tuse_rs = `NOTUSE;      Tuse_rt = `NOTUSE;
                end   
            end
            `ORI, `ANDI, `ADDI: begin
                Tuse_rs = 3'd1;     Tuse_rt = `NOTUSE;
            end
            `LUI:   begin
                Tuse_rs = `NOTUSE;  Tuse_rt = `NOTUSE;
            end
            `SW, `SH, `SB:      begin
                Tuse_rs = 3'd1;     Tuse_rt = 3'd2;
            end
            `LW, `LH, `LB:      begin
                Tuse_rs = 3'd1;     Tuse_rt = `NOTUSE;
            end
            `BEQ, `BNE:         begin
                Tuse_rs = 3'd0;     Tuse_rt = 3'd0;
            end
            `JAL:               begin
                Tuse_rs = `NOTUSE;  Tuse_rt = `NOTUSE;
            end
            default:            begin
                Tuse_rs = `NOTUSE;  Tuse_rt = `NOTUSE;
            end
        endcase     
    end


endmodule
