`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:15:43 10/12/2023 
// Design Name: 
// Module Name:    BlockChecker 
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
module BlockChecker(
    input clk,
    input reset,
    input [7:0] in,
    output result
    );

    reg [2:0] state;
    reg [15:0] cnt;
    reg [2:0] isBegin;
    reg [1:0] isEnd;

    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101;

    always @ (posedge clk or posedge reset) begin
        if(reset)   begin
            state   <= S0;
            cnt     <= 16'h0000;
            isBegin <= 3'b000;
            isEnd   <= 2'b00;
        end

        else    begin
            case (state)
                S0: begin
                    isBegin <= 3'b000;
                    isEnd   <= 2'b00;
                    if(in == "b" || in == "B")          begin   state <= S1;    isBegin <= 3'b001;  end
                    else if(in == "e" || in == "E")     begin   state <= S2;    isEnd <= 2'b01;     end
                    else if(in == " ")                  state <= state;
                    else                                state <= S3;
                end 

                S1: begin
                    if(in == "e" || in == "E")          begin
                        if(isBegin == 3'b001)           begin   state <= state; isBegin <= 3'b010;  end
                        else                            state <= S3; 
                    end
                    else if(in == "g" || in == "G")     begin
                        if(isBegin == 3'b010)           begin   state <= state; isBegin <= 3'b011;  end
                        else                            state <= S3;
                    end
                    else if(in == "i" || in == "I")     begin
                        if(isBegin == 3'b011)           begin   state <= state; isBegin <= 3'b100;  end
                        else                            state <= S3;
                    end
                    else if(in == "n" || in == "N")     begin
                        if(isBegin == 3'b100)           begin   state <= state; isBegin <= 3'b101;  end
                        else                            state <= S3;  
                    end
                    else if(in == " ")                  begin
                        if(isBegin == 3'b101)           cnt <= cnt + 1;
                        state <= S0;
                    end
                    else                                state <= S3;
                end

                S2: begin
                    if(in == "n" || in == "N")          begin
                        if(isEnd == 2'b01)              begin   state <= state; isEnd <= 2'b10;     end
                        else                            state <= S3;
                    end 
                    else if(in == "d" || in == "D")     begin
                        if(isEnd == 2'b10)              begin   state <= S4;    isEnd <= 2'b11;     end
                        else                            state <= S3;         
                    end
                    else if(in == " ")                  state <= S0; 
                    else                                state <= S3; 
                end

                S3: begin
                    isBegin <= 3'b000;
                    isEnd   <= 2'b00;
                    if(in == " ")   state <= S0;
                    else            state <= state;
                end

                S4: begin
                    if(in == " ")                       begin
                        if(cnt == 16'h0000)         state <= S5;
                        else                        state <= S0;
                        cnt <= cnt - 1;  
                    end
                    else                            state <= S3;
                end

                // no begin to match this end, keep result as 0
                S5:     state <= state;

                default:    state <= state; 
            endcase
        end
    end

    assign result = (state == S4) ? (cnt == 16'h0001 ? 1 : 0) 
                    :(state != S5) && (cnt == 16'h0000) && (state == S1 ? isBegin != 3'b101 : 1);

endmodule