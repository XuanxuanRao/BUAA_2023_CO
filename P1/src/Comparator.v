`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:20:46 10/16/2023 
// Design Name: 
// Module Name:    Comparator 
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
module Comparator(
    input [7:0] A,
    input [7:0] B,
    output reg result
    );
	
	
	always @ (*)	begin: exist_frame
		integer i;
		if(A[7] ^ B[7])
			result = A[7] ? 1'b0 : 1'b1;
			
		else	begin
			result = 1'b0;
			for(i = 6; i >= 0; i = i - 1)	begin
				if(A[i] ^ B[i])	result = A[i];
			end
		end

	 end

endmodule
