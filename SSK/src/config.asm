%include "custom.asm"

; 0x0d - символ возварата картки, 0xa - символ новой строки
greetings: db "The kernel is on.", 0x0d, 0xa, 0xa, 0
goodbye: db 0x0d, 0xa, "kernel is off", 0x0d, 0xa, 0
prompt: db "|$|>", 0
new_line: db 0x0d, 0xa, 0

on_start:	; код запускающийся при старте
	;ваш код и/или вызов функций из custom.asm
	ret
always:		;код работающий в mainloop
	;ваш код и/или вызов функций из custom.asm
	ret
