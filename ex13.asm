assume cs:code
code segment

start:	mov ax, cs
		mov ds, ax
		mov si, offset print_start		;设置ds:si指向源地址
		mov ax, 0
		mov es, ax
		mov di, 200h					;设置es:di指向目的地址
			
		mov cx, offset print_end - offset print_start	
		cld								;设置正向传输
		rep movsb
		
		mov ax, 0						;设置中断向量表的表项
		mov es, ax							
		mov word ptr es:[7ch * 4], 200h	;设置偏移地址
		mov word ptr es:[7ch * 4 + 2], 0;设置段地址
		
		mov ax, 4c00h
		int 21h
	print_start:
		db '00/00/00 00:00:00',  '$'	;'$'中止打印
		mov ax, 0
		mov ds, ax
		mov bx, 200h
		mov al, 9						;使用al保存调用cgTime的“参数”
		call cgTime
		mov al, 8
		call cgTime
		mov al, 7
		call cgTime
		mov al, 4
		call cgTime
		mov al, 2
		call cgTime
		mov al, 0
		call cgTime
		
		mov ah, 2						;光标
		mov bl, 00001010b				;属性
		mov bh, 0						;页
		mov dh, 0AH						;行
		mov dl, 30						;列
		int 10h
		
		mov ax, 0
		mov ds, ax
		mov dx, 200h
		mov ah, 9
		int 21h
		mov ax, 4c00h
		int 21h
		
		cgTime:							;端口处理
			out 70h, al
			in al, 71h
			mov ah, al
			mov cl, 4
			shr ah, cl					;超过1要使用寄存器
			and al, 00001111b
			add ah, 30h
			add al, 30h
			mov ds:[bx], ah
			mov ds:[bx + 1], al
			add bx, 3
			ret
		
	print_end:nop
code ends
end start