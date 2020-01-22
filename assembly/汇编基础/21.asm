assume cs:codesg,ds:datasg,ss:stacksg

stacksg segment
dw 0,0,0,0,0,0,0,0
stacksg ends

datasg segment
	db '1.display       '
	db '2.brows         '
	db '3.replace       '
	db '4.modify        '
datasg ends

codesg segment
start:

	mov ax,datasg
	mov ds,ax

	mov bx,2
	mov si,0
	mov cx,4

s:
	push cx
	mov bx,2
	s2:
		mov al,ds:[si+bx]
		and al,11011111b
		mov [si+bx],al
		inc bx
		loop s2
	
	pop cx
	add si,10h
	loop s
	
	mov ax,4c00h
	int 21h
codesg ends
end start