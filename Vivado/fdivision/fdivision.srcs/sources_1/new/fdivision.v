module fdivision(
        input reset,
        input f10m,
        output reg f500k
    );
    reg [2:0] j;//ÆµÂÊ
    always @(posedge f10m)//ÉÏÉıÑØ´¥·¢
        if (!reset)
            begin
                f500k <= 0;
                j <= 0;
            end
        else
            begin
                if (&j == 1)
                    begin
                        j <= 0;
                        f500k <= ~f500k;
                    end
                else
                    j <= j + 1;
            end
endmodule