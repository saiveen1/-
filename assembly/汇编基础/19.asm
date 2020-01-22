assume cs:codesg,ds:datasg

datasg segment
	db '1.file          '
	db '2.edit          '
	db '3.search        '
	db '4.view          '
	db '5.options       '
datasg ends
;其实完全可以写成分段形式 a b d e f g这种 不过书写起来比较麻烦
;参考16asm的笔记

codesg segment
start:

	mov ax,datasg
	mov ds,ax

	mov bx,2
	mov di,0
	mov cx,5

s:
	mov al,ds:[di+bx]
	and al,11011111b
	mov ds:[di+bx],al
	add di,10h
	
	loop s
	
	mov ax,4c00h
	int 21h
codesg ends
end start