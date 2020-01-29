assume cs:codesg,ds:datasg,es:table,ss:stack

datasg segment
	db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983'
	db '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992'
	db '1993', '1994', '1995' 

	dd 16, 22, 382, 1356, 2390, 8000, 16000, 24486, 50065, 97479, 140417, 197514
	dd 345980, 590827, 803530, 1183000, 1843000, 2759000, 3753000, 4649000, 5937000

	dw 3, 7, 9, 13, 28, 38, 130, 220, 475, 778, 1001, 1442, 2258, 2793, 4037, 5635, 8226
	dw 11542, 14430, 15257, 17800
	dw 16 dup(0)
datasg ends

table segment
	db 21 dup('year    summ        nn      ave ')
table ends

stack segment
	dw 16 dup(0)
stack ends

codesg segment
start:
	mov ax,datasg
	mov ds,ax
	mov ax,table
	mov es,ax
	mov ax,stack
	mov ss,ax
	mov sp,32
	mov bx,0
	mov cx,21
	mov dx,0
	mov si,0
	
	call s21
	
	mov ax,es
	mov ds,ax
	mov dh,0	;行
	mov dl,0
	mov cl,7h
	mov ch,0
	call show_list

	
	mov ax,4c00h
	int 21h
	
s21:
	push cx		;!!!!!!!!!!!!!!
	mov cx,4
	mov di,0
	
	s21_4_1:
		mov al,ds:[si]
		mov es:[bx+di],al
		inc si
		inc di
	loop s21_4_1
	
	call salary
	
	mov cx,2
	to_char:	;传入总收入和人数
		push si   ;!!!!!!!!!!!!!!
		jcxz avg
		mov si,0e0h			;空闲内存
		push cx  ;!!!!!!!!!!!!!!
		call clean
		
		call dtoc
		mov cx,4		
		s21_4_2:
			mov ax,ds:[si]
			mov es:[bx+di+4],ax
			
			add si,2
			add di,2
		loop s21_4_2
		
		pop cx		;line 68
		pop si		;line 53
		
		push cx
		call half
		mov cx,si
		mov si,ax
		
		mov ax,ds:[si+0a6h]
		mov si,cx
		pop cx
		
		mov dx,0h
		add di,4
		dec cx
		jmp short to_char
		
	avg:	;di 1c si 15
		call half
		
		mov cx,ax	;人数在ds占两个字节
		call salary
		mov si,cx
		div word ptr ds:[si+0a6h]
		mov dx,0
		mov si,0e0h
		call clean
		call dtoc
		
		mov ax,ds:[si]
		mov es:[bx+di],ax
		mov ax,ds:[si+2]
		mov es:[bx+di+2],ax
		pop si ;!!!!!!!!!!!!!!
	pop cx	;line 39
	add bx,20h
loop s21
ret

show_list:
	mov ax,cx
	mov cx,21
	mov bx,0
	SL_21:
		push cx
		mov cx,31	;20h个数据是32 最后一个为0
		mov si,0
		
		SL_21_31:
			push cx
			mov cl,ds:[bx+si]
			jcxz space
		continue:
			inc si
			pop cx	;3数据循环
		loop SL_21_31
		
		mov cl,al
		inc dh
		mov si,bx
		push ax
		push bx
		call show_str
		pop bx
		pop ax
		add bx,20h
		
		pop cx	;行循环cx
		
	loop SL_21
ret

space:
	push ax
	mov ax,20h
	mov ds:[bx+si],al
	pop ax
	jmp short continue	


salary:
	mov ax,ds:[si+50h]	;第一次结束为4
	mov dx,ds:[si+52h]
ret
dtoc:
	psi:
		push si
	re:	
		mov cx,0ah
		push bx
		call div_plus	;执行完后cx为余数 ax低位 dx高位
		pop bx
		add cx,30h
		mov ds:[si],cl
		inc si
		mov cx,ax	;判断最后一位
		jcxz finsh
	jmp short re
	
	finsh:
		mov cx,si	
		pop si		
		sub cx,si
		mov dx,si 
		s1:
			mov al,ds:[si]	;栈一次传一个字节
			push ax
			inc si
		loop s1
		mov cx,si
		sub cx,dx
		mov si,dx
		s2:
			pop ds:[si]
			inc si
		loop s2
		mov si,dx
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
	push si
	mov si,ax	;行
	
	mov ax,2
	mul bl	
	mov di,ax	;列
	
	add si,di
	mov bx,si
	pop si
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

clean:	;使用ax si
	push ax
	push cx
	push si
	mov cx,8
	s_c:
		mov ax,0
		mov ds:[si],ax
		inc si
	loop s_c
	pop si
	pop cx
	pop ax
	ret
	
half:
	mov ax,si
	mov dx,0
	mov cx,2
	div cx
ret

codesg ends
end start