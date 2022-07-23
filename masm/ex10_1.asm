assume cs:code

data segment
	db 'Welcome to masm!', 0
data ends
 
code segment
start:
	mov ah, 15;清屏
	int 10h
	mov ah, 0
	int 10h
	
	mov dh, 8
	mov dl, 3
	mov cl, 2
	
	mov ax, data;源地址
	mov ds, ax
	mov si, 0
	
	call show_str
	
	mov ax, 4c00h
	int 21h
	
	show_str:
		push ax
		push bx
		push cx
		push dx
		push es
		push si
		push di
		
		mov ax, 0b800H;显存起始位置
		mov es, ax
		
		mov al, dh;预处理（判断di，di = dh*160+dl*2，ax 、bx、di没有用户数据被占用）
		mov ah, 0
		mov bl, 160
		mul bl
		mov di, ax
		
		mov al, dl
		mov ah, 0
		mov bl, 2
		mul bl
		add di, ax
		
		mov dl, cl;存放颜色
		str_set:
			mov cl, ds:[si]
			mov ch, 0
			jcxz show_ok;控制结束条件
			
			mov ax, ds:[si]
			mov es:[di], ax;设置字母
			mov es:[di+1], dl;设置颜色
			add di, 2
			inc si
			jmp short str_set
	show_ok:;栈平衡
		pop di
		pop si
		pop es
		pop dx
		pop cx
		pop bx
		pop ax
		ret	
code ends
end start