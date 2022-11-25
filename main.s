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
        lea     rax, [rbp-4]
        mov     rsi, rax
        mov     edi, OFFSET FLAT:.LC0
        mov     eax, 0
        call    __isoc99_scanf
        movss   xmm0, DWORD PTR [rbp-4]
        leave
        ret
multiply:
        push    rbp
        mov     rbp, rsp
        movss   DWORD PTR [rbp-4], xmm0
        movss   DWORD PTR [rbp-8], xmm1
        movss   xmm0, DWORD PTR [rbp-4]
        mulss   xmm0, DWORD PTR [rbp-8]
        pop     rbp
        ret
abs_:
        push    rbp
        mov     rbp, rsp
        movss   DWORD PTR [rbp-4], xmm0
        pxor    xmm0, xmm0
        comiss  xmm0, DWORD PTR [rbp-4]
        jbe     .L10
        movss   xmm0, DWORD PTR [rbp-4]
        movss   xmm1, DWORD PTR .LC2[rip]
        xorps   xmm0, xmm1
        jmp     .L8
.L10:
        movss   xmm0, DWORD PTR [rbp-4]
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
        movd    eax, xmm0
        mov     DWORD PTR [rbp-12], eax
        movss   xmm0, DWORD PTR [rbp-12]
        movss   xmm1, DWORD PTR .LC3[rip]
        divss   xmm0, xmm1
        movss   DWORD PTR [rbp-12], xmm0
        mov     edi, OFFSET FLAT:.LC4
        call    puts
        mov     eax, 0
        call    float_input
        movd    eax, xmm0
        mov     DWORD PTR [rbp-16], eax
        movss   xmm0, DWORD PTR .LC5[rip]
        movaps  xmm1, xmm0
        subss   xmm1, DWORD PTR [rbp-16]
        movss   xmm0, DWORD PTR .LC5[rip]
        divss   xmm0, xmm1
        movss   DWORD PTR [rbp-20], xmm0
        movss   xmm0, DWORD PTR .LC5[rip]
        movss   DWORD PTR [rbp-4], xmm0
        movss   xmm0, DWORD PTR .LC5[rip]
        movss   DWORD PTR [rbp-8], xmm0
        jmp     .L12
.L13:
        movss   xmm0, DWORD PTR [rbp-16]
        mov     eax, DWORD PTR [rbp-8]
        movaps  xmm1, xmm0
        movd    xmm0, eax
        call    multiply
        movd    eax, xmm0
        mov     DWORD PTR [rbp-8], eax
        movss   xmm0, DWORD PTR [rbp-4]
        addss   xmm0, DWORD PTR [rbp-8]
        movss   DWORD PTR [rbp-4], xmm0
.L12:
        movss   xmm0, DWORD PTR [rbp-4]
        subss   xmm0, DWORD PTR [rbp-20]
        movd    eax, xmm0
        movd    xmm0, eax
        call    abs_
        movd    eax, xmm0
        movd    xmm2, eax
        comiss  xmm2, DWORD PTR [rbp-12]
        ja      .L13
        pxor    xmm3, xmm3
        cvtss2sd        xmm3, DWORD PTR [rbp-20]
        movq    rax, xmm3
        movq    xmm0, rax
        mov     edi, OFFSET FLAT:.LC6
        mov     eax, 1
        call    printf
        pxor    xmm4, xmm4
        cvtss2sd        xmm4, DWORD PTR [rbp-4]
        movq    rax, xmm4
        movq    xmm0, rax
        mov     edi, OFFSET FLAT:.LC0
        mov     eax, 1
        call    printf
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
