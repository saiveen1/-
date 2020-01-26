assume cs:code, ds:data, ss:stack

data segment
	db 'Welcome to Masm!'
data ends

stack segment
	dw 0,24h,71h
stack ends

code segment
start:
	
	mov ax,0b800h
	mov ds,ax	
	mov ax,data  
	mov es,ax
	mov ax,stack
	mov ss,ax
	
	mov bx,0
	mov cx,3h
	mov dx,02h
	mov sp,2
s:
	push cx
	mov cx,10h
	mov di,0
	mov si,780h
	
	s2:  
	  mov al,es:[di]  
	  mov ah,dl
	  mov ds:[bx+si+40h],ax
	  add si,2
	  inc di
	loop s2
	
	add bx,0a0h
	pop cx
	pop dx
loop s
	
	mov ax,4c00h
	int 21h
	
code ends
end start