`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/05 21:21:12
// Design Name: 
// Module Name: newram
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


module newram(
    input [5:0] maddr,
    input [31:0] mwdata,
    input clk,
    input we,
    input [2:0] mm,
    output [31:0] mdata
    );
    wire [31:0] tmp, tmp_b, tmp_h, tmp_bu, tmp_hu, tmp_in;
    wire lb, lh, lw, lbu, lhu, sb, sh, sw;
    ram myram(.maddr(maddr),.mwdata(mwdata),.clk(clk),.we(we),.mdata(tmp));
    assign lb=~(|mm);
    assign lh=~(|mm [2:1])&mm[0];
    assign lw=~mm[2]&mm [1]&~ mm[0];
    assign lbu=~mm [2]&(& mm [1:0]);
    assign lhu=mm [2]&~(| mm [1:0]);
    assign sb=mm [2]&~ mm[1]&mm[0];
    assign sh=(&mm [2:1]) &~mm[0];
    assign    sw=&mm;
    assign tmp_b ={{24{ tmp [7]}} , tmp [7:0]};
    assign tmp_h ={{16{ tmp [15]}} , tmp [15:0]};
    assign tmp_bu ={24'b0 ,tmp [7:0]};
    assign tmp_hu ={16'b0 ,tmp [15:0]};
    assign mdata ={32{ lb}}& tmp_b|
        {32{lh}}& tmp_h|
        {32{lw}}& tmp|
        {32{ lbu }}& tmp_bu|
        {32{ lhu }}& tmp_hu;
    assign tmp_in =({24 'b0 ,{8{sb}}}|{16 'b0 ,{16{ sh }}}|{32{ sw}})&mwdata;
    initial
    begin
    $monitor($time,,"lb=%b,lh=%b,lw=%b,lbu=%b,lhu=%b",lb ,lh ,lw,lbu ,lhu);
    $monitor($time,,"maddr =%h",maddr);
    $monitor($time,,"tmp=%h",tmp);
    $monitor($time,,"mdata [31:28]=%h",mdata [31:28]);
    $monitor($time,,"mdata [15:12]=%h",mdata [15:12]);
    $monitor($time,,"mdata [7:4]=%h",mdata [7:4]);
    end
endmodule
