assume cs:cdsg

cdsg segment

start:
	mov ax,20h
	mov ds,ax
	xor bx,bx
	mov cx,64
	
s:
	mov [bx],bl
	inc bl
	loop s

	mov ax,4c00h
	int 21h
	
cdsg ends

end start