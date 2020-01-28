assume cs:codesg,ds:datasg

datasg segment
db 10 dup(0)
datasg ends

codesg segment
start:
	mov ax,12666
	mov bx,datasg
	mov ds,bx
	mov si,0
	call dtoc
	
	mov dh,8
	mov dl,3
	mov cl,2
	
	call show_str
	mov ax,4c00h
	int 21h

	dtoc:
		mov dx,0	;初始化
		mov bx,0ah
		div bx
		add dx,30h
		mov ds:[si],dl
		mov dx,0
		inc si
		mov cx,ax
		jcxz finsh
		jmp short dtoc
		
		finsh:
			mov dx,si
			mov cx,dx
			mov si,0
			s1:
				mov bl,ds:[si]	;栈一次传一个字节
				push bx
				inc si
				loop s1
			mov cx,dx
			mov si,0
			s2:
				pop ds:[si]
				inc si
				loop s2
			ret
		
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