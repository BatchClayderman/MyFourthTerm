assume cs:code
data segment
	tab dw 12h,23h,3bcdh,40bfh,5ch
		dw 80aah
data ends
   
code segment

start:
	mov ax, data
	mov ds, ax
	mov bx, offset tab
	mov si, 2
	
	mov ax, [bx+si+3]
	mov cx, type tab
	mov dx, [bx+si+8]
	
	mov ax, 4c00h
	int 21h
  
code ends
end start