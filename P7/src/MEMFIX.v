`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:31:40 11/24/2023 
// Design Name: 
// Module Name:    DM_bridge 
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

module MEMFIX(
    input memWE,
    input [1:0] memMode,
    input [1:0] addr,
    input [31:0] m_mem_rdata,
    input [31:0] memWD,
    output reg [31:0] memRD,
    output reg [3:0] byteen,
    output reg [31:0] m_mem_wdata
    );

    always @(*) begin
        if (memWE)      begin
            case (memMode)
                `MEMWORD:   begin
                    m_mem_wdata = memWD;
                    byteen = 4'b1111;
                end
                `MEMHALF:   begin
                    m_mem_wdata = {2{memWD[15:0]}};
                    byteen = addr[1] ? 4'b1100 : 4'b0011;
                end            
                `MEMBYTE:   begin
                    m_mem_wdata = {4{memWD[7:0]}};
                    byteen = addr == 2'b11 ? 4'b1000 : addr == 2'b10 ? 4'b0100 : addr == 2'b01 ? 4'b0010 : 4'b0001;   
                end
            endcase
        end

        else        byteen = 4'b0000;
    end

    always @(*) begin
        case (memMode)
            `MEMWORD:   memRD =  m_mem_rdata;
            `MEMHALF:   begin
                if (addr[1])    memRD = {{16{m_mem_rdata[31]}}, m_mem_rdata[31:16]};
                else            memRD = {{16{m_mem_rdata[15]}}, m_mem_rdata[15:0]};
            end
            `MEMBYTE:   begin
                if (addr == 2'b00)      memRD = {{24{m_mem_rdata[7]}}, m_mem_rdata[7:0]};
                else if (addr == 2'b01) memRD = {{24{m_mem_rdata[15]}}, m_mem_rdata[15:8]};
                else if (addr == 2'b10) memRD = {{24{m_mem_rdata[23]}}, m_mem_rdata[23:16]};
                else                    memRD = {{24{m_mem_rdata[31]}}, m_mem_rdata[31:24]};
            end
            default:                    memRD = 32'h00000000;
        endcase
    end


endmodule
