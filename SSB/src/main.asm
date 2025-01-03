org 0x7c00
bits 16

jmp start 

%include "func.asm"
%include "config.asm":"

start:
	mov ah, 0x00        
    mov al, 0x03
    int 0x10

    mov sp, 0x7c00 

	call on_start

mainloop:	
    mov si, prompt            ; печатаем стрелочку
    call print

	
    call get_input            ; вызываем функцию ожидания ввода

	
    mov si, new_line          ; печатаем символ новой строки
    call print

    mov si, new_line          ; печатаем символ новой строки
    call print

    jmp mainloop
    
buffer: times 64 db 0          

times 510 - ($-$$) db 0
dw 0xaa55
