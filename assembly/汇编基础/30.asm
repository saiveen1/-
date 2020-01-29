assume cs:codesg,ds:datasg,ss:stack

datasg segment
dw 8 dup(0)
datasg ends

stack segment
dw 16 dup(0)
stack ends

codesg segment
start:
	mov ax,614eh
	mov dx,0bch
	mov bx,datasg
	mov ds,bx
	mov bx,0
	mov si,0e0h
	mov di,0
	mov sp,32
	call dtoc
	
	mov dh,8
	mov dl,3
	mov cl,2
	call show_str
	
	mov ax,4c00h
	int 21h
	
dtoc:
	psi:
		push si
	re:	
		mov cx,0ah
		call div_plus	;执行完后cx为余数 ax低位 dx高位
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
codesg ends
end start