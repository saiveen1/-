assume cs:code,ds:data

data segment
	db 'uNiX'
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	
	mov bx,0
	mov cx,4
	
s:
	mov al,ds:[bx]
	and al,11011111
	mov ds:[bx],al
	inc bx
	
	mov ax,4c00h
	int 21h
code ends
end start