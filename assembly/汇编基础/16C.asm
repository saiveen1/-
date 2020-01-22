assume cs:code

a segment
	db 1,2,3,4,5,6,7,8
a ends

b segment
	db 1,2,3,4,5,6,7,8
b ends

d segment
	db 0,0,0,0,0,0,0,0
d ends

code segment
start:
	mov ax,d
	mov ss,ax	;sp 24-16 a段
				;sp 16-8 b段
	mov ax,a
	mov ds,ax
	mov ax,b
	mov es,ax
	
	mov sp,8
	mov bx,6
	mov cx,4

s:
	mov ax,es:[bx]
	add ds:[bx],ax
	push ds:[bx] ;sp指向8 栈底为高位 实际最后是反着的
	sub bx,2
	loop s
	
	mov ax,4c00h
	int 21h

code ends	

end start