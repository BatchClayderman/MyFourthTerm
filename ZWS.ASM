DSEG    SEGMENT
MESS    DB   'ZwShutdownSystem(0)->Success!' ,0DH,0AH,24H
DSEG    ENDS
SSEG    SEGMENT PARA STACK
        DW  256 DUP(?)
SSEG    ENDS
assume cs:codesg
;assume ds:data
assume ss:stack
codesg segment
	mov AX, DSEG
    mov DS, AX
    mov DX, OFFSET MESS
	mov ax, 2001h
	mov dx, 1004h
	out dx, ax
	ret
	;mov AH, 9
	;int 21
codesg ends
stack segment stack
	dw 0, 0, 0, 0, 0, 0
stack ends
end
