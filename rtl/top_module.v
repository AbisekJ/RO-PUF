`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2025 05:18:26 PM
// Design Name: 
// Module Name: top_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_module(input clk, rst, en, input [1:0]sel);

    wire ro1, ro2;
    reg [31:0] cnta, cntb,cntc;
    reg full = 1'b0;
    reg [31:0] out;
    ring r1(en, sel, ro1);
    ring r2(en, sel, ro2);
    reg flag;
    always @(posedge ro1 or posedge rst) begin
    if(rst) cnta <= 32'd0;
    else begin
    if (cntc > 32'd32000) begin 
    cnta <= 32'd0;
   // done <= 1;
    end
     else cnta <= cnta+1;
    end
    end
    
    always @(posedge ro2 or posedge rst) begin
    if(rst) cntb <= 32'd0;
    else begin 
    if (cntc > 32'd32000) cntb <= 32'd0;
    else cntb <= cntb+1;
    end
    end
    
    always @(posedge clk or posedge rst) begin
    if(rst)begin
    cntc<=0;
    flag<=0;
    end
    else if ((cntc == 32'd32000) && (flag==0) )begin
    out <= cnta-cntb;
    flag<=1;
    end
    else if (cntc < 32'hffffffff) cntc <= cntc+1; 
    else cntc <=32'hffffffff;  
    end
    
    ila_0 dut(.clk(clk), .probe0(ro1), .probe1(ro2), .probe2(cnta),.probe3(cntb),.probe5(cntc) ,.probe4(out));
endmodule
