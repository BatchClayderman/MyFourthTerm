mPush_ABCDsd MACRO
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
ENDM

mPop_dsDCBA MACRO
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
ENDM

mPush_ABCDs MACRO
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
ENDM

mPop_sDCBA MACRO
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
ENDM

mPush_ABCD MACRO
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
ENDM

mPop_DCBA MACRO
	POP DX
	POP CX
	POP BX
	POP AX
ENDM

mPush_ABDs MACRO
	PUSH AX
	PUSH BX
	PUSH DX
	PUSH SI
ENDM

mPop_sDBA MACRO
	POP SI
	POP DX
	POP BX
	POP AX
ENDM

mPush_ABCs MACRO
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH SI
ENDM

mPop_sCBA MACRO
	POP SI
	POP CX
	POP BX
	POP AX
ENDM

mPush_AD MACRO
	PUSH AX
	PUSH DX
ENDM

mPop_DA MACRO
	POP DX
	POP AX
ENDM


mPrint MACRO strvar
	mPush_AD
	MOV AH, 9
	MOV DX, offset strvar
	INT 21H
	mPop_DA
ENDM

mLength MACRO;; SI 指向字符串的长度保存在 CX 中，将会改变 CX 的值
	local mlp1
	local mlp2
	mPush_ABDs
	mov cx, 3fffh;统计的最大长度
	mov bx, cx
	cld;设置传输方向为正
	mlp1:
        lodsb
        cmp al, '$'
        je mlp2
        loop mlp1
	mlp2:
		sub bx, cx
		mov cx, bx
	mPop_sDBA
ENDM

; mPrintN 已使用 CRLF PROC Function 替代

; mPrintA 作为子函数被 mPrintB 和 mPrintC 进行调用

mPrintB MACRO strvar, color
	local mpc
	mPush_ABCDsd
	XOR BH, BH			; page
	LEA SI, strvar
	MOV BL, color
	CALL mPrintA
	mPop_dsDCBA
ENDM

mPrintC MACRO strvar, color
	local mpc
	mPush_ABCDsd
	XOR BH, BH			; page
	LEA SI, strvar
	MOV BL, color
	CALL mPrintA
	CALL CRLF
	mPop_dsDCBA
ENDM


mCallFun MACRO function
	CALL function
	CALL SUSPEND
	JMP Start1
ENDM

mCheckSum MACRO
	local Start3
	local Start4
	JMP Start4
	Start3:;空计数
		mPrintC Notice42, 01000111B
		RET
	Start4:
		CMP NUMBER, 0
		JE Start3
ENDM

mBufInsert MACRO char
	DEC BX
	MOV DL, char
	MOV [BX], DL
ENDM

m_getchar MACRO
	MOV AH, 1
	INT 21H
ENDM

mExit MACRO
	MOV AX, 4C00H
	INT 21H
ENDM


mRead MACRO rARR, rLen
	MOV CX, rLen
	MOV AH, 3FH
	MOV DX, OFFSET rARR
	INT 21H
ENDM

mWrite MACRO wARR, wLen
	MOV CX, wLen
	MOV AH, 40H
	MOV DX, OFFSET wARR
	INT 21H
ENDM

mCmp MACRO chkcmp
	CMP BYTE PTR [BX], chkcmp
	JNE DATA_ERR
	INC BX
ENDM

mSet MACRO mPath, attr
	MOV AH, 43H
	MOV DX, OFFSET mPath
	MOV AL, attr
	INT 21H
ENDM




assume cs:codesg, ds:datasg, ss:stacksg
datasg SEGMENT
	Notice	DB 'Here are several functions provided for you. ', 0DH, 0AH
			DB '  1. Log data; ', 0DH, 0AH
			DB '  2. Search with keyword; ', 0DH, 0AH
			DB '  3. Sort and output; ', 0DH, 0AH
			DB '  4. Calculate the average score; ', 0DH, 0AH
			DB '  5. Calculate the highest score; ', 0DH, 0AH
			DB '  6. Calculate the lowest score; ', 0DH, 0AH
			DB '  7. Calculate statistic of ranges; ', 0DH, 0AH
			DB '  8. Import from data file; ', 0DH, 0AH
			DB '  9. Export to data file; ', 0DH, 0AH
			DB '  0. Exit. ', 0DH, 0AH
			DB 0DH, 0AH
			DB 'Please select a function to continue: ', 0DH, 0AH, '$'
	Notice1 DB 'Please input the name of the student:(0-20 chars)', 0DH, 0AH, '$'
	Notice2 DB 'Please input the ID of the student:(0-20 chars)', 0DH, 0AH, '$'
	Notice3 DB 'Please input the 1ST score: ', '$'
	Notice4 DB 'Please input the 2ND score: ', '$'
	Notice5 DB 'Please input the 3RD score: ', '$'
	Notice6 DB 'Please input the 4TH score: ', '$'
	Notice7 DB 'Please input the 5TH score: ', '$'
	Notice8 DB 'Please input the 6TH score: ', '$'
	Notice9 DB 'Please input the 7TH score: ', '$'
	Notice10 DB 'Please input the 8TH score: ', '$'
	Notice11 DB 'Please input the 9TH score: ', '$'
	Notice12 DB 'Please input the 10TH score: ', '$'
	Notice13 DB 'Please input the 11TH score: ', '$'
	Notice14 DB 'Please input the 12TH score: ', '$'
	Notice15 DB 'Please input the 13TH score: ', '$'
	Notice16 DB 'Please input the 14TH score: ', '$'
	Notice17 DB 'Please input the 15TH score: ', '$'
	Notice18 DB 'Please input the 16TH score: ', '$'
	Notice19 DB 'Please input the LAST score: ', '$'
	Notice20 DB 'Do you want to input another one?[Y/N]', 0DH, 0AH, '$'
	Notice21 DB 'SEARCH ERROR', 0DH, 0AH, '$'
	Notice22 DB 'Do you want to search another one?[Y/N]', 0DH, 0AH, '$'
	Notice23 DB 'Here are two search modes for you. ', 0DH, 0AH
			 DB '  1. Search by Name; ', 0DH, 0AH
			 DB '  2. Search by ID. ', 0DH, 0AH
			 DB 0DH, 0AH
			 DB 'Please select a search mode to continue: ', 0DH, 0AH, '$'
	Notice24 DB 'NEXT', 0DH, 0AH, '$'
	Notice25 DB 80 DUP('*'), '$'
	Notice26 DB 'Name: ', '$'
	Notice27 DB '   0-59.99: ', '$'
	Notice28 DB '  60-69.99: ', '$'
	Notice29 DB '  70-79.99: ', '$'
	Notice30 DB '  80-89.99: ', '$'
	Notice31 DB '    90-100: ', '$'
	Notice32 DB 'The average is: ', '$'
	Notice33 DB 'ID: ', '$'
	Notice34 DB 'FINAL: ', '$'
	Notice35 DB 'The highest is: ', '$'
	Notice36 DB 'The lowest is: ', '$'
	Notice37 DB 'NORMAL: ', '$'
	Notice38 DB 'LAST: ', '$'
	Notice39 DB 'Please input the keyword(s) for name(s) search, or stay empty to cancel: ', 0DH, 0AH, '$'
	Notice40 DB 'Please input the keyword(s) for ID(s) search, or stay empty to cancel: ', 0DH, 0AH, '$'
	Notice41 DB 'Not found. Please adjust your keyword(s) and try again. ', 0DH, 0AH, '$'
	Notice42 DB 'No data recorded now, please use function 1 to log down data. ', '$'
	Notice43 DB 'Sorry, the record is full. ', '$'
	Notice44 DB 0DH, 0AH, 'Search finished. Found ', '$'
	Notice45 DB 'H matches in total. ', 0DH, 0AH, '$'
	Notice46 DB 'Note: Only one student recorded. ', '$'
	Notice47 DB 'The range of scores are shown as follows: ', '$'
	Notice48 DB 'You have just attached a hidden function. ', '$'
	Notice49 DB 'Shutdown or not? Press S to continue, F in kernel mode and others to cancel. ', '$'
	Notice50 DB 'Reboot or not? Press R to continue, F in kernel and others to cancel. ', '$'
	Notice51 DB 'This function should be called only with the process broken. Press E to continue and reboot your machine. ', '$'
	Notice52 DB 'Note: Data file has been created. ', 0DH, 0AH, '$'
	Notice53 DB 'Load successfully! ', 0DH, 0AH, '$'
	Notice54 DB 'Dump successfully! ', 0DH, 0AH, '$'
	Notice55 DB 30 DUP(' '), '$'
	Welcome  DB 'Hey, you are warmly welcome here by Y. Yang and H. Lai! (^_^)', '$'
	Any_Key  DB '=== Press any key to continue ===', '$'
	Any_More DB '*** More?[A/C/Other Keys] ***', '$'
	InputErr DB 'Sorry, your input is invalid. Try again! ', '$'
	Good_Bye DB 'Welcome to visit next time! Goodbye! ', '$'
	
	TABLE	DW CASE0, CASE1, CASE2, CASE3, CASE4, CASE5, CASE6, CASE7, CASE8, CASE9, CASES, CASER, CASEE
	TABLE1	DW Notice3, Notice4, Notice5, Notice6, Notice7, Notice8, Notice9, Notice10, Notice11, Notice12, Notice13, Notice14, Notice15, Notice16, Notice17, Notice18
	COUNT	DW 0; COUNTER
	COUNT0	DW 0; Failed
	COUNT1	DW 0; 60~69
	COUNT2	DW 0; 70~79
	COUNT3	DW 0; 80~89
	COUNT4	DW 0; 90~100
	COUNT5	DW 0; Search Name
	
	;以下八段要连续放			*** Begin of Dump ***
	xxggyyds	DB '_xxggyyds!!! $';只是用来检验
	NUMBER		DW 0; THE NUMBER OF STUDENTS
	NAME_ARR	DB 100 DUP (21 DUP (?)); 名字的最大长度为 20 字节
	ID_ARR		DB 100 DUP (21 DUP (?))
	SCORE_ARR   DW 1600 DUP (?)
	LAST_ARR	DW 100 DUP (?)
	FINAL_ARR	DW 100 DUP (?)
	SORTED		DW 100 DUP (?)
	;以上八段要连续放			*** End of Dump ***
	
	STOKNIN1 LABEL BYTE
		MAX1 DB 21
		ACT1 DB ?
		STOKN1 DB 21 DUP (?)
	;暂存关键字
	STOKNIN2 LABEL BYTE
		;MAX2 DB 21
		ACT2 DB ?
		;STOKN2 DB 21 DUP (?)
	;暂存待比对的姓名
	
	PATH		DB 'C:\FINAL.DAT', '$';文件名
	HANDLE		DW 0;一开始千万不要分配数值 1 ！！
	DUMPLEN		DW 8016; 14 + 2 + 100 * 21 * 2 + 1600 * 2 + 100 * 2 + 100 * 2 + 100 * 2 = 8016
	ERRCODE		DB 20
	ERRCDE		DB 20
	fCreateMsg	DB 'Error creating file! ', '$'
	fOpenMsg	DB 'Error opening file! ', '$'
	fCloseMsg	DB 'Error closing file! ', '$'
	fReadMsg	DB 'Error reading file! ', '$'
	fWriteMsg	DB 'Error writing file! ', '$'
	fCheckMsg	DB 'Fail checking header statics!', '$'
	fWarnMsg	DB 'Please make sure you have not imported an illegal file! ', '$'
	fInMsg		DB 'Import or not? If you have data logged, it will be lost. ', '$'
	fOutMsg		DB 'Export or not? The data file will be overwriten if existed. ', '$'
	
	BUFFER		DB 20 DUP (0), '$'
	BUFREAR		EQU OFFSET BUFFER + 20
	MAX_LEN		DB 21
	P_REMINDER	DB 5
	;Breakpoint	DB 'Breakpoint', 0DH, 0AH, '$';断点检测
datasg ENDS



stacksg SEGMENT stack
	DB 100 DUP (?)
stacksg ENDS



codesg SEGMENT
	Start:
		MOV AX, datasg
		MOV DS, AX
		MOV ES, AX
		MOV AX, stacksg
		MOV SS, AX
		CALL CRLF
		CALL CLEAR;清屏
		CALL fOPEN
		CMP HANDLE, 1
		JNE StartC
		CALL fCREATE
		CMP HANDLE, 1
		JE Start_Err
		CALL CLEAR
		mPrint Notice52
		JMP StartW
	
	Start_Err:
		mPrintC fCreateMsg, 00000100B
		JMP StartW
	StartC:
		CALL fCLOSE
		JMP StartW
	
	StartW:
		mPrintC Welcome, 00000110B
		CALL SUSPEND
		CALL CRLF
		JMP Start1
		
	Start1:
		CALL CLEAR;清屏
		mPrintC Notice25, 00000010B
        mPrint Notice;mPrint Functions
		mPrintC Notice25, 00000010B
		MOV AH, 1
		INT 21H; GET USERS CHOICE IN AL
		CALL CRLF
		SUB AL, '0'
		CMP AL, 9;纠错检查
		JA StartS
		MOV BL, AL
		XOR BH, BH
		SHL BX, 1
		JMP TABLE[BX]
		
	StartS:
		ADD AL, '0';加回来
		AND AL, 11011111B;转大写
		CMP AL, 'S'
		JNE StartR
		MOV BL, 10
		XOR BH, BH
		SHL BX, 1
		JMP TABLE[BX]
	StartR:
		CMP AL, 'R'
		JNE StartE
		MOV BL, 11
		XOR BH, BH
		SHL BX, 1
		JMP TABLE[BX]
	StartE:
		CMP AL, 'E'
		JNE Start2
		MOV BL, 12
		XOR BH, BH
		SHL BX, 1
		JMP TABLE[BX]
		
	Start2:
		CALL CLEAR
		mPrintC InputErr, 01110100B
		CALL SUSPEND
		JMP Start1
		
		
	CASE0:
		CALL CLEAR
		mPrintC Good_Bye, 00000110B
		CALL SUSPEND
		CALL CLEAR
		mEXIT
	CASE1:
		mCallFun LOGDATA
	CASE2:
		mCallFun SEARCHDATA
	CASE3:
		mCallFun SORT
	CASE4:
		mCallFun AVERAGE
	CASE5:
		mCallFun HIGHEST
	CASE6:
		mCallFun LOWEST
	CASE7:
		mCallFun STATISTIC
	CASE8:
		mCallFun DATA_IN
	CASE9:
		mCallFun DATA_OUT
	CASET:
		JMP START1
	CASES:
		CALL PRESHUTDOWN
		JMP CASET
	CASER:
		CALL PREREBOOT
		JMP CASET
	CASEE:
		CALL PREERROR
		AND AL, 11011111B;转大写
		CMP AL, 'E'
		JNE CASET
		CALL CLEAR
		MOV AX, 9
		INT 20H;迫使当前进程自我终止
		;mEXIT;进程已退出，但没有返回值，此句可省略
	
	
	LOGDATA PROC NEAR
			mPush_AD
			CMP NUMBER, 100;防止数据量过大
			JB LOG
			mPrintC Notice43, 01000111B
			JMP LOGEND
			
		LOG:
			mPrint Notice25
			mPrint Notice1
			CALL LOGNAME
			mPrint Notice2
			CALL LOGID
			CALL LOGSCORE
			mPrint Notice19
			CALL LAST
			CALL FINALSCORE
			CALL CRLF
			mPrint Notice25
			INC NUMBER
		CHOICE:
			CMP NUMBER, 100;防止数据量过大
			JAE LOGEND
			mPrint Notice20
			MOV AH, 1
			INT 21H
			CALL CRLF
			AND AL, 11011111B
			CMP AL, 'Y';不区分大小写
			JE LOG
			CMP AL, 'N'
			JE LOGEND
			mPrintC InputErr, 01110100B
			JMP CHOICE
			
		LOGEND:
			mPop_DA
			RET
	LOGDATA ENDP
	
	
	LOGNAME PROC NEAR
			mPush_ABDs
			MOV AX, NUMBER
			MOV CL, MAX_LEN
			MUL CL
			MOV BX, AX
			XOR SI, SI
			LEA BX, NAME_ARR[BX]
			;MOV AH, 0AH
			;INT 21H;将姓名存在 NAME_ARR
		INLOOP0:
			MOV AH, 1
			INT 21H
			CMP AL, 0DH;回车
			JE INLOOP0END0
			CMP AL, 8H;退格
			JE INLOOPBACK0
			MOV [BX + SI], AL
			INC SI
			JMP INLOOP0
		INLOOPBACK0:
			OR SI, SI
			JZ INLOOP0
			DEC SI;清除输入的上一个字符
			MOV AL, ' '
			MOV [BX + SI], AL
			CALL REWRITE
			JMP INLOOP0
		INLOOP0END0:
			MOV AL, '$'
			MOV [BX + SI], AL
			mPop_sDBA
			RET
	LOGNAME ENDP
	
	
	LOGID PROC NEAR
			mPush_ABDs
			MOV AX, NUMBER
			MOV CL, MAX_LEN
			MUL CL
			MOV BX, AX
			XOR SI, SI
			LEA BX, ID_ARR[BX]
		INLOOP1:
			MOV AH, 1
			INT 21H
			CMP AL, 0DH;回车
			JE INLOOP0END1
			CMP AL, 8H;退格
			JE INLOOPBACK1
			MOV [BX + SI], AL
			INC SI
			JMP INLOOP1
		INLOOPBACK1:
			OR SI, SI
			JZ INLOOP1
			DEC SI;清除输入的上一个字符
			MOV AL, ' '
			MOV [BX + SI], AL
			CALL REWRITE
			JMP INLOOP1
		INLOOP0END1:
			MOV AL, '$'
			MOV [BX + SI], AL
			mPop_sDBA
			RET
	LOGID ENDP
	
	
	LOGSCORE PROC NEAR
			mPush_ABCDsd
			MOV CX, 16
			MOV SI, 0
		S:
			MOV AH, 9
			MOV DX, TABLE1[SI]
			INT 21H
			CALL SCORE
			CALL CRLF
			INC SI
			INC SI
			INC COUNT
			LOOP S
			
			mPop_dsDCBA
			RET
	LOGSCORE ENDP
	
	
	SCORE PROC NEAR
			mPush_ABCDsd
			XOR BX, BX;置零
			XOR SI, SI;给'.'判断
			MOV DI, 100
		INLOOP2:
			MOV AH, 8
			INT 21H
			XOR AH, AH
			CMP AL, 0DH;结束
			JE INLOOPEND2
			CMP AL, 8;重置
			JE INLOOPBACK2
			CMP AL, '.'
			JE CHANGE
			CMP AL, '0'
			JB INLOOP2
			CMP AL, '9'
			JA INLOOP2
			PUSH AX
			MOV AX, BX
			MOV CX, 10
			MUL CX
			MOV CX, AX
			POP AX
			CMP CX, DI
			JA INLOOP2
			MOV DL, AL
			SUB AL, '0'
			ADD CX, AX
			CMP CX, DI
			JA INLOOP2
			MOV BX, CX
			MOV AH, 2
			INT 21H
			JMP INLOOP2

		CHANGE:
			CMP SI, 1
			JE INLOOP2
			MOV SI, 1
			MOV DI, 1000
			MOV DL, AL
			MOV AH, 2
			INT 21H
			JMP INLOOP2
		MUL10:
			PUSH AX
			MOV AX, BX
			MOV CL, 10
			MUL CL
			MOV BX, AX
			XOR SI, SI; MOV SI, 1
			INC SI
			POP AX
		INLOOPEND2:
			CMP SI, 0
			JZ  MUL10
			MOV SI, COUNT
			SHL SI, 1
			MOV SCORE_ARR[SI], BX
			mPop_dsDCBA
			RET
		INLOOPBACK2:
			mPop_dsDCBA
			DEC SI
			DEC SI
			DEC COUNT
			INC CX
			RET
	SCORE ENDP
	
	
	LAST PROC NEAR
			mPush_ABCDsd
			XOR BX, BX
			XOR SI, SI
			MOV DI, 100
		INLOOP3:
			MOV AH, 8
			INT 21H
			XOR AH, AH
			CMP AL, 0DH
			JE INLOOPEND3
			CMP AL, 8
			JE INLOOPBACK3
			CMP AL, '.'
			JE CHANGE1
			CMP AL, '0'
			JB INLOOP3
			CMP AL, '9'
			JA INLOOP3
			
			PUSH AX
			MOV AX, BX
			MOV CX, 10
			MUL CX
			MOV CX, AX
			POP AX
			CMP CX, DI
			JA INLOOP3
			MOV DL, AL 
			SUB AL, '0'
			ADD CX, AX
			CMP CX, DI
			JA INLOOP3
			MOV BX, CX
			MOV AH, 2
			INT 21H
			JMP INLOOP3

		CHANGE1:
			CMP SI, 1
			JE INLOOP3
			MOV SI, 1
			MOV DI, 1000
			MOV DL, AL
			MOV AH, 2
			INT 21H
			JMP INLOOP3
			
		MUL10_1:
			PUSH AX
			MOV AX, BX
			MOV CL, 10
			MUL CL
			MOV BX, AX
			MOV SI, 1
			POP AX
		INLOOPEND3:
			CMP SI, 0
			JZ  MUL10_1
			MOV SI, NUMBER
			SHL SI, 1
			MOV LAST_ARR[SI], BX
			mPop_dsDCBA
			RET
		INLOOPBACK3:
			mPop_dsDCBA
			mPrint Notice19
			CALL CRLF
			CALL LAST
			RET
	LAST ENDP
	
	
	FINALSCORE PROC NEAR
			mPush_ABCDsd
			
			XOR AX, AX
			XOR DX, DX
			MOV AX, NUMBER
			MOV CX, 16
			MUL CX
			MOV SI,AX
			SHL SI, 1
			XOR AX,AX

		ACCUMULATE:
			ADD AX, SCORE_ARR[SI]
			INC SI
			INC SI
			LOOP ACCUMULATE
			
			MOV BX, 4
			MUL BX
			XOR DX, DX
			MOV CX, 160
			DIV CX
			XOR DX, DX
			PUSH AX
			MOV AX, DX
			MOV DX, 10	
			MUL DX
			XOR DX, DX
			DIV CX
			CMP AX, 5;四舍五入
			JB ACCEND	
			
			POP AX
			INC AX
			JMP NEXT0
			
		ACCEND:		
			POP AX
			
		NEXT0:  
			XOR DX, DX;置零
			PUSH AX;保护平时成绩
			MOV BX, NUMBER
			MOV SI, BX
			SHL SI, 1
			MOV AX, LAST_ARR[SI]
			MOV BX, 6
			MUL BX   
			MOV CX, 10
			OR CX, CX;引发标志位改变
			DIV CX;这里 AX 是大作业成绩 600
			PUSH AX
			MOV AX, DX
			MOV DX, 10	
			MUL DX	
			DIV CX	
			CMP AX, 5;四舍五入
			JB ACCEND1	
			POP AX
			INC AX
			JMP NEXT1
		ACCEND1:		
			POP AX
		NEXT1:	
			MOV DX, AX
			POP AX
			ADD AX, DX
			MOV SI, NUMBER
			SHL SI, 1
			MOV FINAL_ARR[SI], AX
	
			mPop_dsDCBA
			RET
	FINALSCORE ENDP;最终成绩
	
	
	SEARCHDATA PROC NEAR
			mCheckSum
			mPush_ABCDsd
			MOV P_REMINDER, 6;初始化计数
			
		SEARCH:
			mPrint Notice25
			mPrint Notice23
			XOR AH, AH
			INC AH
			INT 21H
			CALL CRLF
			CMP AL, '1'
			JE SEARCH1
			CMP AL, '2'
			JE SEARCH2
			mPrintC InputErr, 01110100B
			JMP SEARCH
		SEARCH1:
			CALL SEARCHNAME
			JMP OVER
		SEARCH2:
			CALL SEARCHID
		OVER:
			mPop_dsDCBA
			RET
	SEARCHDATA ENDP
	
	
	SEARCHNAME PROC NEAR
			MOV COUNT5, 0;初始化计数
		A10:
			mPrint Notice39
			XOR BP, BP
			MOV AH, 0AH;待查找的姓名先存储在 stoknin1 中
			LEA DX, STOKNIN1
			INT 21H
			CMP ACT1, 0
			JE OVER2
			CALL CRLF
			PUSH BP
			
		A15:
			POP BP
			INC BP
			CMP BP, NUMBER;比较人数
			JA A35;遍历完毕
			PUSH BP;未遍历完
			DEC BP
			MOV AX, BP
			MOV CL, MAX_LEN
			MUL CL
			MOV BP, AX
			LEA SI, NAME_ARR[BP]
			mLength
			MOV ACT2, CL
			CMP ACT2, 0
			JE A15;空串无匹配
			MOV AL, ACT1
			CBW;XOR AH, AH
			MOV CX, AX
			PUSH CX
			MOV AL, ACT2
			SUB AL, ACT1
			JS A25
			XOR DI, DI
			XOR SI, SI
			LEA BX, NAME_ARR[BP]
			INC AL
			JMP A20
			
		A20:;开始比较
			MOV AH, [BX + DI]
			CMP AH, STOKN1[SI];不等则 +1
			JNE A30
			INC SI
			INC DI
			;INC BX
			DEC CX
			CMP CX, 0
			JE AMATCH
			JMP A20
		
		A25:;中转站
			POP CX
			JMP A15
			
		A30:
			INC BX
			DEC AL
			;CMP AL, 0
			;JE A25
			JZ A25
			XOR SI, SI
			XOR DI, DI
			POP CX
			PUSH CX
			JMP A20
			
		OVER2:
			RET
			
		A35:
			CMP COUNT5, 0
			JE A40
			mPrint Notice44
			MOV BX, COUNT5
			CALL TRANS
			mPrint Notice45
			JMP OVER2
			
		A40:
			mPrint Notice41
			JMP OVER2
			
		AMATCH:;输出学生信息
			CALL CRLF
			POP CX
			POP AX
			PUSH AX
			PUSH CX
			DEC AX
			MOV SI, AX
			CALL SHOW
			INC COUNT5
			JMP A25
	SEARCHNAME ENDP
	
	
	SEARCHID PROC NEAR
			MOV COUNT5, 0;初始化计数
		B10:
			mPrint Notice40
			XOR BP, BP
			MOV AH, 0AH;待查找的姓名先存储在 stoknin1 中
			LEA DX, STOKNIN1
			INT 21H
			CMP ACT1, 0
			JE OVER3
			CALL CRLF
			PUSH BP
			
		B15:
			POP BP
			INC BP
			CMP BP, NUMBER;比较人数
			JA B35;遍历完毕
			PUSH BP;未遍历完
			DEC BP
			MOV AX, BP
			MOV CL, MAX_LEN
			MUL CL
			MOV BP, AX
			LEA SI, ID_ARR[BP]
			mLength
			MOV ACT2, CL
			CMP ACT2, 0
			JE B15;空串无匹配
			MOV AL, ACT1
			CBW;XOR AH, AH
			MOV CX, AX
			PUSH CX
			MOV AL, ACT2
			SUB AL, ACT1
			JS B25
			XOR DI, DI
			XOR SI, SI
			LEA BX, ID_ARR[BP]
			INC AL
			JMP B20
			
		B20:;开始比较
			MOV AH, [BX + DI]
			CMP AH, STOKN1[SI];不等则 +1
			JNE B30
			INC SI
			INC DI
			;INC BX
			DEC CX
			CMP CX, 0
			JE BMATCH
			JMP B20
		
		B25:;中转站
			POP CX
			JMP B15
			
		B30:
			INC BX
			DEC AL
			;CMP AL, 0
			;JE B25
			JZ B25
			XOR SI, SI
			XOR DI, DI
			POP CX
			PUSH CX
			JMP B20
			
		OVER3:
			RET
			
		B35:
			CMP COUNT5, 0
			JE B40
			mPrint Notice44
			MOV BX, COUNT5
			CALL TRANS
			mPrint Notice45
			JMP OVER3
			
		B40:
			mPrint Notice41
			JMP OVER3
			
		BMATCH:;输出学生信息
			CALL CRLF
			POP CX
			POP AX
			PUSH AX
			PUSH CX
			DEC AX
			MOV SI, AX
			CALL SHOW
			INC COUNT5
			JMP B25
	SEARCHID ENDP	
	
	
	TRANS PROC NEAR;转换为 16 进制
			MOV CH, 4		; number of digits
		ROTATE:
			MOV CL, 4		; set count to 4bits
			ROL BX, CL		; left digit to right
			MOV AL, BL		; mov to al
			AND AL, 0FH		; mask off left digit
			ADD AL, 30H		; convert hex to ASCII
			CMP AL, 3AH		; judge if > 9?
			JL PRINT_IT		; jump if digit is from 0 to 9
			ADD AL, 7H		; digit is from A to F
		
		PRINT_IT:
			MOV DL, AL		; put ASCII char in DL
			MOV AH, 2		; display Output funct
			INT 21H			; call DOS
			DEC CH			; has it done 4 digits?
			JNZ ROTATE		; not yet
			ret				; return from trans
	TRANS ENDP
	
	
	SHOW PROC NEAR
			mPush_ABCDsd
			CMP P_REMINDER, 0;显示已取消
			JE REMIND_END
			DEC P_REMINDER
			CMP P_REMINDER, 1;显示需要暂停
			JNE REMIND
			CALL SSS_MORE_SSS
			JMP REMIND
			
		REMIND_END:
			mPop_dsDCBA
			RET
			
		REMIND:
			PUSH AX
			XOR DX, DX
			XOR DI, DI
			MOV CX, 21
			MUL CX;执行定位
			MOV DI, AX
			mPrint Notice26
			LEA DX, NAME_ARR[DI]
			CALL NAMEOUT
			CALL SPACE
			mPrint Notice33
			LEA DX, ID_ARR[DI]
			CALL NAMEOUT
			CALL CRLF
			POP AX
			PUSH AX
			MOV CX, 16; 16 个平时成绩
			MUL CX
			MOV SI, AX
			SHL SI, 1
			mPrint Notice37
			
		SPrint:
			MOV AX, SCORE_ARR[SI]
			CALL SCOREOUT
			CALL SPACE
			ADD SI, 2
			LOOP SPrint
			
			POP AX
			MOV SI, AX
			SHL SI, 1
			mPrint Notice38
			MOV AX, LAST_ARR[SI]
			CALL SCOREOUT
			CALL SPACE
			mPrint Notice34
			MOV AX, FINAL_ARR[SI]
			CALL SCOREOUT
			CALL CRLF
			CALL CRLF
			mPop_dsDCBA
			RET
	SHOW ENDP
	
	
	SCOREOUT PROC NEAR
			mPush_ABCD
			MOV BX, BUFREAR
			
			OR AX, AX; NUMBER IS IN AX
			JZ PRELOOPFIN0; 0
			;INT 3;调试手动断点
			MOV CL, 10
			DIV CL; (AL) = (AX) // 10 & (AH) = (AX) % 10
			;INT 3;调试手动断点
			PUSH AX
			PUSH AX
			CMP AH, 0
			JZ OUTLOOP1;如果没出现小数则跳转 OUTLOOP1
			
			ADD AH, '0'
			DEC BX
			MOV [BX], AH
			mBufInsert '.'
			OR AL, AL;引发标志位改变
			JNZ OUTLOOP1
			MOV AH, '0';处理 0.x 的情况
			DEC BX
			MOV [BX], AH
			JMP PRELOOPFIN1
		
		OUTLOOP1:
			XOR AH, AH;置零
			OR AL, AL;引发标志位改变
			JZ PRELOOPFIN1
			MOV CL, 10
			DIV CL
			ADD AH, '0'
			DEC BX
			MOV [BX], AH
			JMP OUTLOOP1
		
		PRELOOPFIN1:
			POP AX
			CMP AH, 0;重新判断
			JZ PRELOOPFIN2;如果没出现小数则跳转 PRELOOPFIN2
			
			CMP AH, 5;是否可以约去因子 5
			JZ PRELOOPFIN5
			
			TEST AH, 00000001B;保留最后一位，若为 0，则为偶数，执行跳转；否则为奇数，不执行跳转
			JZ PRELOOPFIN4
			
			mBufInsert ' '
			mBufInsert '>'
			mBufInsert '-'
			mBufInsert ' '
			mBufInsert '0'
			mBufInsert '1'
			mBufInsert ' '
			mBufInsert '/'
			mBufInsert ' '
			
			POP AX
			ADD AH, '0'
			DEC BX
			MOV [BX], AH
			JMP OUTLOOPFIN1
			
		PRELOOPFIN0:
			MOV AH, '0'
			DEC BX
			MOV [BX], AH
			JMP OUTLOOPFIN2
			
		PRELOOPFIN2:
			;INT 3;调试
			POP AX;栈平衡
			JMP OUTLOOPFIN2
		
		PRELOOPFIN4:
			JMP PRELOOPFIN8
			
		PRELOOPFIN5:
			mBufInsert ' '
			mBufInsert '>'
			mBufInsert '-'
			mBufInsert ' '
			mBufInsert '2'
			mBufInsert ' '
			mBufInsert '/'
			mBufInsert ' '
			
			POP AX
			PUSH CX
			MOV CX, AX
			AND CX, 7;将 CX 范围限定在 0~7 中
			CMP CX, 5;大于等于 5 则执行减 5 操作
			JB TMPLOOPFIN5
			SUB CX, 5
			
		TMPLOOPFIN5:
			ADD AH, 5
			LOOP TMPLOOPFIN5
			
			PUSH DX
			XOR DX, DX
			MOV CX, 5
			DIV CX
			POP DX
			POP CX
			ADD AH, '0'
			DEC BX
			MOV [BX], AH
			JMP OUTLOOPFIN5
			
		PRELOOPFIN8:
			mBufInsert ' '
			mBufInsert '>'
			mBufInsert '-'
			mBufInsert ' '
			mBufInsert '5'
			mBufInsert ' '
			mBufInsert '/'
			mBufInsert ' '
			
			POP AX
			TEST AL, 00000001B;如果是奇数，需要在 AH 上加 10，TEST 结果为 1；为 0 直接跳转
			JZ TMPLOOPFIN8
			ADD AH, 10
			;DEC AL;可减可不减
			
		TMPLOOPFIN8:
			SHR AX, 1;除以 2 即右移一位
			ADD AH, '0'
			DEC BX
			MOV [BX], AH
			JMP OUTLOOPFIN8
			
		OUTLOOPFIN1:;显示普通分数
			XOR AH, AH;置零
			OR AL, AL;引发标志位改变
			JZ OUTLOOPFINOUT
			MOV CL, 10
			DIV CL
			ADD AH, '0'
			DEC BX
			MOV [BX], AH
			JMP OUTLOOPFIN1
			
		OUTLOOPFIN2:
			JMP OUTLOOPFINOUT
			
		OUTLOOPFIN5:;约去 5 的分数
			XOR AH, AH;置零
			OR AL, AL;引发标志位改变
			JZ OUTLOOPFINOUT
			MOV CL, 10
			DIV CL
			ADD AH, '0'
			DEC BX
			MOV [BX], AH
			JMP OUTLOOPFIN5
			
		OUTLOOPFIN8:;约去 偶数 的分数
			XOR AH, AH;置零
			OR AL, AL;引发标志位改变
			JZ OUTLOOPFINOUT
			MOV CL, 10
			DIV CL
			ADD AH, '0'
			DEC BX
			MOV [BX], AH
			JMP OUTLOOPFIN8
		
		OUTLOOPFINOUT:
			MOV DX, BX;显示成绩
			MOV AH, 9
			INT 21H
			;INT 3;调试
			
			mPop_DCBA
			RET
	SCOREOUT ENDP
	
	
	NAMEOUT PROC NEAR
			PUSH AX
			MOV AH, 9
			INT 21H
			POP AX
			RET
	NAMEOUT ENDP
	
	
	DECOUT PROC NEAR
			mPush_ABCD
			MOV BX, BUFREAR
			CMP AX, 0
			JZ ZERO
			
		OUTLOOP:
			XOR AH, AH
			OR  AL, AL
			JZ	OUTLOOPFIN
			MOV CL, 10
			DIV CL
			ADD AH, '0'
			DEC BX
			MOV [BX], AH
			JMP OUTLOOP
			
		ZERO:
			MOV DL, '0'
			MOV AH, 2
			JMP DEEND
			
		OUTLOOPFIN:
			MOV DX, BX
			MOV AH, 9
			JMP DEEND
			
		DEEND:
			INT 21H
			mPop_DCBA
			RET
	DECOUT ENDP
	
	
	SORT PROC NEAR
			mCheckSum
			mPush_AD
			MOV P_REMINDER, 6;初始化计数
			mPrint Notice25
			CMP NUMBER, 1
			JE SHOW1
			CALL SORTSCORE
			CALL SHOWSORTED
			JMP OVER1
			
		SHOW1:
			CALL SHOWSCORE1
			
		OVER1:
			mPop_DA
			RET 
	SORT ENDP
	
	
	SORTSCORE PROC NEAR
			mPush_ABCDsd
			MOV CX, NUMBER
			PUSH CX; PROTECT CX
			LEA BX, SORTED
			XOR SI, SI
			XOR DX, DX
		LOOP0:
			MOV [BX + SI], DX
			INC DX
			INC SI
			INC SI
			LOOP LOOP0
			
			POP CX
			DEC CX
			
		LOOP1:
			MOV DI, CX
			XOR SI, SI
			
		LOOP2:
			MOV BX, SORTED[SI]
			SHL BX, 1
			MOV AX, FINAL_ARR[BX]
			
			MOV BX, SORTED[SI + 2]
			SHL BX, 1
			CMP AX, FINAL_ARR[BX]
			
			JGE CONTI
			MOV DX, SORTED[SI]
			XCHG DX, SORTED[SI + 2]
			MOV SORTED[SI], DX
		CONTI:
			INC SI
			INC SI
			LOOP LOOP2
			MOV CX, DI
			LOOP LOOP1
	
			mPop_dsDCBA
			RET
	SORTSCORE ENDP
	
	
	SHOWSORTED PROC NEAR
			mPush_ABCDs
			LEA BX, SORTED
			MOV CX, NUMBER
			XOR SI, SI
			
		SHOWLOOP:
			PUSH CX
			MOV SI, [BX]; BX 指向排好序的第一个地址
			MOV AX, SI
			CALL SHOW
			INC BX
			INC BX;字增加两次
			POP CX
			LOOP SHOWLOOP
			mPop_sDCBA
			RET
	SHOWSORTED ENDP
	
	
	SHOWSCORE1 PROC NEAR
			mPush_ABCDs
			mPrint Notice26
			XOR SI, SI
			MOV AX, SI
			CALL SHOW
			
			mPop_sDCBA
			RET
	SHOWSCORE1 ENDP
	
	
	AVERAGE PROC NEAR
			mCheckSum
			mPush_ABCs
			XOR AX, AX
			MOV CX, NUMBER
			;OR CX, CX;判断是否为 0，由于 mCheckSum 已过滤，因此可以注释
			;JZ ACCEND2
			LEA BX, FINAL_ARR
			XOR SI, SI
			PUSH CX
			
		ACCUMULATE1:
			ADD AX, [BX + SI]
			INC SI;一个字等于两个字节
			INC SI	
			LOOP ACCUMULATE1
			
			POP CX; NUMBER
			;INT 3;疑似出现除法错误，作出如下修正，下同
			CMP CX, 2
			JB ACCUMULATE2
			XOR DX, DX;记得置零，否则有不确定的 bug
			OR CX, CX;修改标志位，尽可能避免不确定的 bug
			DIV CX
			
		ACCUMULATE2:
			;INT 3;mPrint Breakpoint
			PUSH AX
			MOV AX, DX
			MOV DX, 10	
			MUL DX
			CMP CX, 2
			JB ACCUMULATE3
			XOR DX, DX;记得置零，否则有不确定的 bug
			OR CX, CX;修改标志位，尽可能避免不确定的 bug
			DIV CX
			
		ACCUMULATE3:
			CMP AX, 5;四舍五入
			JB ACCUMULATE4
			POP AX
			INC AX
			JMP NEXT2
			
		ACCUMULATE4:
			;INT 3
			POP AX
			
		NEXT2:
			mPrint Notice25
			mPrintC Notice32, 00000010B
			CALL SCOREOUT
			CALL CRLF
			mPop_sCBA
			RET
	AVERAGE ENDP
	
	
	HIGHEST PROC NEAR
			mCheckSum
			mPush_ABCs
			mPrint Notice25
			mPrintC Notice35, 00000010B
			PUSH CX
			MOV CX, NUMBER
			CMP CX, 1
			JA HNOTONLY
			CALL SHOWSCORE1
			mPrintC Notice46, 00000001B
			POP CX
			JMP HIGHFIN
			
		HNOTONLY:
			POP CX
			CALL SORTSCORE
			LEA BX, SORTED
			MOV CX, NUMBER
			XOR SI, SI
			MOV SI, [BX]
			SHL SI, 1
			MOV AX, FINAL_ARR[SI]
			CALL SCOREOUT
			
		HIGHFIN:
			CALL CRLF
			mPop_sCBA
			RET
	HIGHEST ENDP
	
	
	LOWEST PROC NEAR
			mCheckSum
			mPush_ABCs
			mPrint Notice25
			mPrintC Notice36, 00000100B
			PUSH CX
			MOV CX, NUMBER
			CMP CX, 1
			JA LNOTONLY
			CALL SHOWSCORE1
			mPrintC Notice46, 00000001B
			POP CX
			JMP LOWFIN
		LNOTONLY:
			CALL SORTSCORE
			XOR BX, BX
			LEA BX, SORTED
			MOV CX, NUMBER
			XOR SI, SI
		SHOWLOOP1:
			MOV SI, [BX]
			SHL SI, 1
			INC BX
			INC BX
			LOOP SHOWLOOP1
			MOV AX, FINAL_ARR[SI]
			CALL SCOREOUT
		LOWFIN:
			CALL CRLF
			mPop_sCBA
			RET
	LOWEST ENDP
	
	
	STATISTIC PROC NEAR
			mCheckSum
			mPush_ABCDs
			LEA BX, FINAL_ARR
			XOR SI, SI
			MOV CX, NUMBER
			XOR AX, AX
		STATISLOOP:
			MOV AX, [BX + SI]
			CMP AX, 600
			JB  ADDCOUNT0
			CMP AX, 700
			JB  ADDCOUNT1
			CMP AX, 800
			JB  ADDCOUNT2
			CMP AX, 900
			JB  ADDCOUNT3
			INC COUNT4
			JMP NEXT
			
		ADDCOUNT0:
			INC COUNT0
			JMP NEXT 
		ADDCOUNT1:
			INC COUNT1
			JMP NEXT
		ADDCOUNT2:
			INC COUNT2
			JMP NEXT
		ADDCOUNT3:
			INC COUNT3
			
		NEXT:
			INC SI
			INC SI
			LOOP STATISLOOP
			mPrint Notice25
			mPrintC Notice47, 00000100B
			mPrintB Notice27, 00000110B
			CALL SPACE
			MOV AX, WORD PTR COUNT0
			CALL DECOUT 
			CALL CRLF
			mPrintB Notice28, 00000001B
			CALL SPACE
			MOV AX, WORD PTR COUNT1
			CALL DECOUT 
			CALL CRLF
			mPrintB Notice29, 00000001B
			CALL SPACE
			MOV AX, WORD PTR COUNT2
			CALL DECOUT 
			CALL CRLF
			mPrintB Notice30, 00000010B
			CALL SPACE
			MOV AX, WORD PTR COUNT3
			CALL DECOUT 
			CALL CRLF
			mPrintB Notice31, 00000010B
			CALL SPACE
			MOV AX, WORD PTR COUNT4
			CALL DECOUT 
			CALL CRLF
			CALL CRLF
			mPop_sDCBA
			RET
	STATISTIC ENDP
	
	
	DATA_IN PROC NEAR
			PUSH AX
			mPrintB fInMsg, 00000001B
			m_getchar
			AND AL, 11011111B
			CALL CRLF
			CMP AL, 'Y'
			JE IN_GO
			POP AX
			RET
		IN_GO:
			POP AX
			CALL fOPEN
			CMP HANDLE, 1
			JE IN_FIN
			CALL fREAD
			CALL fCLOSE
			PUSH BX
			CALL DATA_CHECK
			POP BX
		IN_FIN:
			RET
	DATA_IN ENDP
	
	
	DATA_CHECK PROC NEAR;检验通过 BX 置零，否则置 1
			LEA BX, xxggyyds
			
			mCmp '_'
			mCmp 'x'
			mCmp 'x'
			mCmp 'g'
			mCmp 'g'
			mCmp 'y'
			mCmp 'y'
			mCmp 'd'
			mCmp 's'
			mCmp '!'
			mCmp '!'
			mCmp '!'
			mCmp ' '
			mCmp '$'
			
			CMP NUMBER, 100
			JA DATA_ERR
			
			XOR BX, BX
			JMP DATA_END
			
		DATA_ERR:
			mPrintC fCheckMsg, 00000100B
			mPrintC fWarnMsg, 00000100B
			;CALL SUSPEND
			XOR BX, BX
			INC BX
			JMP DATA_END
			
		DATA_END:
			RET
	DATA_CHECK ENDP
	
	
	DATA_OUT PROC NEAR
			mCheckSum
			
			PUSH AX
			mPrintB fOutMsg, 00000001B
			m_getchar
			AND AL, 11011111B
			CALL CRLF
			CMP AL, 'Y'
			JE OUT_GO
			POP AX
			RET
			
		OUT_GO:
			POP AX
			
			CALL fOPEN
			CMP HANDLE, 1
			JE OUT_FIN
			CALL fWRITE
			CALL fCLOSE
		OUT_FIN:
			RET
	DATA_OUT ENDP
	
	
	CRLF PROC NEAR
			mPush_AD
			MOV DL, 0DH
			MOV AH, 2
			INT 21H
			MOV DL, 0AH
			MOV AH, 2
			INT 21H
			mPop_DA
			RET
	CRLF ENDP
	
	
	SPACE PROC NEAR
			mPush_ABCD
			MOV CX, 5
			MOV DL, ' '
			MOV AH, 2
		printSpace:
			INT 21H
			LOOP printSpace
			mPop_DCBA
			RET
	SPACE ENDP
	
	
	CLEAR PROC NEAR
			mPush_ABCDs
			MOV AH, 15
			INT 10H
			XOR AH, AH
			INT 10H
			mPop_sDCBA
			RET
	CLEAR ENDP
	
	
	SUSPEND PROC NEAR
			PUSH AX
			mPrintC Any_Key, 10000010B
			MOV AH, 7
			INT 21H
			POP AX
			RET
	SUSPEND ENDP
	
	
	REWRITE PROC NEAR
			PUSH AX
			MOV AH, 0EH
			;MOV AL, 8
			;INT 10H
			MOV AL, ' '
			INT 10H
			MOV AL, 08h
			INT 10H
			POP AX
			RET
	REWRITE ENDP
	
	
	PRESHUTDOWN PROC NEAR
			CALL CLEAR
			mPrintC Notice48, 00000100B
			mPrintC Notice49, 00000100B
			m_getchar
			RET
	PRESHUTDOWN ENDP
	
	
	PREERROR PROC NEAR
			CALL CLEAR
			mPrintC Notice51, 00000100B
			m_getchar
			RET
	PREERROR ENDP
	
	
	PREREBOOT PROC NEAR
			CALL CLEAR
			mPrintC Notice48, 00000100B
			mPrintC Notice50, 00000100B
			m_getchar
			AND AL, 11011111B;转大写
			CMP AL, 'F'
			JE KR
			CMP AL, 'R'
			JE NR
			
		SR:
			RET
			
		KR:
			CALL kREBOOT
			JMP SR
		NR:
			CALL nREBOOT
			JMP SR
	PREREBOOT ENDP
	
	
	kSHUTDOWN PROC NEAR
			mPush_AD
			CALL CLEAR
			MOV AX, 2001H
			MOV DX, 1004H
			OUT DX, AX
			mPop_DA
			RET
	kSHUTDOWN ENDP
	
	
	nSHUTDOWN PROC NEAR
			mPush_ABCD
			Mov AX, 5301H
			XOR BX, BX
			INT 15H
			MOV AX, 530EH
			XOR BX, BX
			MOV CX, 102H
			INT 15H
			MOV AX, 5307H
			MOV BX, 1
			MOV CX, 3
			INT 15H;可能已被禁用
			mPop_DCBA
			RET
	nSHUTDOWN ENDP
	
	
	kREBOOT PROC NEAR
			mPush_AD
			CALL CLEAR
			MOV AL, 0FEH
			OUT 64H, AL
			mPop_DA
			RET
	kREBOOT ENDP
	
	
	nREBOOT PROC NEAR
			MOV AX, 0FFFFH
			PUSH AX
			XOR AX, AX
			PUSH AX
			RETF
	nREBOOT ENDP
	
	
	fCREATE PROC NEAR
			mPush_ABCD
			MOV HANDLE, 0;还原
			LEA DX, PATH; PATH 代表错建立的文件路径
			XOR CX, CX
			MOV AH, 3CH
			INT 21H
			MOV HANDLE, AX; HANDLE 表是保存的文件号，类型为 DW
            JNC FCT
			mPrintC fCreateMsg, 00000100B
			MOV HANDLE, 1
        FCT:
			mPop_DCBA
			RET
	fCREATE ENDP
	
	
	fOPEN PROC NEAR
			mPush_ABCD
			MOV HANDLE, 0;还原
			MOV DX, OFFSET PATH
			MOV AL, 00000010B
			MOV AH, 3DH
			INT 21H
			MOV HANDLE, AX
			JNC FOPE
			mPrintC fOpenMsg, 00000100B
			MOV HANDLE, 1
		FOPE:
			mPop_DCBA
			RET
	fOPEN ENDP
	
	
	fCLOSE PROC NEAR
			mPush_ABCD
			MOV BX, HANDLE
			MOV AH, 3EH
			INT 21H
			JNC CLF
			mPrintC fCloseMsg, 00000100B
		CLF:
			mPop_DCBA
			RET
    fCLOSE ENDP
	
	
	fREAD PROC NEAR
			mPush_ABCD
			MOV BX, HANDLE
			mSet PATH, 00010110B;可选
			mRead xxggyyds, DUMPLEN
			JC READ_ERR
			mPrint Notice53
			JMP READ_FIN
			
		READ_ERR:
			mPrintC fReadMsg, 00000100B
			;MOV READLEN, 0
			JMP READ_FIN
			
		READ_FIN:
			mPop_DCBA
			RET
	fREAD ENDP
	
	
	fWRITE PROC NEAR
			mPush_ABCD
			CALL DATA_CHECK
			OR BX, BX
			JNZ WRITE_FIN
			MOV BX, HANDLE
			mSet PATH, 00010110B;设置属性
			mWrite xxggyyds, DUMPLEN
			JC WRITE_ERR
			mPrint Notice54
			JMP WRITE_FIN
			
		WRITE_ERR:
			mPrintC fWriteMsg, 00000100B
			;MOV WRITELEN, 0
			JMP WRITE_FIN
			
		WRITE_FIN:
			mPop_DCBA
			RET
	fWRITE ENDP
	
	
	mPrintA PROC NEAR
			mLength
		mpc:
			PUSH CX
			XOR CX, CX
			INC CX
			MOV AH, 9
			MOV AL, [SI]; char
			INT 10h
			MOV AH, 3
			INT 10h
			MOV AH, 2
			INC DL
			INT 10H
			INC SI
			POP CX
			LOOP mpc
		RET
	mPrintA ENDP
	
	
	SSS_MORE_SSS PROC NEAR
			mPush_ABCD
			mPrintB Any_More, 00000010B
			m_getchar
			AND AL, 11011111B
			CMP AL, 'A'
			JE More_Page
			CMP AL, 'C'
			JE More_Cancel
			MOV P_REMINDER, 6
			JMP More_End
			
		More_Page:
			MOV P_REMINDER, 100;可认为无限大（因为最多也就只有 100 条记录）
			JMP More_End
		More_Cancel:
			MOV P_REMINDER, 0
			JMP More_End
			
		More_End:;清行
			CALL SSS_SPACE_SSS
			mPrintB Notice55, 00000000B
			CALL SSS_SPACE_SSS
			mPop_DCBA
			RET	
	SSS_MORE_SSS ENDP
	
	
	SSS_SPACE_SSS PROC NEAR
			MOV AH, 3
			XOR BH, BH
			INT 10H
			XOR DL, DL
			CMP AL, 0DH
			JE DECDH
			CMP AL, 0AH
			JE DECDH
			JMP DECEND
			
		DECDH:
			DEC DH
			JMP DECEND
			
		DECEND:
			MOV AH, 2
			INT 10H
			RET
	SSS_SPACE_SSS ENDP
codesg ENDS



END Start