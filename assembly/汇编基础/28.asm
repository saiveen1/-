assume cs:codesg,ss:stack

stack segment
	dw 8 dup(0)
stack ends

codesg segment
start:
	mov ax,stack
	mov ss,ax
	mov sp,16
	mov ax,4240h
	mov dx,0fh
	mov cx,0ah
	
	call divdw	;第一个入栈的是ip
	mov ax,4c00h
	int 21h
	
divdw:
	push ax
	mov ax,dx
	mov dx,0
	div cx	;/ ax为X/N的商1 cx为第一个除的余数5
	push cx
	mov si,dx
	mov cx,2h
	mov bx,ax
	xn:
		mov ax,1h	;自行定义的dd高位 因为乘法为16位操作
		mul bx	;1 * ax为INT*10000的低位0000 dx为高位1
		mov dx,ax
		mov ax,0000h	;dx高16位  ax 低16位
		
		mov bx,si		;2 * ax为REM*10000的低位0000 dx为高位5
		push dx
		loop xn
		
	pop dx	;rem* dx
	pop si	;int* dx
	pop cx
	pop ax	;原始ax
	div cx
	mov dx,si
	ret

codesg ends
end start