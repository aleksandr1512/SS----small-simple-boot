call1_command: db "call1", 0
call2_command: db "call2", 0
call3_command: db "call3", 0
clear_command: db "clear", 0


equal_to_nothing:    
    jmp done

clear:
	mov ah, 0x00
	mov al, 0x03
	int 0x10

	jmp done


;свои команды запускаються на call1,2,3
call1:
	;ваш код
	jmp done
call2:
	;ваш код
	jmp done
	;ваш код
call3:
	jmp done
