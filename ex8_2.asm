assume cs:codesg;可以用assume cs:codesg, ds:data, ss:stack, es:table来助记

data segment
	db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
	db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
	db '1993','1994','1995'		 
	;以上表示21年的21个字符串
	
	dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
	dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000		
	;以上是表示21年公司总收入的21个dword型数据
	
	dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
	dw 11542,14430,14257,17800	 
	;以上表示是21年公司雇员人数的21个word型数据
 
data ends
 
table segment
	db 21 dup('year summ ne ?? ')
table ends
 
stack segment
	db 16 dup(0)
stack ends

codesg segment

start:  mov ax, data; ds 指向 data 段
        mov ds, ax
        mov ax, table; es 指向 table 段
        mov es, ax
        mov ax, stack; ss 指向栈段
        mov ss, ax
        mov sp, 10H

        mov bx, 0; bx 指向 data 中的年份
        mov di, 84; di 指向data中的总收入
        mov bp, 168; b p指向 data 中的人数
        mov si, 0; si 表示 table 中的偏移量

        mov cx, 21;外循环
    s0: push cx
        mov cx, 2
        push di
        push bp; bp 指向 si
        mov bp, si; di 作内层循环的偏移
        mov di, 0

    s1: mov ax, [bx+di];处理年份
        mov es:[bp+di], ax
        add di, 2
        loop s1

        add bx, 4

        pop bp
        pop di
        mov cx, 2
        push bx
        push bp
        push si
        mov bx, di
        mov bp, si
        add bp, 5
        mov si, 0

    s2: mov ax, [bx+si];处理收入
        mov es:[bp+si], ax
        add si, 2
        loop s2

        pop si
        pop bp
        
        mov bx, si;写入总人数
        add bx, 10
        mov ax, ds:[bp]
        mov es:[bx], ax
        

        mov ax, ds:[di];处理人均收入
        add di, 2
        mov dx, ds:[di]
        div word ptr ds:[bp]
        mov bx, si
        add bx, 13
        mov es:[bx], ax
        pop bx

        add di, 2
        add bp, 2;双字
        add si, 16
        pop cx
        loop s0

        mov ax, 4c00H
        int 21H
    
codesg ends
end start
