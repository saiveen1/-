assume cs:codesg

codesg segment

start: 
	mov ax,0123h
	mov bx,0456h
	add ax,bx
	add ax,ax
	
	mov ax,4c00h
	int 21h
	
codesg ends

end start 