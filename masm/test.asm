assume cs:code, ds:data, ss:stack

data segment
	DB 100 DUP(?)
data ends

stack segment
	DB 100 DUP(?)
stack ends

code segment
	start:
		mov ax, data
		mov ds, ax
		mov ax, stack
		mov ss, ax
		mov ax, 0FFFFH
		push ax
		mov ax, 0
		push ax
		retf
		mov ax, 4c00h
		int 21h
		
code ends
end start