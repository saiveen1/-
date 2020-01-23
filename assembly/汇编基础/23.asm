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
	db 2 dup (0)
stack ends

codeseg segment
start:
	mov ax,data
	mov ds,ax
	mov ax,table
	mov es,ax
	MOV AX,STACK
	MOV SS,AX
	
	mov bx,0
	mov di,0
	mov cx,21
	
s:
	push cx
	mov cx,10h
	
	s2:
		mov al,ds:[bx]
		mov es:[di+bx],al	;年份
		
		mov al,ds:[54h+bx]	;收入
		mov es:[di+bx+5H],al

		mov di,0
			
		mov al,ds:[bx+0a4h]
		mov es:[di+bx].7h,al	;总人数
		
		mov ax,es:[di+5h]
		mov dx,es:[di+7h]
		div word ptr es:[di+0ah]	;人均
		mov es:[di+bx].0dh,ah
		mov es:[di+bx].0eh,al
		
		MOV AL,20H
		mov es:[di+4h],AL
		mov es:[di+9h],AL
		mov es:[di+0ch],AL
		mov es:[di+0fh],AL
		inc bx
		loop s2
		
		add di,10h
		pop cx
	

	mov ax,4c00h
	int 21h

codeseg ends
end start


















