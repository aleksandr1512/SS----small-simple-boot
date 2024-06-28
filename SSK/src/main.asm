org 0x7c00
bits 16

jmp start                     ; сразу переходим в start

%include "print_string.asm"
%include "str_compare.asm"
%include "input_processing.asm"
%include "config.asm"
%include "user_input.asm"

; ====================================================

start:
    cli                                ; запрещаем прерывания, чтобы наш код 
                                       ; ничто лишнее не останавливало

	mov ah, 0x00
	mov al, 0x03
	int 0x10
    
    mov sp, 0x7c00            ; инициализация стека

    mov si, greetings         ; печатаем приветственное сообщение
    call print_string_si      ; после чего сразу переходим в mainloop
	call on_start

mainloop:
	call always
    mov si, prompt            ; печатаем стрелочку
    call print_string_si

    call get_input            ; вызываем функцию ожидания ввода
    	
	mov si, new_line          ; печатаем символ новой строки
    call print_string_si

	call check_the_input

    jmp mainloop              ; повторяем mainloop...


    
input: times 64 db 0          ; размер буффера - 64 байта


times 510 - ($-$$) db 0
dw 0xaa55
