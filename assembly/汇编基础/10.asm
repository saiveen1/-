assume cs:codesg
codesg segment

start:
	mov ax,1e ;因为物理地址0:200H实际为200H 根据段地址*16+偏移地址
	mov ds,ax	;段地址应为1e    1e0H+20H = 200H
	mov ax,0020h
	mov es,ax
	mov bx,0
	mov cx,    ;

s:
	mov al,[bx]
	mov es:[bx],al
	inc bx
	loop s
	
	mov ax,4c00h
	int 21h

codesg ends

end start