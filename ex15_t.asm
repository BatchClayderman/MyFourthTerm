assume cs:code, ds:data
get_input macro half_reg
	mov ah, 1
	int 21H
	sub al, 30H
	and ax, 0FH
	EN equ al
	mov half_reg, EN
endm
print macro string
	mov ax, data
	mov ds, ax
	lea dx, string
	mov ah, 9    
	int 21H
endm
printN macro
	mov dx, 0AH;换行
	mov ah, 02H
	int 21H;执行输出
endm

data segment
	msg1 db "Please select a method(0-3):", '$'
	msg2 db "Please enter color(1-7):", '$'
	msg3 db "Sorry, your input is invalid. Try again. ", '$'
data ends

code segment
start:
	push bx
input:
	print msg1
	get_input bh;功能
	cmp bh, 0
	je ok
	cmp bh, 3
	je ok
	cmp bh, 4
	jnc err
	printN
	print msg2
	get_input bl;颜色设置
	cmp bl, 8;输入异常
	jc ok
err:
	printN
	print msg3
	jmp input
ok:
	mov al, bl
	mov ah, bh
	pop bx
	int 7CH
	;push es:[200H]
	;pop es:[7CH * 4]
	;push es:[202H]
	;pop es:[7CH * 4 + 2];恢复原本中断矢量表中 int 7CH 中断例程入口的地址
	mov ax, 4C00H
	int 21H
code ends
end start