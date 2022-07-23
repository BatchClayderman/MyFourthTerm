assume cs:codeseg
codeseg segment
do0:
	jmp short do0Start
	db "divide overflow!"
	do0Start:
	mov ax, cs						
	mov ds, ax
	mov si, 0202H
	mov ax, 0B800H					
	mov es, ax
	mov di, 12 * 160 + 33 * 2
	mov cx, 16;长度
	s:	mov al, ds:[si]
		mov ah, 2
		mov es:[di], ax
		inc si
		add di, 2
		loop s
	mov ax, 4c00H					
	int 21H
do0End:
start:
	mov ax, codeseg							
	mov ds, ax
	mov si, offset do0
	mov ax, 0								
	mov es, ax
	mov di, 200H
	mov cx, offset do0End - offset do0	
	cld										
	rep movsb								
	mov ax, 0
	mov es, ax
	mov word ptr es:[0], 0200H
	mov word ptr es:[2], 0000H
	mov ax, 4c00H
	int 21H
codeseg ends
end start