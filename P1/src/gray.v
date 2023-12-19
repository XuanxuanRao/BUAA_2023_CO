`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:54:45 10/12/2023 
// Design Name: 
// Module Name:    gray 
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
module gray(
    input Clk,
    input Reset,
    input En,
    output [2:0] Output,
    output Overflow
    );

    reg [3:0] state;
    reg flow;


    initial begin
        state <= 4'b0000;
        flow <= 0;
    end

    always @(posedge Clk) begin
        if(Reset)   begin
            state <= 3'b000;
            flow  <= 0;
        end

        else if(En)        begin
            case (state)
                3'b000:     state <= 3'b0001;
                3'b001:     state <= 3'b0011;
                3'b011:     state <= 3'b0010;
                3'b010:     state <= 3'b0110;
                3'b110:     state <= 3'b0111;
                3'b111:     state <= 3'b0101;
                3'b101:     state <= 3'b0100;
                3'b100:	begin     
						state <= 3'b1000;   flow <= 1;
					 end
                default:    state <= state;
            endcase
        end
    end

    assign Output = state;
    assign Overflow = flow;

endmodule
