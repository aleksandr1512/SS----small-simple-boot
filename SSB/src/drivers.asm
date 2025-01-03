print:						;функция вывода
    push ax

    mov ah, 0x0e
    call print_next_char

    pop ax
    ret

print_next_char:
    mov al, [si]
    cmp al, 0

    jz exit

    int 0x10
    inc si

    jmp print_next_char



get_input:					;функция получения ввода
    mov bx, 0

input_processing:
    mov ah, 0x0
    int 0x16

    cmp al, 0x0d
    je exit

    cmp al, 0x8
    je backspace_pressed

    cmp al, 0x3
    je stop_cpu

    mov ah, 0x0e

    int 0x10

    mov [buffer+bx], al
    inc bx

    cmp bx, 64
    je exit

    jmp input_processing

stop_cpu:
    mov si, shutdown_text
    call print

    jmp $

backspace_pressed:
    cmp bx, 0
    je input_processing

    mov ah, 0x0e
    int 0x10

    mov al, ' '
    int 0x10

    mov al, 0x8
    int 0x10

    dec bx
    mov byte [buffer+bx], 0

    jmp input_processing


compare_strs:
    push si                   ; сохраняем все нужные в функции регистры на стеке
    push bx
    push ax

comp:
    mov ah, [bx]              ; напрямую регистры сравнить не получится,
    cmp [si], ah              ; поэтому переносим первый символ в ah
    jne not_equal             ; если символы не совпадают, то выходим из функции

    cmp byte [si], 0          ; в обратном случае сравниваем, является ли символ
    je first_zero             ; символом окончания строки

    inc si                    ; переходим к следующему байту bx и si
    inc bx

    jmp comp                  ; и повторяем

first_zero:
    cmp byte [bx], 0          ; если символ в bx != 0, то значит, что строки
    jne not_equal             ; не равны, поэтому переходим в not_equal

    mov cx, 1                 ; в обратном случае строки равны, значит cx = 1

    pop si                    ; поэтому восстанавливаем значения регистров
    pop bx
    pop ax

    ret                       ; и выходим из функции

not_equal:
    mov cx, 0                 ; не равны, значит cx = 0

    pop si                    ; восстанавливаем значения регистров
    pop bx
    pop ax

    ret                       ; и выходим из функ


check_the_input:
    inc bx
    mov byte [buffer+bx], 0    ; в конце ввода ставим ноль, означающий конец
                              ; стркоки (тот же '\0' в Си)

    mov si, ax             ; в si загружаем заранее подготовленное слово help
    mov bx, buffer             ; а в bx - сам ввод
    call compare_strs
	
   
  
exit:
	ret

done:
    cmp bx, 0                 ; если зашли дальше начала input в памяти
    je exit                   ; то вызываем функцию, идующую обратно в mainloop

    dec bx                    ; если нет, то инициализируем очередной байт нулем
    mov byte [buffer+bx], 0

    jmp done                  ; и делаем то же самое заново
