`timescale 1ns / 1ps
`include "param.v"

module Bridge(
    input [31:0] m_mem_addr,    // from output: m_mem_addr@CPU
    input [3:0] m_mem_byteen,   // from output: m_mem_byteen@CPU
    input [31:0] DMout,         // from output: Dout@DM(tb)  
    input [31:0] TC0out,        // from output: Dout@TC(mips)  
    input [31:0] TC1out,        // from output: Dout@TC(mips)
    output [31:0] m_data_addr,  // to input: addr@DM(tb)
    output [31:0] m_int_addr,   // to input: addr@IG(tb)    
    output [3:0] DMbyteen,      // to input: byteen@DM(tb)
    output [3:0] IGbyteen,      // to input: byteen@IG(tb)
    output TC0WE,               // to input: WE@TC(mips)
    output TC1WE,               // to input: WE@TC(mips)
    output [31:0] m_mem_rdata   // to input: m_mem_rdata@CPU    data read from memory                
    );


    assign m_data_addr = m_mem_addr;
    assign m_int_addr  = m_mem_addr;

    assign IGbyteen = (m_mem_addr >= `IGBEGIN && m_mem_addr <= `IGEND) ? m_mem_byteen : 4'b0000;
    assign DMbyteen = (m_mem_addr >= `DMBEGIN && m_mem_addr <= `DMEND) ? m_mem_byteen : 4'b0000;
    assign TC0WE = (m_mem_addr >= `TC0BEGIN && m_mem_addr <= `TC0END) && (|m_mem_byteen);
    assign TC1WE = (m_mem_addr >= `TC1BEGIN && m_mem_addr <= `TC1END) && (|m_mem_byteen);
    
    // Interrupt Generator does not have memory, so the data read from it should be 32'd0
    assign m_mem_rdata =    (m_mem_addr >= `DMBEGIN && m_mem_addr <= `DMEND) ? DMout : 
                            (m_mem_addr >= `TC0BEGIN && m_mem_addr <= `TC0END) ? TC0out :
                            (m_mem_addr >= `TC1BEGIN && m_mem_addr <= `TC1END) ? TC1out : 32'd0;


endmodule
