module add(
   input[16:0] a,
   input[16:0] b,
   input s,  //0Ϊ������1Ϊ�ӷ�
   output reg[16:0] sum,
   output reg v  //������
    );
    reg[16:0] b1;  //����ʱ����¼-b�Ĳ���
    always@(*)
    begin
    if(s==1)
       begin
       b1=~b;
       b1=b1+1;
       end
    else
       b1=b;
    sum=a+b1;
    v=sum[16];
    if(sum[16]==1)
       begin
       sum=~sum+1;
       sum[16]=1;
       end
    if(a[16]==b1[16]&a[16]!=sum[16])
       v=1;
    else
       v=0; 
    end
endmodule