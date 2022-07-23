assume cs:code
data segment 
    db 'ID: 2019052202, Name: Yuer Yang'
    db 02h       
data ends
stack segment
    dw 10 dup (0)
stack ends
code segment
start:
        mov ax, data
        mov ds, ax
        mov bx, 0				;初始化数据段地址
 
        mov ax, 0b800h			;显示缓冲区段地址
        mov es, ax
		mov ah, 04h				;颜色（黑底红字 00000100B）
        mov bp, 2080			;在第 13 行开始显示
        mov di, 40				;在中间显示
 
        mov cx, 31				;内层循环次数（要打印的字符串长度）
	s:	mov al, [bx]
        mov es:[bp + di], ax
        inc bx
        add di, 2
        loop s					;也可以用 jcxz—jmp 结构
 
        mov ax, 4c00h
        int 21h
code ends
end start