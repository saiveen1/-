assume cs:code, ds:data, ss:stack

data segment
	db 'Welcome to Masm!'
data ends

stack segment
	dw 2 dup(0)
stack ends

code segment
start:
	
	mov ax,0b800h
	mov ds,ax	
	mov ax,data  
	mov es,ax
	mov ax,stack
	mov ss,ax
	
	mov si,780h
	mov bx,0
	mov di,0
	mov cx,3h

s:
	push cx
	mov cx,10h
	
	s2:  
	  mov al,es:[di]  
	  mov ah,71h
	  mov ds:[bx+si+40h],ax
	  add si,2
	  inc di
	loop s2
	
	add bx,0a0h
	pop cx
loop s
	
	mov ax,4c00h
	int 21h
code ends

end start