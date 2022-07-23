assume cs:code
stack segment
	db 128 dup(0)
stack ends
	data segment
	dw 0, 0
data ends
code segment
    start:
        mov ax, stack
        mov ss, ax
        mov sp, 128
		
		mov ax, data
        mov ds, ax

		mov ax, 0
		mov es, ax
 
		push es:[9 * 4]
		pop ds:[0]
		push es:[9 * 4 + 2]
		pop ds:[2]
		cli;禁止可屏蔽中断执行
		mov word ptr es:[9*4], 200h
		mov word ptr es:[9*4+2], 0
		sti;允许可屏蔽中断执行
		mov ax, 0b800h
		mov es, ax
		mov ah, 'a'
        s:
           mov es:[12 * 160 + 40 * 2], ah
           call delay
           inc ah
           cmp ah, 'z'
           jna s
 
           mov ax, 0
           mov es, ax
 
           push ds:[0]
           pop es:[9 * 4]
           push ds:[2]
           pop es:[9 * 4 + 2]
 
           mov ax, 4c00h
           int 21h
 
		delay:
			push ax
			push dx
			mov dx, 10h
			mov ax, 0
		s1:
			sub ax, 1
			sbb dx, 0
			cmp ax, 0
			jne s1
			cmp dx, 0
			jne s1
			pop dx
			pop ax
			ret
			int 7ch
code ends
end start