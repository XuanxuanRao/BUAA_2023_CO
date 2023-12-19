`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:18:36 11/02/2023
// Design Name:   mips
// Module Name:   D:/CO/Project/P4/SingleCycleProcessor/mips_tb.v
// Project Name:  SingleCycleProcessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mips
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mips_tb;

	// Inputs
	reg clk;
	reg reset;

	// Instantiate the Unit Under Test (UUT)
	mips uut (
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		reset = 1;
		clk = 1;
		# 10
		reset = 0;
	end
      
	always #5 clk = ~clk;
endmodule

