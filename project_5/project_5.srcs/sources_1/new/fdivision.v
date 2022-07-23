module test(

    );
    reg [16:0] a;
    reg [16:0] b;
    reg [16:0] a_;  //a的带符号位原码
    reg [16:0] b_;  //b的带符号位原码
    reg s;
    wire[16:0] sum;
    wire v;
    initial
    begin
 #0  a=-16'h16;
     b=16'h1;
     s=0;
 #10 a=-16'h16;
     b=16'h2;
     s=1;
 #15 a=16'h52;
     b=16'h53;
     s=0;
 #20 a=16'hffff;
     b=16'h1;
     s=0;     
    end
    add ma(a,b,s,sum,v);
    
    
    always@(*)
    begin
    a_=a;
    b_=b;
    if(a_[16]==1)
       begin
       a_=~a_+1;
       a_[16]=1;
       end
    if(b_[16]==1)
       begin
       a_=~a_+1;
       a_[16]=1;
       end 
    end
    always@(sum)
    begin
    if(s==0)
       $display($time,,("%h+%h=%h   v=%h"),a_,b_,sum,v);
    else
       $display($time,,("%h-%h=%h   v=%h"),a_,b_,sum,v);
    end
endmodule