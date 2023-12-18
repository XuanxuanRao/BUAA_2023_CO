`timescale 1ns / 1ps
`include "param.v"

`define IM  SR[15:10]       // Interrupt Mask    1->AllowInterrupt
`define EXL SR[1]           // Exception Level   
`define IE  SR[0]           // Interrupt Enable
`define BD  Cause[31]
`define IP  Cause[15:10]    // Interrupt Pending
`define ExcCode Cause[6:2]


module CP0(
    input clk,
    input reset,
    input WE,               // MTC0_M
    input [31:0] CP0in,     // write to CP0
    input [5:0] HWInt,      // interrupt signal from IG and TC
    input [31:0] PC,        // 
    input BDIn,             // instruction associated with branch delay slot
    input EXLClr,           // reset EXL to 0  (ERET_M)
    input [4:0] ExcCodeIn,  // exception code    
    input [4:0] regRA,      // 
    input [4:0] regWA,      // 
    output Req,             // request to enter Exception Handler
    output [31:0] CP0out,   // data read from CP0
    output [31:0] EPCout    
    );

    reg [31:0] SR, Cause, EPC, PRId;
    wire [31:0] EPCtmp;


    initial begin
        SR <= 0;    Cause <= 0;     EPC <= 0;
        PRId <= 32'h2237_3053;
    end


    wire IntReq = (|(HWInt & `IM)) && !`EXL && `IE;  
    wire ExcReq = (ExcCodeIn != `NONE && ExcCodeIn != `Int) && !`EXL;
    assign Req = IntReq || ExcReq;

    assign CP0out = regRA==5'd12 ? SR : regRA==5'd13 ? Cause : regRA==5'd14 ? EPC : regRA==5'd15 ? PRId : 0;
    assign EPCout = EPC;

    assign EPCtmp = Req ? (BDIn ? PC - 4 : PC) : EPC; 

    always @(posedge clk or posedge reset) begin
        if (reset)  begin
            SR <= 0;    Cause <= 0;     EPC <= 0;
            PRId <= 32'h2237_3053;
        end

        else        begin
            `IP <= HWInt;   
            if (EXLClr)     `EXL <= 0;
            if (Req)        begin
                `ExcCode <= IntReq ? 0 : ExcCodeIn;     // the priority of interrupt is higher than exception
                `EXL     <= 1;
                EPC      <= EPCtmp;
                `BD      <= BDIn; 
            end
            else if (WE)    begin
                if (regWA == 12)        SR  <= CP0in;
                else if (regWA == 14)   EPC <= CP0in;
            end
        end
    end

endmodule
