	.intel_syntax noprefix
	.text
input:
	push	rbp                                             # Пролог функции
	mov	rbp, rsp
	sub	rsp, 32
	
	push    rbx
	push    r12
	
	mov	rbx, rdi                                        # Кладем в регистр rbx char *str - первый формальный аргумент функции input
	mov	r12, 0                                          # Кладем в регистр r12 счетчик - размер
.L3:
	mov	rdi, QWORD PTR stdin[rip]                       # stdin - первый фактический аргумент функции fgetc        
	call	fgetc@PLT                                       # Посимвольное считывание с помощью функции fgetc
	mov	[rbx], al                                       # Добавляем символ в строку
	add	rbx, 1                                          # Переходим к следующей ячейке
	add     r12, 1                                          # Увеличили размер на 1
	cmp	al, -1                                          # Проверка на EOF
	je	.L2                                             # Если EOF - переходим к метке .L2
	cmp	r12, 99999
	jle	.L3                                             # Пока размер массива не больше 100000, то переходим к метке .L3
.L2:
	mov     al, 0                                           # Кладем в регистр al нулевой символ
	sub     rbx, 1                                          # Переходим к последнему элементу строки
	mov	[rbx], al                                       # Последний элемент строки - нулевой символ
	nop
	
	pop	r12
	pop	rbx
	
	add     rsp, 32					        # Эпилог функции
	mov     rsp, rbp
	pop     rbp
	ret

	.section	.rodata
	.align 8
.LC0:
	.string	"There is no sequence with size = %d\n"
	.text
GetSequence:
	push	rbp                                             # Пролог функции
	mov	rbp, rsp
	sub	rsp, 136
	
	push 	rbx
	push 	r12
	push 	r13
	push 	r14
	push 	r15	 
	
							        # В регистре rdi храним char *input - первый формальный аргумент функции GetSequence
							        # В регистре rsi - char *sequence - второй формальный аргумент функции GetSequence
							        # В регистре rdx - int input_size - третий формальный аргумент функции GetSequence
							        # В регистре rcx - int sequence_size - четвертый формальный аргумент функции GetSequence
	add	rdi, rdx				        # Перешли к ячейке памяти, находящуюся за последним элементом char *input
	sub	rdi, 1					        # Перешли к последнему элементу char *input
	
	mov	rbx, -1					        # Кладем в регистр rbx значение -1 (int end_index)
	mov	r12, -1					        # Кладем в регистр r12 значение -1 (int start_index)
	mov	r13, 0					        # Кладем в регистр r13 значение 0 (int current_index)
	mov	r14, rdx				        # Счетчик, (int i), присвоили значение input_size	
	sub	r14, 1					        # Отнимаем от счетчика единицу
	jmp	.L5					        # Безусловный переход к метке .L5
.L11:
	cmp	rbx, -1					        # Сравниваем значение int end_index с -1
	jne	.L6					        # Если значение НЕ равно -1, то переходим к .L6
			
	mov	rbx, r14				        # Присваиваем int end_index текущее значение счетчика
	mov	r12, r14				        # Присваиваем int start_index текущее значение счетчика
.L6:
	mov	rax, rbx				        # Кладем в регистр rax значение int end_index
	sub	rax, r12				        # Отнимаем от int end_index значение в int start_index
	add	rax, 1					        # Прибавляем к получившемуся значению 1
	cmp	rcx, rax				        # Сравниваем длину последовательности и получившееся значение
	je	.L16					        # Если они равны, то переходим к метке .L16
	
	mov	al, [rdi]				        # Кладем в регистр al элемент input[i]
	cmp	al, [rdi - 1]				        # Сравниваем элементы input[i] и input[i - 1]
	jle	.L9					        # Если ASCII-код input[i] меньше или равен input[i - 1] , то переходим в .L9
			
	sub	r12, 1					        # Иначе отнимаем от start_index единицу
	jmp	.L10					        # Безусловный переход к метке .L10
.L9:
	mov	rbx, -1					        # Кладем в регистр rbx значение -1 (int end_index)
	mov	r12, -1					        # Кладем в регистр r12 значение -1 (int start_index)
.L10:
	sub	r14, 1					        # Отнимаем от счетчика единицу
	sub	rdi, 1					        # Переходим к следующей ячейке массива
.L5:
	cmp	r14, 0					        # Сравниваем счетчик с нулем
	jg	.L11					        # Если счетчик больше нуля, то переходим к .L12
	jmp	.L8					        # Безусловный переход к метке .L9
.L16:
	nop
.L8:
	mov	rax, rbx                                        # Следующие три строки описывают конструкцию (end_index - start_index + 1)
	sub	rax, r12
	add	rax, 1                                          
	
	cmp	rcx, rax                                        # Сравниваем значение с нужной длиной последовательности
	jle	.L12                                            # Если значение меньше, чем длина последовательности, то переход не совершается
	mov	rsi, rcx                                        # Второй фактический аргумент функции printf - значение длины последовательности
	lea	rdi, .LC0[rip]                                  # Загружаем "There is no sequence with size = %d\n"
	mov	eax, 0
	call	printf@PLT                                      # Выводим на экран
	mov	al, 0
	mov	[rsi], al                                       # Теперь первый элемент последовательности - символ конца строки
	jmp	.L17                                            # Безусловный переход к .L17
.L12:
	jmp	.L14
.L15:
	mov	al, [rdi]				        # Кладем в регистр rax текущий символ из char *input
	mov	[rsi], al				        # Кладем этот символ в искомую последовательность
	add	r12, 1					        # Увеличиваем счетчик на один
	add	r13, 1					        # Увеличиваем индекс последовательности на один
	add	rdi, 1					        # Переходим к следующей ячейке char *input
	add	rsi, 1					        # Переходим к следующей ячейке char *sequence
.L14:
	cmp	r12, rbx				        # Сравниваем start_index и end_index
	jle	.L15					        # Если start_index <= end_index, то переходим к .L16
	mov	al, 0
	mov	[rsi], al				        # Кладем последним элементом в последовательность нулевой символ
.L17:
	nop
	pop 	r15
	pop 	r14
	pop 	r13
	pop 	r12
	pop 	rbx	
	
	add rsp, 136					        # Эпилог функции
	mov rsp, rbp
	pop rbp
	ret

output:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 72                                         # Пролог функции
	
	push	rbx
	push	r12
	
	mov	rbx, rdi				        # Кладем в rbx char *str - первый формальный аргумент функции output
	jmp	.L19                                            # Безусловный переход к метке .L19
.L20:
	mov	rdi, [rbx]				        # Кладем в регистр rdi текущий элемент char *str - первый фактический аргумент функции putchar
	call	putchar@PLT				        # Выводим данный символ с помощью функции putchar
	add	rbx, 1					        # Переходим к следующему элементу char *str
.L19:
	mov	al, [rbx]				        # Кладем в регистр al текущий элемент char *str
	test	al, al					        # Сравниваем его с нулем (проверка на нулевой символ)
	jne	.L20					        # Если текущий элемент не равен нулевому символу, то переходим к .L21
	
	mov	rdi, 10					        # Кладем в регистр rdi код символа перевода строки - первый фактический аргумент функции putchar
	call	putchar@PLT				        # Осуществляем перевод на следующую строку с помощью функции putchar
	nop
	
	pop	r12
	pop 	rbx
	
	add rsp, 72					        # Эпилог функции
	mov rsp, rbp
	pop rbp
	ret
	
	.section	.rodata
.LC1:
	.string	"%d"
.LC2:
	.string	"Incorrect size"
.LC3:
	.string	"Sequence:"
	.text
	.globl	main
main:
	push	rbp                                             # Пролог функции
	mov	rbp, rsp
	sub	rsp, 128
	
	push    rbx
	push 	r12
	push 	r13
	push 	r14
	
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	
	lea	rsi, -32[rbp]                                   # Кладем в регистр rsi адрес, по которому будет находиться переменная int n - второй фактический аргумент функции scanf
	lea	rdi, .LC1[rip]                                  # Кладем в rdi информацию о том, что будет введено целое число - первый фактический аргумент функции scanf                           
	mov	eax, 0
	call	__isoc99_scanf@PLT                              # Вызываем встроенную в Си функцию scanf - вводим значение n (длина последовательности)
	mov     eax, DWORD PTR -32[rbp]                         # Кладем в регистр eax значение переменной int n со стека
	movsx   r13, eax
	
	mov	rdi, 100000                                     # Кладем в регистр rdi значение 100000 (максимальный размер буфера)	
	call	malloc@PLT                                      # Вызов malloc из языка Си (динамическое выделение памяти для буфера)
	mov	rbx, rax                                        # Кладем в регистр rbx кладем значение rax (переменная char *input_str)
	
	mov	rdi, rbx                                        # Кладем в rdi значение переменной char *input_str (буфер) - первый фактический аргумент функции input
	call	input                                           # Вызываем функцию input, осуществляющую ввод строки
	
	mov	rdi, rbx                                        # Кладем в rdi значение переменной char *input_str (буфер) - первый фактический аргумент функции strlen
	call	strlen@PLT                                      # Вызываем встроенную в Си функцию strlen - получаем фактическую длину строки char *input_str
	mov	r12, rax                                        # Кладем в регистр r12 	длину строки char *input_str (возрат функции strlen)
	
	mov	rax, r13
	add	rax, 1                                          # Кладем в регистр rax значение параметра n, увеличенного на один
	mov	rdi, rax				        # Кладем в rdi значение n + 1 - первый фактический аргумент функции malloc
	call	malloc@PLT				        # Вызов malloc из языка Си (динамическое выделение памяти для последовательности)
	mov	r14, rax                                        # Кладем в регистр r14 кладем значение rax (переменная char *sequence)
	
	mov	rax, r13                                        # Кладем в регистр rax значение параметра n (для проведения проверки размера)
	test	rax, rax				        # Сравниваем с нулем
	jle	.L22                                            # Если значение <=0, то переходим к метке .L22
	cmp	r12, r13                                        # Сравниваем размер строки (int input_size) c длиной последовательности (int n)
	jge	.L23                                            # Если фактический размер строки больше либо равен, то переходим к метке .L23
.L22:
	lea	rdi, .LC2[rip]				        # Загружаем в регистр rdi строку "Incorrect size" - первый фактический аргумент функции
	call	puts@PLT				        # Выводим на экран данную строку
	jmp	.L24                                            # Безусловный переход к метке .L24
.L23:
	mov	rcx, r13                                        # Загружаем в регистр rcx значение переменной int n - четвертый фактический аргумент функции GetSequence
	mov	rdx, r12                                        # Загружаем в регистр rdx значение переменной int input_size - третий фактический аргумент функции GetSequence
	mov	rsi, r14                                        # Загружаем в регистр rsi значение переменной char *sequence - второй фактический аргумент функции GetSequence
	mov	rdi, rbx                                        # Загружаем в регистр rdi значение переменной char *input_str - первый фактический аргумент функции GetSequence
	call	GetSequence                                     # Вызываем функцию GetSequence (ищем последовательность, согласно условию)
	
	mov	al, [r14]                                       # Кладем первый элемент char *sequence в регистр al
	test	al, al                                          # Проверям, не является ли первый элемент символом конца строки (то есть не равна ли фактическая длина строки нулю)
	je	.L24                                            # Если это символ конца строки, то переходим к метке .L24
	lea	rdi, .LC3[rip]                                  # Иначе загружаем в регистр rdi "Sequence:"
	mov	eax, 0
	call	printf@PLT                                      # Выводим на экран "Sequence:"  
	
	mov	rdi, r14                                        # Загружаем в регистр rdi значение переменной char *sequence - первый фактический аргумент функции output
	call	output                                          # Вызываем функцию output (выводим найденную последовательность)
.L24:
	mov	rdi, rbx                                        # Передаем в регистр rdi значение переменной char *input_str - первый фактический аргумент функции
	call	free@PLT                                        # Очищаем память, выделенную под буфер

	mov	rdi, r14                                        # Передаем в регистр rdi значение переменной char *sequence - первый фактический аргумент функции
	call	free@PLT                                        # Очищаем память, выделенную под последовательность
	mov	eax, 0                                          # Кладем 0 в eax (программа завершена успешно)
	mov	rdx, QWORD PTR -8[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L26
	call	__stack_chk_fail@PLT
.L26:
	pop 	r14
	pop 	r13
	pop 	r12
	pop 	rbx
	
	add rsp, 128					        # Эпилог функции, заверешние программы с кодом 0
	mov rsp, rbp
	pop rbp
	ret
