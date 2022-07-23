assume cs:code, ds:data, ss:stack
init_stack macro stackname
	mov ax, stackname
	mov ss, ax
endm
get_input macro half_reg
	mov ah, 1
	int 21H
	sub al, 30H
	and ax, 0FH
	EN equ al
	mov half_reg, EN
endm
shift_left macro reg, num
	push cx
	mov cl, num
	shl reg, cl
	pop cx
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
stack segment
	db 128 dup (0)
stack ends
code segment
start:
	init_stack stack
	mov sp, 128
	push cs
	pop ds
	mov ax, 0
	mov es, ax
	mov si, offset int_7CH; ds:[si] 指向源地址
	mov di, 204H; es:[di] 指向目的地址
	mov cx, offset int_7CH_end - offset int_7CH;传输长度
	cld;传输方向为正
	rep movsb
	push es:[7CH * 4]
	pop es:[200H]
	push es:[7CH * 4 + 2]
	pop es:[202H];原中断向量表中 int_7CH 地址保存至 es:[200H] 
	mov word ptr es:[7CH * 4], 204H
	mov word ptr es:[7CH * 4 + 2], 0;设置中断向量表
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
	push es:[200H]
	pop es:[7CH * 4]
	push es:[202H]
	pop es:[7CH * 4 + 2];恢复原本中断向量表中 int 7CH 中断例程入口的地址
	mov ax, 4C00H
	int 21H
org 204H;伪指令，表示下一条地址从偏移地址 204H 开始，和安装后的偏移地址相同

;名称：int_7CH
;功能：如下中断可实现清屏、设置前景色、设置背景色和向上滚动一行，功能号对应为 0~3
;参数：(ah)为功能号
;返回：根据功能号调用相应子程序的返回值
int_7CH:
	jmp short int_7CH_start
	table dw sub1, sub2, sub3, sub4
	int_7CH_start: 
		push bx
		cmp ah, 3;判断功能号是否为大于 3 的非法数值
		ja int_7CH_ret
		mov bl, ah
		mov bh, 0
		add bx, bx
		call word ptr table[bx];根据功能号计算对应子程序在 table 表中的偏移
	int_7CH_ret:
		pop bx
		iret
	sub1:;清屏子程序，功能号为 0
		push bx
		push cx
		push es
		mov bx, 0B800H
		mov es, bx
		mov bx, 0
		mov cx, 2000
		sub1s: 
			mov byte ptr es:[bx], ' ';用空格填充
			add bx, 2
			loop sub1s
		pop es
		pop cx
		pop bx
		ret
	sub2:;设置前景色子程序，功能号为 1
		push bx
		push cx
		push es
		mov bx, 0B800H
		mov es, bx
		mov bx, 1
		mov cx, 2000
		sub2s: 
			and byte ptr es:[bx], 11111000B;修改前景色
			or es:[bx], al;al传送颜色值，00000000B~00000111B
			add bx, 2
			loop sub2s
		pop es
		pop cx
		pop bx
		ret
	sub3:;设置背景色子程序，功能号为 2
		push bx
		push cx
		push es
		shift_left al, 4;左移四位
		mov bx, 0B800H
		mov es, bx
		mov bx, 1
		mov cx, 2000
		sub3s: 
			and byte ptr es:[bx], 10001111B;修改背景色
			or es:[bx], al;00000000B~01110000B
			add bx, 2
			loop sub3s
		pop es
		pop cx
		pop bx
		ret
	sub4: 
		push cx
		push si
		push di
		push es
		push ds
		mov si, 0B800H
		mov es, si
		mov ds, si
		mov si, 160; ds:[si] 一开始指向第 1 行
		mov di, 0; es:[di] 一开始指向第 0 行
		cld
		mov cx, 24;复制 24 行
		sub4s: 
			push cx
			mov cx, 160; cx 为传送长度
			rep movsb;每次操作 si 和 di 递增
			pop cx
			loop sub4s
		mov cx, 80
		mov si, 0
		sub4s1:;最后一行清空
			mov byte ptr [160 * 24 + si], ' ';用空格填充
			add si, 2;屏幕 160 * 25 的行数减一
			loop sub4s1
		pop ds
		pop es
		pop di
		pop si
		pop cx
		ret
int_7CH_end:
	nop
code ends
end start