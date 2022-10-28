# ИДЗ № 2. Жуковский Дмитрий Романович БПИ219. Вариант 4
## Условие задачи
```
Разработать программу, находящую в заданной ASCII-строке последнюю при перемещении слева направо последовательность N
символов, каждый элемент которой определяется по условию «больше предшествующего» (N вводится как отдельный параметр).
```
## Этапы выполнения работы

Планируемая оценка: **6**  

Изначально были введены некоторые ограничения на параметр N:
- Если введено N <= 0, то пользователь получает сообщение `Incorrect size`.
- Если введено N больше, чем длина исходной строки (на основе которой строится символьная последовательность), то пользователь получает сообщение `Incorrect size`.
- Если введено N > 127, то пользователь получает сообщение `Incorrect size` (ASCII-таблица состоит из 128 символов, а строка может **только заканчиваться** нулевым символом `'\0'`, следовательно, максимальная последовательность может состоять из 127 символов, так как код следующего символа может быть **только больше** предыдущего).

Теперь перейдем к этапам выполнения ИДЗ:
1. Изначально была написана [sequence.c](https://github.com/bugovsky/CSA_IHW_02/blob/main/Programs/sequence.c) - программа на языке Си.
2. Далее была произведена трансформация программы на языке Си с помощью команд, приведенных на скриншоте ниже: 

![](https://github.com/bugovsky/CSA_IHW_02/blob/main/Images/transform.png)

3. Удалим все лишнее из ассемблерной программы (все, что **не влияет** на работу программы):
    -  - информацию о названии файла, из которого программа была получена.
    - Информацию об экспорте символов методов:
    
       ```
       
       ```
     - Информацию о трансформации кода в язык ассемблера:
     
       ```
      	
       ```
     - Информацию о размере функций:
       ```
       
       ```
     - Следующие объявления:
       ```
       
       ```
       `.globl	main` нужно оставить, иначе программу невозможно скомпилировать
     - Не забываем про макрос **leave**, его нужно заменить во всей программе на
        ```
        mov rsp, rbp
        pop rpb
        ```
        Но если в прологе функции есть строка формата `sub rsp, x`, где `x` - количество байт, то тогда заменяем **leave** на следующие строки:
        ```
        add rsp, x
        mov rsp, rbp
        pop rpb
        ```
4.  - теперь поработаем с этой программой, она очищена от лишних директив и макросов, в ней присутствуют комментарии, описывающие связь переменных на языке Си и регистров, передачу фактических параметров и перенос возвращаемого результата. Для формальных параметров, описывающие связь между параметрами языка Си и регистрами, комментарии также добавлены.
5. Тестовые прогоны проводим для  и 
    - Программа на языке Си:
    
    - Программа на языке ассемблера:
    
    Как видим, результаты тестовых прогонов одинаковы, а также их вывод не отличается от правильного ответа на каждом тесте, заключаем, что программа работает корректно, а модификация ассемблерной программмы произведена верно.
6. В  и  используются функции с передачей данных
через параметры, также обе программы содержат локальные переменные.
7.  - программа, получившаяся после рефакторинга.  
  В регистрах процессора хранится информация о всех переменных, которые используются в программе на языке C:
    
    
    Комментарии в приложенной программе поясняют, какую переменную заменяет тот или иной регистр.
8. Тестовые прогоны для 
  Как видим, вывод программы на каждом тесте совпадает и с правильным ответом, и с выводом программ, выполненных ранее, что говорит о корректной работе полученной после рефакторинга программы.
  
  Таким образом, критерии, включенные в разделы оценок 4-6 (включительно), были выполнены.
