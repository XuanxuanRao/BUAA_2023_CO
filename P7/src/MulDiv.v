`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:02:26 11/22/2023 
// Design Name: 
// Module Name:    MulDiv 
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

module MulDiv(
    input [31:0] instr,
    input start,
    input Req,
    input [31:0] srcA,
    input [31:0] srcB,
    input clk,
    input reset,
    output busy,
    output [31:0] muldivRes
    );

    reg [3:0] cycle;
    reg [31:0] LO, HI;
    reg [63:0] tmp;

    initial begin
        HI    <= 32'h00000000;
        LO    <= 32'h00000000;
        cycle <= 4'd0;
    end

    wire [5:0] opcode = instr[31:26];
    wire [5:0] funct = instr[5:0];

    assign muldivRes = (instr[31:26] == `R && instr[5:0] == `MFHI) ? HI : (instr[31:26] == `R && instr[5:0] == `MFLO) ? LO : 32'h00000000;

    always @(posedge clk)   begin
        if (reset)  begin
            HI    <= 32'h00000000;
            LO    <= 32'h00000000;
            cycle <= 4'd0;
        end

        else if (!Req)      begin
            if (cycle == 4'd0)          begin
                if (opcode == `R && funct == `MTHI)             begin
                    HI <= srcA;
                    cycle <= 4'd0;
                end
                else if (opcode == `R && funct == `MTLO)        begin
                    LO <= srcA;
                    cycle <= 4'd0;
                end
                else if (start)             begin
                    if (opcode == `R && funct == `MULTU)         begin
                        cycle <= 4'd5;
                        tmp <= srcA * srcB;
                    end
                    else if (opcode == `R && funct == `MULT)   begin
                        cycle <= 4'd5;
                        tmp   <= ($signed(srcA)) * ($signed(srcB));
                    end
                    else if (opcode == `R && funct == `DIVU)     begin
                        cycle <= 4'd10;
                        tmp   <= {srcA % srcB, srcA / srcB};
                    end
                    else if (opcode == `R && funct == `DIV)    begin
                        cycle <= 4'd10;
                        tmp   <= {($signed(srcA)) % ($signed(srcB)), ($signed(srcA)) / ($signed(srcB))};
                    end
                end
            end
            
            else if (cycle == 4'd1)     begin
                cycle <= 4'd0;
                HI <= tmp[63:32];
                LO <= tmp[31:0];
            end

            else                        begin
                cycle <= cycle - 4'd1;
            end
                 
        end
    end

    assign busy = cycle != 4'd0;


endmodule
