assume cs:code, ds:data

data segment
	db 'Welcome to Masm!',0
data ends

code segment
start:
	mov dh,8
	mov dl,3
	mov cl,2
	mov ax,data
	mov ds,ax
	mov si,0
	call show_ptr
	
	mov ax,4c00h
	int 21h
show_ptr:
	mov ax,0b800h
	mov es,ax
	
	mov ax,0a0h
	mov bl,dh
	mul bx	
	mov si,ax	;行
	
	mov ax,2
	mov bl,dl
	mul bx	
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
	
code ends
end start