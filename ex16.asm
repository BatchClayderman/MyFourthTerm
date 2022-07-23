printN macro;;换行
	mov dx, offset seperate
	mov ah, 9
	int 21h
endm
print macro dbsg;;打印
	printN
	mov dx, offset dbsg
	mov ah, 09h
	int 21h
endm
scanf macro dbsg;;输入
	local toLoop
	mov si, offset dbsg
	mov cx, 20
	mov ah, '$';清空原有输入！！！
	toLoop:
		mov [si], ah;
		inc si
	loop toLoop
	mov dx, offset dbsg
	mov ah, 0ah
	int 21h
endm


assume cs:code, ds:data, es:data

data segment
	username db 21, 0, 21 dup('$'); 20 个字符要写到 21
	password db 21, 0, 21 dup('$')
	againusername db 21, 0, 21 dup('$')
	againpassword db 21, 0, 21 dup('$')
	write0 db '*******Setting your name and password*******', '$'
	write1 db 'Please input your username (0-20 characters): ', '$'
	write2 db 'please input your password (0-20 characters): ', '$'
	dissp1 db 'The input of the username is not correct', '$'
	dissp2 db 'The input of the password is not correct', '$'
	writeagain1 db 'Please input your username again: ', '$'
	writeagain2 db 'Please input your password again: ', '$'
	display db 'Account setting is successful!', '$'
	seperate db 0dh, 0ah, '$';换行
data ends

code segment                        
start: 	
	mov ax, data                     
	mov ds, ax
	mov es, ax
	
	init:
		mov dx, offset write0
		mov ah, 09h
		int 21h
	
	input1: 
		print write1
        scanf username
	
	input2: 
        print write2
        scanf password
		
	over:
        print writeagain1

	input3:
		scanf againusername
	cmp1:
		mov si, offset againusername + 1
		mov cx, 20
		mov si, offset username + 2
		mov di, offset againusername + 2
        cld
        repe cmpsb
        jne error1					;用户名不同，显示错误
        jmp right					;用户名相同，检查密码
	right:
		print writeagain2
		mov cx, 20					;比较全部
        mov bx, 0
		mov si, offset againpassword
	input4:
		scanf againpassword
	cmp2:
		mov si, offset againpassword + 1
		mov cx, 20					;比较全部
		mov di, offset password + 2
		mov si, offset againpassword + 2
		cld
        repe cmpsb
        jne error2					;密码不同，显示错误
		jmp exit
		
	error1:
		print dissp1				;显示 username Error!
        jmp over
		
	error2:
		print dissp2				;显示 Password Error!
        jmp right
		
		
	exit:
        print display
        mov ax, 4c00h
        int 21h   
	
code ends
end start