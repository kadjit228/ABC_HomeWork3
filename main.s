.file	"main(2).c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
        .string "%f"
float_input:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        lea     rax, [rbp-4]  # Выделение памяти для переменной q
        mov     rsi, rax      # Начало ввода q
        mov     edi, OFFSET FLAT:.LC0
        mov     eax, 0
        call    __isoc99_scanf # конец ввода q
        movss   xmm0, DWORD PTR [rbp-4] # return q
        leave
        ret
multiply:
        push    rbp
        mov     rbp, rsp
        movss   DWORD PTR [rbp-4], xmm0   # Копирование параметра k
        movss   DWORD PTR [rbp-8], xmm1   # Копирование параметра x
        movss   xmm0, DWORD PTR [rbp-4]   # Умножение переменных
        mulss   xmm0, DWORD PTR [rbp-8]	  # Возвращаемое значение
        pop     rbp
        ret
abs_:
        push    rbp
        mov     rbp, rsp
        movss   DWORD PTR [rbp-4], xmm0  # Копирование параметра x
        pxor    xmm0, xmm0
        comiss  xmm0, DWORD PTR [rbp-4]
        jbe     .L10
        movss   xmm0, DWORD PTR [rbp-4] # возвращаем -x 
        movss   xmm1, DWORD PTR .LC2[rip]
        xorps   xmm0, xmm1 # закончили return -x
        jmp     .L8
.L10:
        movss   xmm0, DWORD PTR [rbp-4] # return x
.L8:
        pop     rbp
        ret
.LC4:
        .string "X must be in (-1 ; 1)"
.LC6:
        .string "%f \n"
main:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        mov     eax, 0
        call    float_input
        movd    eax, xmm0   # в eax забрали то, что вернул input_float()
        mov     DWORD PTR [rbp-12], eax   # записали в q то, что вернул input_float
        movss   xmm0, DWORD PTR [rbp-12]  # начало q = q / 100
        movss   xmm1, DWORD PTR .LC3[rip]
        divss   xmm0, xmm1                # делим
        movss   DWORD PTR [rbp-12], xmm0  # конец q = q / 100
        mov     edi, OFFSET FLAT:.LC4
        call    puts
        mov     eax, 0
        call    float_input
        movd    eax, xmm0   # в eax забрали то, что вернул input_float()
        mov     DWORD PTR [rbp-16], eax  # записали в q то, что вернул input_float
        movss   xmm0, DWORD PTR .LC5[rip] # начинаем вычислять 1/(1 - x)
        movaps  xmm1, xmm0
        subss   xmm1, DWORD PTR [rbp-16] # закончили вычислять
        movss   xmm0, DWORD PTR .LC5[rip] # обьявляем real_number и кладем в нее значение 1/(1 - x)
        divss   xmm0, xmm1
        movss   DWORD PTR [rbp-20], xmm0 # закончили, теперь в real_number лежит нужное значение
        movss   xmm0, DWORD PTR .LC5[rip]   # перемещаем 1 для sum
        movss   DWORD PTR [rbp-4], xmm0     # создаем sum и кладем 1
        movss   xmm0, DWORD PTR .LC5[rip]   # перемещаем 1 для k
        movss   DWORD PTR [rbp-8], xmm0     # создаем k и кладем в нее 1
        jmp     .L12
.L13:
        movss   xmm0, DWORD PTR [rbp-16] # передача параметров в multiply
        mov     eax, DWORD PTR [rbp-8]
        movaps  xmm1, xmm0
        movd    xmm0, eax  # закончили передачу
        call    multiply
        movd    eax, xmm0   # передача результата multiply в eax
        mov     DWORD PTR [rbp-8], eax  # положили в k то, что вернуло multiply
        movss   xmm0, DWORD PTR [rbp-4] # sum += k
        addss   xmm0, DWORD PTR [rbp-8]
        movss   DWORD PTR [rbp-4], xmm0 # sum += k
.L12:
        movss   xmm0, DWORD PTR [rbp-4]
        subss   xmm0, DWORD PTR [rbp-20]   # Вычитание внутри abs()
        movd    eax, xmm0  # передача параметров в abs
        movd    xmm0, eax  # передача параметров в abs 
        call    abs_
        movd    eax, xmm0    # результат abs() теперь лежит в eax
        movd    xmm2, eax
        comiss  xmm2, DWORD PTR [rbp-12]
        ja      .L13
        pxor    xmm3, xmm3   # printf("%f \n", real_number)
        cvtss2sd        xmm3, DWORD PTR [rbp-20]
        movq    rax, xmm3
        movq    xmm0, rax
        mov     edi, OFFSET FLAT:.LC6
        mov     eax, 1
        call    printf      # printf("%f \n", real_number)
        pxor    xmm4, xmm4  # printf("%f", sum)
        cvtss2sd        xmm4, DWORD PTR [rbp-4]
        movq    rax, xmm4
        movq    xmm0, rax
        mov     edi, OFFSET FLAT:.LC0
        mov     eax, 1
        call    printf      # printf("%f", sum)
        mov     eax, 0
        leave
        ret
.LC2:
        .long   -2147483648
        .long   0
        .long   0
        .long   0
.LC3:
        .long   1120403456
.LC5:
        .long   1065353216
