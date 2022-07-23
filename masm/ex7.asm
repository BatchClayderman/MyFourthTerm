assume cs:codesg, ss:stacksg, ds:datasg

stacksg segment
	dw 0, 0, 0, 0, 0, 0, 0, 0
stacksg ends

datasg segment
	db '1. display      '
	db '2. brows        '
	db '3. replace      '
	db '4. modify       '
datasg ends

codesg segment
start:
	mov ax, datasg
	mov ds, ax
	mov bx, 0
	mov cx, 4

s0: mov si, 0
	push cx
	mov cx, 4

s:  and byte ptr [bx+si+3], 11011111B
	inc si
	loop s
	add bx, 16
	pop cx
	loop s0
	
	mov ax, 4c00h
	int 21h
codesg ends

end start