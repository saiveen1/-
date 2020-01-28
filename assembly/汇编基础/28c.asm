assume cs:codesg,ss:stack

stack segment
	dw 8 dup(0)
stack ends

codesg segment
start:
	mov ax,stack
	mov ss,ax
	mov sp,16
	mov ax,68b1h
	mov dx,3adeh
	mov cx,0ffffh
	
	call divdw	;第一个入栈的是ip
	mov ax,4c00h
	int 21h
	
divdw:
	push ax
	mov ax,dx
	mov dx,0
	div cx	;/ ax为X/N的商1 dx为余数5
	
	mov bx,ax	;商高位
	pop ax
	div cx
	mov cx,dx
	mov dx,bx
	ret
codesg ends
end start