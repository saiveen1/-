assume cs:codesg,ds:datasg

datasg segment
	db 'ibm             '
	db 'dec             '
	db 'dos             '
	db 'vax             '
datasg ends

codesg segment
start:

	mov ax,datasg
	mov ds,ax

	mov bx,0
	mov si,0
	mov cx,4

s:
	mov dx,cx
	mov cx,3
	mov bx,0
	s2:
		mov al,ds:[si+bx]
		and al,11011111b
		mov [si+bx],al
		inc bx
		loop s2
	
	mov cx,dx
	add si,10h
	loop s
	
	mov ax,4c00h
	int 21h
codesg ends
end start