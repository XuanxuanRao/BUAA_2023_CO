`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:53:27 11/02/2023 
// Design Name: 
// Module Name:    IM 
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
module IM(
    input [13:2] addr,
    output [31:0] instr
    );

    reg [31:0] instructions [0:4095];

    initial begin
        $readmemh("code.txt", instructions);
    end

    assign instr = instructions[addr];

endmodule
