assume cs:codesg

codesg segment
start: 
		int 7ch;手动触发中断
        mov ax, 4c00h
        int 21h
codesg ends

end start
