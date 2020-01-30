assume cs:code
code segment
start:
	
	mov ax,1000h
	mov bx,2000h
	cmp ah,bh
	je double
	jne ahbh

des:
	mov ax,4c00h
	int 21h

double:
	add ah,ah
	jmp short des

ahbh:
	add ah,bh
	jmp short des

code ends
end start