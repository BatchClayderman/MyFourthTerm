assume cs:codesg
codesg segment
	dw 0123h, 0456h, 0789h, 0abch, 0defh, 0fedh, 0cbah, 0987h
	dw 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ;10个字单元用作栈空间
start:  mov ax, cs
		mov ss, ax
		mov sp, 24h ;(8+10)*2-1+1=36=24h
		mov ax, 0
		mov ds, ax
		mov bx, 0
		mov cx, 8
	s:	push [bx]
		pop ss:[bx] ;也可以使用 pop cs:[bx]
		add bx, 2
		loop s
		mov ax, 4c00h
		int 21h
codesg ends
end start