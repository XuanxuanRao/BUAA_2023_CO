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

    `define R 6'b000000
    `define NOTUSE 3'b111

    always @(*) begin
        case (instr[31:26])
            `R:  begin
                if (instr[5:0] == `ADD)      begin
                    Tuse_rs = 3'd1;
                    Tuse_rt = 3'd1;
                end
                else if (instr[5:0] == `SUB) begin
                    Tuse_rs = 3'd1;
                    Tuse_rt = 3'd1;
                end
                else if (instr[5:0] == `JR)  begin
                    Tuse_rs = 3'd0;
                    Tuse_rt = `NOTUSE;
                end
                else                         begin
                    Tuse_rs = `NOTUSE;
                    Tuse_rt = `NOTUSE;
                end    
            end
            `ORI:   begin
                Tuse_rs = 3'd1;
                Tuse_rt = `NOTUSE;
            end
            `LUI:   begin
                Tuse_rs = `NOTUSE;
                Tuse_rt = `NOTUSE;
            end
            `SW:    begin
                Tuse_rs = 3'd1;
                Tuse_rt = 3'd2;
            end
            `LW:    begin
                Tuse_rs = 3'd1;
                Tuse_rt = `NOTUSE;
            end
            `BEQ:   begin
                Tuse_rs = 3'd0;
                Tuse_rt = 3'd0;
            end
            `JAL:   begin
                Tuse_rs = `NOTUSE;
                Tuse_rt = `NOTUSE;
            end
            default:begin
                Tuse_rs = `NOTUSE;
                Tuse_rt = `NOTUSE;
            end
        endcase     
    end


endmodule
