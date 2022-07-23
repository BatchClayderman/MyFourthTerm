assume cs:code
code segment
	start:
		mov ax, cs
		mov ds, ax
		mov si, offset sub1
		mov ax, 0020h
		mov es, ax
		mov di, 0
		mov cx, offset sub2 - offset sub1
		cld 
		rep movsb ;复制程序

		mov ax, 0
		mov es, ax
		mov word ptr es:[7ch * 4], 200h
		mov word ptr es:[7ch * 4 + 2], 0
		mov ax, 4c00h
		int 21h ;入口地址附加
	sub1:
		push ax
		push bx
		push es
		in al, 60h
		pushf
		call dword ptr ds:[0]
		cmp al, 1
		jne int9ret
		mov ax, 0b800h
		mov es, ax
		inc byte ptr es:[12 * 160 + 40 * 2 + 1]
	int9ret:
		pop es
		pop bx
		pop ax
		iret
	sub2:
		nop
code ends
end start