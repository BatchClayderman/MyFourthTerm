`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2021 08:19:41 PM
// Design Name: 
// Module Name: add_x4
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


module add_x4(
    input signed [4:0] A,//���Ӽ���
    input signed [4:0] X,//�Ӽ���
    input sel,//ѡ��Ӽ�����0�Ǽӷ���1�Ǽ�����
    output signed [4:0] C,
    output reg V//������
    );
    wire [4:0] tmp = (sel ? ~X[4:0] + 1'b1 : X);
    assign C = (sel ? A - X : A + X);//��ֵ��û�д���ɲ���
    always@(A or X)
    begin
    if (A[4] == tmp[4] && A[4] == C[4])
        V = 0;//�����һλ��ӵĽ�λֵ������ڶ�λ��ӵĽ�λֵ���бȽ�,��ͬ�����
    else
        V = 1;
    end  
endmodule