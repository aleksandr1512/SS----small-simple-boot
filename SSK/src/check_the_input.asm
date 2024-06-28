%include "commands.asm"

check_the_input:
    inc bx
    mov byte [input+bx], 0    ; в конце ввода ставим ноль, означающий конец
                              ; стркоки (тот же '\0' в Си)
                              
	mov si, clear_command     ; в si загружаем заранее подготовленное слово clear
    mov bx, input             ; а в bx - сам ввод
    call compare_strs_si_bx   ; сравниваем si и bx (введено ли clear)

    cmp cx, 1                 ; compare_strs_si_bx загружает в cx 1, если
                              ; строки равны друг другу
    je clear  
    
                              ; текста call1
	mov si, call1_command      ; в si загружаем заранее подготовленное слово help
    mov bx, input             ; а в bx - сам ввод
    call compare_strs_si_bx   ; сравниваем si и bx (введено ли call1)

    cmp cx, 1                 ; compare_strs_si_bx загружает в cx 1, если
                              ; строки равны друг другу
    je call1  


    mov si, call2_command      ; в si загружаем заранее подготовленное слово call2
    mov bx, input             ; а в bx - сам ввод
    call compare_strs_si_bx   ; сравниваем si и bx (введено ли call2)

    cmp cx, 1                 ; compare_strs_si_bx загружает в cx 1, если
                              ; строки равны друг другу
    je call2  


	mov si, call3_command      ; в si загружаем заранее подготовленное слово call3
    mov bx, input             ; а в bx - сам ввод
    call compare_strs_si_bx   ; сравниваем si и bx (введено ли call3)

    cmp cx, 1                 ; compare_strs_si_bx загружает в cx 1, если
                              ; строки равны друг другу
    je call3  
    

    jmp equal_to_nothing      ; если не равны, то выводим "Wrong command!"

; done очищает всю переменную input
done:
    cmp bx, 0                 ; если зашли дальше начала input в памяти
    je exit                   ; то вызываем функцию, идующую обратно в mainloop

    dec bx                    ; если нет, то инициализируем очередной байт нулем
    mov byte [input+bx], 0

    jmp done                  ; и делаем то же самое заново

exit:
	ret
