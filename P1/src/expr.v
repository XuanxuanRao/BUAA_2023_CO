`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:16:23 10/11/2023 
// Design Name: 
// Module Name:    expr 
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
module expr(
    input clk,
    input clr,
    input [7:0] in,
    output out
    );

    reg [1:0] state;
    wire isDigit;
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

    assign isDigit = (in >= "0" && in <= "9");

    initial begin
        state <= S0;
    end

    always @ (posedge clk or posedge clr)   begin
        if(clr) begin
            state <= S0;
        end

        else    begin
            case (state)
                S0:
                    if(isDigit) state <= S1;
                    else        state <= S3;
                
                S1:
                    if(in == "+" || in == "*")  state <= S2;
                    else                        state <= S3;

                S2:
                    if(isDigit)                 state <= S1;
                    else                        state <= S3;
                
                S3:
                    state <= state;
                
                default:
                    state <= state; 
            endcase
        end
    end

    assign out = state == S1;


endmodule
