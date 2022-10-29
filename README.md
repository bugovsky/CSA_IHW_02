# ИДЗ № 2. Жуковский Дмитрий Романович БПИ219. Вариант 4 

## Условие задачи
```
Разработать программу, находящую в заданной ASCII-строке последнюю при перемещении слева направо последовательность N
символов, каждый элемент которой определяется по условию «больше предшествующего» (N вводится как отдельный параметр).
```
Планируемая оценка: **6** 

## Этапы выполнения работы

Изначально были введены некоторые ограничения на параметр N:
- Если введено N <= 0, то пользователь получает сообщение `Incorrect size`.
- Если введено N больше, чем длина исходной строки (на основе которой строится символьная последовательность), то пользователь получает сообщение `Incorrect size`.
- Если введено N > 127, то пользователь получает сообщение `Incorrect size` (ASCII-таблица состоит из 128 символов, а строка может **только заканчиваться** нулевым символом `'\0'`, следовательно, максимальная последовательность может состоять из 127 символов, так как код следующего символа может быть **только больше** предыдущего).

Теперь перейдем к этапам выполнения ИДЗ:
1. Изначально была написана [sequence.c](https://github.com/bugovsky/CSA_IHW_02/blob/main/Programs/sequence.c) - программа на языке Си.
2. Проведем тестовые прогоны для [sequence.c](https://github.com/bugovsky/CSA_IHW_02/blob/main/Programs/sequence.c):

	![](https://github.com/bugovsky/CSA_IHW_02/blob/main/Images/asm_tests.png)

Вывод программы не отличается от правильного ответа, значит, программа на языке Си работает корректно.

3. Далее была произведена трансформация программы на языке Си с помощью команд, приведенных ниже: 
```
gcc -O0 -Wall -masm=intel -S -fno-asynchronous-unwind-tables -fcf-protection=none sequence.c
```

![](https://github.com/bugovsky/CSA_IHW_02/blob/main/Images/transform.png)

4. Удалим все лишнее из ассемблерной программы (все, что **не влияет** на работу программы):
    - `	.file	"sequence.c"` -  информацию о названии файла, из которого программа была получена.
    - Информацию об экспорте символов методов:
    
       ```
        .type	input, @function
        .type	GetSequence, @function
        .type	output, @function
        .type	main, @function
       ```
     - Информацию о трансформации кода в язык ассемблера:
     
       ```
      	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"

	    .section	.note.GNU-stack,"",@progbits
       ```
     - Информацию о размере функций:
       ```
        .size	input, .-input
        .size	GetSequence, .-GetSequence
        .size	output, .-output
        .size	main, .-main
       ```
     - Следующие объявления:
       ```
        .globl	input
        .globl	GetSequence
        .globl	output
       ```
       `.globl	main` нужно оставить, иначе программу невозможно скомпилировать
     - Не забываем про макрос **leave**, его нужно заменить во всей программе на
        ```
        mov rsp, rbp
        pop rbp
        ```
        Но если в прологе функции есть строка формата `sub rsp, x`, где `x` - количество байт, то тогда заменяем **leave** на следующие строки:
        ```
        add rsp, x
        mov rsp, rbp
        pop rbp
        ```
5. Теперь ассемблерная программа очищена от лишних директив и макросов. Отметим, что программа на Си и на языке ассемблера используют локальные переменные и функции с передачей данных через параметры. Оптимизируем программу, используя максимальное количество регистров, после этого добавим в программу комментарии, поясняющие какой регистр представляет конкретную переменную. Добавим в программу комментарии касательно формальных и фактических параметров функции и переносе возвращаемого значения (связь между параметрами языка Си и **регистрами**)
6. [sequence_final.s](https://github.com/bugovsky/CSA_IHW_02/blob/main/Programs/sequence_final.s) - итоговая программа на языке ассемблера.
7. Проведем тестовые прогоны для [sequence_final.s](https://github.com/bugovsky/CSA_IHW_02/blob/main/Programs/sequence_final.s) и сравним эквивалентность функционирования данной программы и [sequence.c](https://github.com/bugovsky/CSA_IHW_02/blob/main/Programs/sequence.c)
    
	![](https://github.com/bugovsky/CSA_IHW_02/blob/main/Images/c_tests.png)  
	
Вывод ассемблерной программы не отличается от правильного ответа на каждом тесте, а также совпадает с результатами тестов программы на Си, заключаем, что модификация ассемблерной программмы произведена верно, и данная программа работает корректно.  

8. Сопоставление размеров: получившаяся модифицированная программа состоит из 280 строк, но в программе присутствуют пустые строки (разбиение на логические блоки), поэтому имеет смысл посчитать размер программы без пустых строк - всего их **234**. Программа, полученная с помощью трансформации программы на языке Си в ассемблерную программу, содержит 281 строку (это можно проверить при выполнении пункта 3). Соответственно, в процессе оптимизации программы размер **кода** (то есть не **фактический** размер итоговой программы) был уменьшен на 47 строк.
