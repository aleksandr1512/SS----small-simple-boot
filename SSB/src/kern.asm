org 0x7c00
bits 16

%include "func.asm"
txt: db "start", 0

main_void:
	mov si, txt
	call printw
