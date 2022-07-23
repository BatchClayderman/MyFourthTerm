assume cs:code
data segment
  db 'conversation', 0
data ends

code segment
start:
	mov ax, cs
	mov ds, ax
	mov si, offset cst
	mov ax, 0
	mov es, ax
	mov di, 200h
	mov cx, offset ce - offset cst
	cld
	rep movsb

	mov ax, 0
	mov es, ax
	mov word ptr es:[7ch * 4], 200h
	mov word ptr es:[7ch * 4 + 2], 0
	
	mov ax, data
	mov ds, ax
	mov si, 0
	mov ax, 0b800h;不是“数字”开头的数字记得在前面加0
	mov es, ax
	mov di, 12 * 160 + 35 * 2

s:
	cmp byte ptr [si], 0
	je ok
	mov al, ds:[si]
	mov es:[di], al
	inc si
	add di, 2
	mov bx, offset s - offset ok
	int 7ch
ok:
	mov ax, 4c00h
	int 21h

cst:
	push bp
	mov bp,sp
	add [bp+2], bx
	pop bp
	iret
ce:
	nop
	
code ends
end start