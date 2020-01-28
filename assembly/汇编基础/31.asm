assume cs:codesg,ds:datasg,es:table,ss:stack

datasg segment
	db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983'
	db '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992'
	db '1993', '1994', '1995' 

	dd 16, 22, 382, 1356, 2390, 8000, 16000, 24486, 50065, 97479, 140417, 197514
	dd 345980, 590827, 803530, 1183000, 1843000, 2759000, 3753000, 4649000, 5937000

	dw 3, 7, 9, 13, 28, 38, 130, 220, 475, 778, 1001, 1442, 2258, 2793, 4037, 5635, 8226
	dw 11542, 14430, 15257, 17800
datasg ends

table segment
	db 21 dup('year    summ        nn      ave ')
table ends

stack segment
	dw 8 dup(0)
stack ends

codesg segment
start:
	mov ax,datasg
	mov ds,ax
	mov ax,table
	mov es,ax
	mov ax,stack
	mov ss,ax
	mov sp,16
	mov bx,0
	mov cx,21
	mov dx,0
	mov si,0
	mov di,0
	
	call s21
	
	mov ax,es
	mov ds,ax
	mov dx,0200
	mov cl,70h
	
	mov ax,4c00h
	int 21h
	
s21:
	push cx
	mov cx,2
	
	s21_2:
		mov ax,ds:[si]
		mov es:[bx+di],ax
		add si,2
		add di,2
		mov ax,ds:[si]
		mov es:[bx+di],ax
	loop s21_2
	
	mov ax,ds:[si+50h]	;第一次结束为4
	mov dx,ds:[si+52h]
	push si
	
	mov cx,2
	push cx
	to_char:	;传入总收入和人数
		jcxz avg
		mov si,0e0			;空闲内存
		push si
		call dtoc
		
		mov cx,4		
		pop si			;line 60
		s21_4:
			mov ax,ds:[si]
			mov es:[bx+di+5],ax
			
			add si,2
			add di,2
		loop s21_8
		
		pop cx		;line 56
		pop si		;line 53
		mov ax,ds:[si+0a4h]
		mov dx,dx:[si+0a6h]
		add di,4
		dec cx
		jmp short to_char
		
	avg:	;di 20 si 4
		mov ax,ds:[si+50h]	;第一次结束为4
		mov dx,ds:[si+52h]
		div word ptr ds:[0a4h]
		mov es:[bx+di+9h]
		
	pop cx	;line 39
	add bx,20h
loop s21
ret
		
dtoc:
	mov cx,0ah
	call div_plus	;执行完后cx为余数 ax低位 dx高位
	add cx,30h
	mov ds:[si],cl
	inc si
	
	mov cx,ax	;判断最后一位
	jcxz finsh
jmp short dtoc
	
	finsh:
		mov dx,si
		mov cx,si
		sub si,dx
		s1:
			mov al,ds:[si]	;栈一次传一个字节
			push ax
			inc si
		loop s1
		
		mov cx,dx
		sub si,dx
		
		s2:
			pop ds:[si]
			inc si
		loop s2
	ret
		
div_plus:
	push ax
	push cx
	mov cx,dx
	jcxz divd
	pop cx
	mov ax,dx
	mov dx,0
	div cx
	
	mov bx,ax	;商高位
	pop ax
	div cx
	mov cx,dx	;输出结果
	mov dx,bx
	
	div_ends:
	ret
	
	divd:
		pop cx
		pop ax
		div cx
		mov cx,dx
		mov dx,0
	jmp short div_ends
	
show_str:
	mov ax,0b800h
	mov es,ax
	mov bh,dh
	mov bl,dl
	
	mov ax,0a0h
	mul bh	
	mov si,ax	;行
	
	mov ax,2
	mul bl	
	mov di,ax	;列
	
	add si,di
	mov bx,si
	mov si,0
	mov di,0

	s:	
		push cx
		mov cl,ds:[si]
		jcxz ok
		
		mov al,ds:[si]	;字符及属性
		pop cx
		mov ah,cl
		mov es:[bx+di],ax
		inc si
		add di,2
	jmp short s

	ok:
		pop cx
	ret
codesg ends
end start