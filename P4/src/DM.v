`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:42:12 11/01/2023 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input [31:0] memAddr,
    input [31:0] memWD,
    input [31:0] PC,
    input memWE,
    input clk,
    input reset,
    input mode,
    output reg [31:0] memRD
    );


    parameter WORD = 1'b0, BYTE = 1'b1;
    reg [31:0] memory [3071:0];
    reg [31:0] tmp;
    integer i;

    initial begin
        for (i = 0; i < 3072; i = i + 1)    begin
            memory[i] <= 32'h00000000;
        end
    end

    always @(posedge clk) begin
        if(reset)   begin
            for (i = 0; i < 3072; i = i + 1) begin
                memory[i] <= 32'h00000000;
            end
        end

        else        begin
            if(memWE)   begin
                $display("@%h: *%h <= %h", PC, memAddr, memWD);
                if (mode == WORD)   
                    memory[memAddr[13:2]] <= memWD;
                else    begin
                    case (memAddr[1:0])
                        2'b00:      memory[memAddr[13:2]] <= {24'h000000, memWD[7:0]};
                        2'b01:      memory[memAddr[13:2]] <= {16'h0000, memWD[15:8], 8'h00};
                        2'b10:      memory[memAddr[13:2]] <= {8'h00, memWD[23:16], 16'h0000};
                        2'b11:      memory[memAddr[13:2]] <= {memWD[31:24], 24'h000000}; 
                        default:    memory[memAddr[13:2]] <= 32'h00000000;
                    endcase
                end
            end
        end
    end

    always @(*) begin
        if (mode == WORD)   
            memRD = memory[memAddr[13:2]];
        else    begin
            tmp = memory[memAddr[13:2]];
            case (memAddr[1:0])
                2'b00:      memRD = {{24{tmp[7]}}, tmp[7:0]};
                2'b01:      memRD = {{24{tmp[15]}}, tmp[15:8]};
                2'b10:      memRD = {{24{tmp[23]}}, tmp[23:16]};
                2'b11:      memRD = {{24{tmp[31]}}, tmp[31:24]};
                default:    memRD = 32'h00000000;
            endcase
        end
    end
    

endmodule
