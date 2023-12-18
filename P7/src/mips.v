`timescale 1ns / 1ps
`include "param.v"



module mips(
    input clk,                      
    input reset,                    // Synchronous Reset
    input interrupt,                // interrupt signal from InterruptGenerator
    output [31:0] macroscopic_pc,   // 
    output [31:0] i_inst_addr,      // PC_F
    input [31:0] i_inst_rdata,      // instr_F
    output [31:0] m_data_addr,      // memAddr_M
    input [31:0] m_data_rdata,      // Raw_data_rdata
    output [31:0] m_data_wdata,     // Fixed_memWD_M
    output [3:0] m_data_byteen,     // memMode_M
    output [31:0] m_int_addr,       // 
    output [3:0] m_int_byteen,      // 
    output [31:0] m_inst_addr,
    output w_grf_we,
    output [4:0] w_grf_addr,
    output [31:0] w_grf_wdata,
    output [31:0] w_inst_addr
    );

    assign m_data_wdata = CPU_m_mem_wdata;

    wire [5:0] HWInt = {3'b000, interrupt, IRQ1, IRQ0}; 

    wire [31:0] CPU_m_mem_rdata, CPU_m_mem_addr, CPU_m_mem_wdata;
    wire [3:0] CPU_m_mem_byteen;
    wire [31:0] DMout, TC0out, TC1out;
    wire [3:0] DMbyteen, IGbyteen;

    CPU cpu (
        .clk(clk),
        .reset(reset),
        .HWInt(HWInt),
        .i_inst_rdata(i_inst_rdata),
        .m_mem_rdata(CPU_m_mem_rdata),      
        .i_inst_addr(i_inst_addr),
        .m_mem_addr(CPU_m_mem_addr),
        .m_mem_wdata(CPU_m_mem_wdata),
        .m_mem_byteen(CPU_m_mem_byteen),
        .m_inst_addr(m_inst_addr),
        .w_grf_we(w_grf_we),
        .w_grf_addr(w_grf_addr),
        .w_grf_wdata(w_grf_wdata),
        .w_inst_addr(w_inst_addr),
        .macroscopic_pc(macroscopic_pc)
    );



    Bridge bridge (
        .m_mem_addr(CPU_m_mem_addr),        // from output: CPU_m_mem_addr@CPU        
        .m_mem_byteen(CPU_m_mem_byteen),    // from output: CPU_m_mem_byteen@CPU
        .DMout(m_data_rdata),               // from output: (Raw)m_data_rdata@mips
        .TC0out(TC0out),                    // from output: Dout@TC0
        .TC1out(TC1out),                    // from output: Dout@TC1
        .m_data_addr(m_data_addr),          // to input:    m_data_addr(DM)
        .m_int_addr(m_int_addr),            // to input:    m_int_addr(IG)
        .DMbyteen(m_data_byteen),           // to input:    m_data_byteen@mips(DM)  
        .IGbyteen(m_int_byteen),            // to input:    m_int_byteen@mips(IG)           
        .TC0WE(TC0WE),                      // to input:    WE@TC0
        .TC1WE(TC1WE),                      // to input:    WE@TC1
        .m_mem_rdata(CPU_m_mem_rdata)       // to input:    m_mem_rdata@CPU   
    );


    TC TC0 (
        .clk(clk),
        .reset(reset),
        .Addr(CPU_m_mem_addr[31:2]),        // from output: CPU_m_mem_addr@CPU
        .WE(TC0WE),
        .Din(CPU_m_mem_wdata),
        .Dout(TC0out),
        .IRQ(IRQ0)                          // to input: HWInt@CPU
    );

    TC TC1 (
        .clk(clk),
        .reset(reset),
        .Addr(CPU_m_mem_addr[31:2]),        // from output: CPU_m_mem_addr@CPU
        .WE(TC1WE),
        .Din(CPU_m_mem_wdata),
        .Dout(TC1out),
        .IRQ(IRQ1)                          // to input: HWInt@CPU
    );



endmodule
