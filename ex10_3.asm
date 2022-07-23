assume cs:code
 
data segment
	dw 123, 12666, 1, 8, 3, 38
data ends

string segment
	db 6 dup (0)
string ends
 
code segment
start:
	mov ah, 15;清屏
	int 10h
	mov ah, 0
	int 10h
	
	mov cx, 6
	mov ax, data
	mov ds, ax
	mov bx, 0
	mov dh, 8
	s:
		push cx;以下代码涉及更改cs、ds，故压栈
		push ds
		
		mov ax, ds:[bx]
		call htod
		mov dl, 3
		mov cl, 2
		mov ax, string
		mov ds, ax
		call show_str
		inc dh
		add bx, 2
		
		pop ds
		pop cx
	loop s
	
	mov ax, 4c00h
	int 21h
	
	
	htod:;十六进制转十进制
		push ax
		push bx
		push cx
		push dx
		push es
		push di
		
		mov bx, string
		mov es, bx
		mov di, 5;0~14都可用
		mov si, di
		get_div:
			mov dx, 0;这里用32位除以16位，故ax存商，dx存余数
			mov bx, 10
			div bx
			
			add dx, 48;将余数转ASCII码值（加48）
			mov es:[di], dl
			dec di
			
			mov cl, al
			mov ch, 0
			jcxz htod_ok
			mov si, di
			jmp short get_div
		
	htod_ok:
		pop di
		pop es
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	
	show_str:;在指定位置指定颜色显示字符串
		push ax
		push bx
		push cx
		push dx
		push es
		push si
		push di
		
		mov ax, 0b800H;显存起始位置
		mov es, ax
		
		mov al, dh;寄存器预处理
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
			mov es:[di], ax	;设置字母
			mov es:[di+1], dl;设置颜色
			inc dl;更改颜色（只是为了好看）
			add di, 2
			inc si
			jmp short str_set
	show_ok:
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