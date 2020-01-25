assume cs:codeseg,ds:data,es:table,ss:stack
data segment
	db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983'
	db '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992'
	db '1993', '1994', '1995' 

	dd 16, 22, 382, 1356, 2390, 8000, 16000, 24486, 50065, 97479, 140417, 197514
	dd 345980, 590827, 803530, 1183000, 1843000, 2759000, 3753000, 4649000, 5937000

	dw 3, 7, 9, 13, 28, 38, 130, 220, 475, 778, 1001, 1442, 2258, 2793, 4037, 5635, 8226
	dw 11542, 14430, 15257, 17800
data ends

table segment
	db 21 dup ('year summ ne ?? ')
table ends

stack segment
	DW 2 dup (0)
stack ends

codeseg segment
start:
	mov ax,data
	mov ds,ax
	mov ax,table
	mov es,ax
	MOV AX,STACK
	MOV SS,AX
	MOV SP,4
	
	mov bx,0
	mov di,0
	mov cx,21
	mov si,0	;si在ds中控制年份收入的数据
	
s:
	push cx	;控制外循环cx的值
	mov cx,4h
	push di	;di控制ds中数据走向 而循环结束永远为4
	mov di,0	;所以在总人数的时候需要恢复其值 
	s2:
		mov al,ds:[si]	
		mov es:[bx+di],al	;年份
		mov al,ds:[si+54h]	
		mov es:[bx+di+5H],al	;收入
		inc si
		inc di
	loop s2
	
	pop di
	mov ax,ds:[di+0a8h]
	mov es:[bx].0ah,ax	;总人数
	
		
	mov ax,es:[bx+5h]
	mov dx,es:[bx+7h]
	div word ptr es:[bx+0ah]	;人均
	mov es:[bx].0dh,ax

	add bx,10h
	add di,2h	;人数两个字节
	pop cx
	
LOOP S

	mov ax,4c00h
	int 21h

codeseg ends
end start


















