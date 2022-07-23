assume cs:codesg

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
	start:	mov ax, data
			mov ds, ax
			mov ax, table
			mov es, ax
			mov ax, stack
			mov ss, ax
			mov sp, 16
			mov si, 0
			mov bx, 0
			mov di, 0
			mov cx, 21
 
		s:	mov dx, ds:[di+0];处理年份
			mov es:[bx+0], dx
			mov dx, [di+2]
			mov es:[bx+2], dx
 
			mov dx, [di+84];处理收入
			mov es:[bx+5], dx
			mov dx, [di+86]
			mov es:[bx+7], dx
 
			mov dx, [si+168];处理雇员
			mov es:[bx+10], dx
			 
			mov ax, es:[bx+5];处理人均收入
			mov dx, es:[bx+7]
			push bx
			mov bx, es:[bx+10]
			div bx
			pop bx
			mov es:[bx+13], ax
 
			add bx, 16
			add di, 4
			add si, 2
 
			loop s
			mov ax, 4c00H
			int 21H
codesg ends
end start