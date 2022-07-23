assume cs:codeseg
codeseg segment
start:
	mov ax, 4c00H
	mov bl, 0
	div bl
	mov ax, 4c00H
	int 21H
codeseg ends
end start