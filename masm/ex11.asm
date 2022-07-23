assume cs:codesg

datasg segment 
	db "Beginner's All-purpose Symbolic Instruction Code.", 0
datasg ends

codesg segment
begin:
	mov ax, datasg
	mov ds, ax
	mov si, 0
	call letterc
	
	mov ax, 4c00h
	int 21h
		
	letterc:
		push cx
		mov ch, 0
    
    s:
		mov cl, ds:[si]
		jcxz OK
     
		cmp cl, 'a'
		jb next
		cmp cl, 'z'
		ja next
     
		and cl, 11011111b;->[A-Z]
		mov [si], cl
     
    next:
		inc si
		jmp short s
  
    OK:
		pop cx
		ret

codesg ends
end begin