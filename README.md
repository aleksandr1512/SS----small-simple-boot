# SSK---small-simple-kernel
## **Описание**
Это простейшее ядро на ассемблер nasm с открытым исходным кодом с помощью которого можно написать свою полноценную ОС
## **Установка и использование**
вы сразу можете запустить ядро(SSK/bin/kernel.bin) через любой загрузчик по типу **GRUB**,
или запустить вс через эмулятор такой как **qemu**

Команда запуска ядра через qemu:
```bash
qemu-system-i386 kernel.bin -monitor stdio
```
Но функцианал выходит давольно слабым,
Я предлагаю скачать исходники из папки src, самому добавить свои функции,
и в итоге скомпилировать ядро самому!

Для начала разберёмся какие и зачем нужны файлы:

`config.asm` - здесь прописаны все тексты которые пояфляются в системе(приветствие, прощание, вид стрелочки в командной строке).
Также в этом файле есть две функции `on_start` и `always`, первая функция выполняет ваш код на ассемблере при запуске системы.
Вторая соответственно выполняет код постоянно.

также в нём написаны все функции
Например:
```assembler
call1_command: db "call1", 0
```
И сам код команды:
``` assembler
call1:
	;ваш код
	jmp done
```
Функция done обеспечивает выхот из команды/под-программы.


Что бы добавить свою команду написаную в config.asm нужно в метке `always` написать следуйщий код:
Для примера возьмём рание использоваемую в примере команду `call1`:
``` assembler
    mov ax, call1_command           
    call check_the_input  

    cmp cx, 1
    je call1  
```

буффером в ядре считается метка `buffer`, в неё записывается весь пользовательский ввод.
функция `done` отчищает `buffer`

мы написали свои функции и команды для ядра, перейдём к компиляции.

Но перед этим давайте разберёмся в других файлах:
`main.asm` - главный файл ядра.
В файле `func.asm` написаны функции для работы с процессором из под ядра.

список функций:
`print` - вывод в терминал, аргумент(текст для вывода) записывается в регистр si.
`get_input` - получение даных от пользователя(то, что ввёл пользователь записывается в буффер input)
`compare_strs` - сравнение строк(регистры si,bx - строки которые хотим сравнить, cx - результат сравнения, 1 - строки одинаковы, 0 - разные)
`check_the_input` - тот же `compare_strs` но сразу сравнивает `buffer` со значением из регистра ax.


Вернёмся к компиляции и скомпилируем ядро:
```
nasm -f bin main.asm -o kernel.bin
```
