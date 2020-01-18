;----------------------------------------
;将内存FFFF:0 B中的数据拷贝到0:200 20B中
;----------------------------------------


assume cs:cdsg

cdsg segment

start:
	mov bx,0
	mov cx,12
	
s:
	mov ax,0ffffh
	mov ds,ax
	mov dl,[bx]	;dl是dx的低八位
	mov ax,0020h
	mov ds,ax
	mov [bx],dl
	inc bx
	loop s
	
	mov ax,4c00h
	int 21h
	
cdsg ends

end start
	