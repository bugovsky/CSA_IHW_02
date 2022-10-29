	.intel_syntax noprefix
	.text
input:
	push	rbp					# Эпилог функции
	mov	rbp, rsp
	sub	rsp, 72
	
	push	rbx
	push	r12
	push	r13
	
	mov	rbx, rdi				# Кладем в регистр rbx char *str - первый формальный аргумент функции input
	mov	r12, rsi				# Кладем в регистр r12 вместимость нашего буфера - второй формальный аругмент функции input
	mov	r13, 0					# Будем хранить в регистре r13 текущий размер массива (следим, чтобы он не превысил вместимость)
	
	call	getchar@PLT				# С помощью функции getchar осуществляем ввод символа
	
	mov	[rbx], al				# Присвоили первому элементу char *str введенный символ
	jmp	.L2					# Безусловный переход в метке .L2
.L4:
	add	r13, 1					# Увеличили текущий размер на единицу
	cmp	r13, r12				# Сравниваем текущий размер массива и максимальную вместимость
	jne	.L3					# Если они не равны, то переходим к метке .L3
	sal	r12					# Иначе увеличиваем вместимость в два раза
	mov	rsi, r12				# Кладем в rsi значение max_size - второй фактический аргумент функции realloc
	mov	rdi, rbx				# Кладем в rdi char *str - первый фактический аргумент функции realloc
	call	realloc@PLT				# Перевыделяем память для буфера
	mov	rbx, rax				# Кладем в регистр rbx возврат функции realloc - буфер
.L3:
	call	getchar@PLT				# С помощью функции getchar осуществляем ввод символа
	add	rbx, 1					# Перейдем к следующей ячейке памяти
	mov	[rbx], al				# Присвоили текущему элементу char *str введенный символ
.L2:
	mov	rax, 10					# Кладем в rax символ перевода строки
	cmp	[rbx], rax				# Сравниваем текущий элемент char *str с символом перевода строки
	jne	.L4					# Если текущий символ не равен символу перевода строки, то переходим к метке .L4
	
	mov	rax, 0					# Иначе кладем в rax ноль (в данном случае для того, чтобы передать нулевой символ в строку)
	mov	[rbx], rax				# Кладем последним элементом нулевой символ
	nop
	
	pop	r13
	pop	r12
	pop	rbx
	
	add rsp, 72					# Эпилог функции
	mov rsp, rbp
	pop rbp
	ret

	.section	.rodata
	.align 8
.LC0:
	.string	"There is no sequence with size = %d"
	.text


GetSequence:
	push	rbp					# Пролог функции
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
							
	add	rdi, rdx				# Перешли к ячейке памяти, находящуюся за последним элементом char *input
	sub	rdi, 1					# Перешли к последнему элементу char *input
	
	mov	rbx, -1					# Кладем в регистр rbx значение -1 (int end_index)
	mov	r12, -1					# Кладем в регистр r12 значение -1 (int start_index)
	mov	r13, 0					# Кладем в регистр r13 значение 0 (int current_index)
	mov	r14, rdx				# Счетчик, (int i), присвоили значение input_size	
	sub	r14, 1					# Отнимаем от счетчика единицу
	jmp	.L6					# Безусловный переход к метке .L6
.L12:
	cmp	rbx, -1					# Сравниваем значение int end_index с -1
	jne	.L7					# Если значение НЕ равно -1, то переходим к .L7
			
	mov	rbx, r14				# Присваиваем int end_index текущее значение счетчика
	mov	r12, r14				# Присваиваем int start_index текущее значение счетчика
.L7:
	mov	rax, rbx				# Кладем в регистр rax значение int end_index
	sub	rax, r12				# Отнимаем от int end_index значение в int start_index
	add	rax, 1					# Прибавляем к получившемуся значению 1
	cmp	rcx, rax				# Сравниваем длину последовательности и получившееся значение
	je	.L17					# Если они равны, то переходим к метке .L17
	
	mov	al, [rdi]				# Кладем в регистр al элемент input[i]
	cmp	al, [rdi - 1]				# Сравниваем элементы input[i] и input[i - 1]
	jle	.L10					# Если ASCII-код input[i] меньше или равен input[i - 1] , то переходим в .L10
			
	sub	r12, 1					# Иначе отнимаем от start_index единицу
	jmp	.L11					# Безусловный переход к метке .L11
.L10:
	mov	rbx, -1					# Кладем в регистр rbx значение -1 (int end_index)
	mov	r12, -1					# Кладем в регистр r12 значение -1 (int start_index)
.L11:
	sub	r14, 1					# Отнимаем от счетчика единицу
	sub	rdi, 1					# Переходим к следующей ячейке массива
.L6:
	cmp	r14, 0					# Сравниваем счетчик с нулем
	jg	.L12					# Если счетчик больше нуля, то переходим к .L12
	jmp	.L9					# Безусловный переход к метке .L9
.L17:
	nop
.L9:
	cmp	rbx, -1					# Сравниваем end_index с единицей
	jne	.L13					# Если end_index НЕ равен единице, то переходим к метке .L13

	mov	rbx, rsi
	mov	rsi, rcx				# Иначе кладем в rsi значение длины последовательности - второй фактический аргумент 
	lea	rax, .LC0[rip]
	mov	rdi, rax				# Загружаем в rdi строку "There is no sequence with size = %d" - первый фактический аргумент 
	mov	eax, 0
	call	printf@PLT				# Вызываем встроенный в Си printf
	mov	al, 0
	mov	[rbx], al				# Кладем первым элементом нулевой символ
	jmp	.L18					# Безусловный переход к метке .L18
.L13:
	jmp	.L15					# Безусловный переход к метке .L15
.L16:
	mov	al, [rdi]				# Кладем в регистр rax текущий символ из char *input
	mov	[rsi], al				# Кладем этот символ в искомую последовательность
	add	r12, 1					# Увеличиваем счетчик на один
	add	r13, 1					# Увеличиваем индекс последовательности на один
	add	rdi, 1					# Переходим к следующей ячейке char *input
	add	rsi, 1					# Переходим к следующей ячейке char *sequence
.L15:
	cmp	r12, rbx				# Сравниваем start_index и end_index
	jle	.L16					# Если start_index <= end_index, то переходим к .L16
	mov	al, 0
	mov	[rsi], al				# Кладем последним элементом в последовательность нулевой символ
.L18:
	nop
	
	pop 	r15
	pop 	r14
	pop 	r13
	pop 	r12
	pop 	rbx	
	
	add rsp, 136					# Эпилог функции
	mov rsp, rbp
	pop rbp
	ret

output:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 72
	
	push	rbx
	push	r12
	
	mov	rbx, rdi				# Кладем в rbx char *str - первый формальный аргумент функции output
	jmp	.L20					# Безусловный переход к метке .L20
.L21:
	mov	rdi, [rbx]				# Кладем в регистр rdi текущий элемент char *str - первый фактический аргумент функции putchar
	call	putchar@PLT				# Выводим данный символ с помощью функции putchar
	add	rbx, 1					# Переходим к следующему элементу char *str
.L20:
	mov	al, [rbx]				# Кладем в регистр al текущий элемент char *str
	test	al, al					# Сравниваем его с нулем (проверка на нулевой символ)
	jne	.L21					# Если текущий элемент не равен нулевому символу, то переходим к .L21
	
	mov	rdi, 10					# Кладем в регистр rdi код символа перевода строки - первый фактический аргумент функции putchar
	call	putchar@PLT				# Осуществляем перевод на следующую строку с помощью функции putchar
	nop
	
	pop	r12
	pop 	rbx
	
	add rsp, 72					# Эпилог функции
	mov rsp, rbp
	pop rbp
	ret

	.section	.rodata
.LC1:
	.string	"%d"
.LC2:
	.string	"Incorrect size"
	.text
	.globl	main

main:
	push	rbp					# Пролог функции
	mov	rbp, rsp
	sub	rsp, 72			
	
	push 	rbx
	push 	r12
	push 	r13
	push 	r14
	push 	r15	 	
	
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	
	mov	rbx, 10000				# Кладем в регистр rbx значение 10000 (текущий максимальный размер буфера - int max_size)	
	mov	rdi, rbx				# Кладем в регистр rdi значение rbx (текущий максимальный размер буфера), первый фактический аргумент для вызова malloc
	call	malloc@PLT				# Вызов malloc из языка Си (динамическое выделение памяти для буфера)
	mov	r12, rax				# Кладем в регистр r12 кладем значение rax (переменная char *input_str)
	
	mov	rsi, rbx				# Кладем в rsi значение max_size - второй фактический аргумент функции input
	mov	rdi, r12				# Кладем в rdi значение переменной char *input_str (буфер) - первый фактический аргумент функции input
	call	input					# Вызываем функцию input, осуществляющую ввод строки
	
	mov	rdi, r12				# Кладем в rdi значение переменной char *input_str (буфер) - первый фактический аргумент функции strlen
	call	strlen@PLT				# Вызываем встроенную в Си функцию strlen - получаем длину строки char *input_str
	mov	r13, rax				# Кладем в регистр r13 	длину строки char *input_str (возрат функции strlen)
	
	lea	rsi, -36[rbp]				# Кладем в регистр rsi адрес, по которому будет находиться переменная int n - второй фактический аргумент функции scanf
	lea	rdi, .LC1[rip]				# Кладем в rdi информацию о том, что будет введено целое число - первый фактический аргумент функции scanf
	mov	eax, 0
	call	__isoc99_scanf@PLT			# Вызываем встроенную в Си функцию scanf - вводим значение n (длина последовательности)
	
	mov	eax, DWORD PTR -36[rbp]			# Кладем в регистр eax значение переменной int n со стека
	movsx 	r14, eax				# Кладем в регистр r14 значение регистра eax (переменная int n)
	add	eax, 1					# Добавляем единицу к значение, находящемся в регистре rax (для того, чтобы последовательность завершалась нулевым символом)
	movsx	rax, eax				
	mov	rdi, rax				# Кладем в rdi значение n + 1 - первый фактический аргумент функции malloc
	call	malloc@PLT				# Вызов malloc из языка Си (динамическое выделение памяти для последовательности)
	mov	r15, rax				# Кладем в регистр r15 кладем значение rax (переменная char *sequence) 
	
	mov	rax, r14				# Кладем в регистр rax значение переменной int n 
	test	eax, eax				# Сравниваем с нулем
	jle	.L23					# Если значение <=0, то переходим к метке .L23
	
	cmp	r13, r14				# Сравниваем размер строки (int input_size) c длиной последовательности (int n)
	jl	.L23					# Если размер строки меньше, то переходим к метке .L23

	cmp	r14, 127				# Сравниваем длину последовательности со значением 127
	jle	.L24					# Если значение <=127, то переходим к метке .L24
	
.L23:
	lea	rdi, .LC2[rip]				# Загружаем в регистр rdi строку "Incorrect size" - первый фактический аргумент функции
	call	puts@PLT				# Выводим на экран данную строку
	jmp	.L25					# Безусловный переход к метке .L25
.L24:
	mov	rcx, r14				# Загружаем в регистр rcx значение переменной int n - четвертый фактический аргумент функции GetSequence
	mov	rdx, r13				# Загружаем в регистр rcx значение переменной int input_size - третий фактический аргумент функции GetSequence
	mov	rsi, r15				# Загружаем в регистр rsi значение переменной char *sequence - второй фактический аргумент функции GetSequence
	mov	rdi, r12				# Загружаем в регистр rdi значение переменной char *input_str - первый фактический аргумент функции GetSequence
	call	GetSequence				# Вызываем функцию GetSequence (ищем последовательность, согласно условию)
	
	mov	rdi, r15				# Загружаем в регистр rdi значение переменной char *sequence - первый фактический аргумент функции output
	call	output					# Вызываем функцию output (выводим найденную последовательность)
.L25:
	mov	rdi, r12				# Передаем в регистр rdi значение переменной char *input_str - первый фактический аргумент функции
	call	free@PLT				# Очищаем память, выделенную под буфер
	
	mov	rdi, r15				# Передаем в регистр rdi значение переменной char *sequence - первый фактический аргумент функции
	call	free@PLT				# Очищаем память, выделенную под буфер
	mov	eax, 0					# Кладем 0 в eax (программа завершена успешно)
	
	mov	rdx, QWORD PTR -8[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L27
	call	__stack_chk_fail@PLT
.L27:
	pop 	r15
	pop 	r14
	pop 	r13
	pop 	r12
	pop 	rbx	
	
	add rsp, 72					# Эпилог функции, заверешние программы с кодом 0
	mov rsp, rbp
	pop rbp
	ret
