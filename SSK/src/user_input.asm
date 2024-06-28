get_input:
    mov bx, 0                 ; инициализируем bx как индекс для хранения ввода

input_processing:
    mov ah, 0x0               ; параметр для вызова 0x16
    int 0x16                  ; получаем ASCII код

    cmp al, 0x0d              ; если нажали enter
    je exit                   ; то вызываем функцию, в которой проверяем, какое
                              ; слово было введено

    cmp al, 0x8               ; если нажали backspace
    je backspace_pressed

    cmp al, 0x3               ; если нажали ctrl+c
    je stop_cpu

    mov ah, 0x0e              ; во всех противных случаях - просто печатаем
                              ; очередной символ из ввода
    int 0x10

    mov [input+bx], al        ; и сохраняем его в буффер ввода
    inc bx                    ; увеличиваем индекс

    cmp bx, 64                ; если input переполнен
    je exit                   ; то ведем себя так, будто был нажат enter

    jmp input_processing      ; и идем заново

stop_cpu:
    mov si, goodbye           ; печатаем прощание
    call print_string_si

    jmp $                     ; и останавливаем компьютер
                              ; $ означает адрес текущей инструкции

backspace_pressed:
    cmp bx, 0                 ; если backspace нажат, но input пуст, то
    je input_processing       ; ничего не делаем

    mov ah, 0x0e              ; печатаем backspace. это значит, что каретка
    int 0x10                  ; просто передвинется назад, но сам символ не сотрется

    mov al, ' '               ; поэтому печатаем пробел на том месте, куда
    int 0x10                  ; встала каретка

    mov al, 0x8               ; пробел передвинет каретку в изначальное положение
    int 0x10                  ; поэтому еще раз печатаем backspace

    dec bx
    mov byte [input+bx], 0    ; и убираем из input последний символ

    jmp input_processing


