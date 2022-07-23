assume cs:code
code segment
start:
		mov ax,10;初始化ax = 10
		mov bx, ax;bx用于存放原ax乘8的值
		shl ax,1;相当于乘2
	mov cl, 3;操作数大于1需要临时使用寄存器
		shl bx, cl;相当于乘8
		add ax, bx;乘2加乘8加起来相当于乘10
mov ax, 4c00h
int 21h
code ends
end start