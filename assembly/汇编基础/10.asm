assume cs:codesg
codesg segment

start:
	mov ax,cs ;因为是复制指令 所以理所应当ds段和cs段应该对应地址
	mov ds,ax
	mov ax,0020h ;物理地址 = 20h*16 = 200H就是要复制到的地址
	mov es,ax	;用另一个数据寄存器来存储指令代码
	mov bx,0
	mov cx,17h   ; 这里的理解还是没错的 就是结束指令之前总共的字节
;答案是17H即23字节 最简单的debug一步步调试知道多大 
;这里猜测寄存器间的赋值2bytes 否则3b
s:
	mov al,[bx]	;一次传输一个字节 低八位
	mov es:[bx],al
	inc bx
	loop s
	
	mov ax,4c00h
	int 21h

codesg ends

end start