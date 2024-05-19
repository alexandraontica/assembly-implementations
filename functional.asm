; Interpret as 64 bits code
[bits 64]

; nu uitati sa scrieti in feedback ca voiati
; assembly pe 64 de biti

section .text
global map
global reduce

; void map(int64_t *dst, int64_t *src, int64_t n, int64_t(*f)(int64_t));
map:
    ; look at these fancy registers
    push rbp
    mov rbp, rsp

    ; sa-nceapa turneu'

    ; save *dst
    mov rbx, [rbp + 16]
    ; save *src
    mov rcx, [rbp + 24]
    ; save n
    mov rdx, [rbp + 32]
    ; save f
    mov rdi, [rbp + 40]

    xor rsi, rsi
map_loop:
    cmp rsi, rdx
    jge end_map_loop

    mov r8, [rcx + 8 * rsi]
    push r8
    call rdi
    add rsp, 8

    mov [rbx + 8 * rsi], rax

    inc rsi
    jmp map_loop

end_map_loop:
    leave
    ret

map:
        test    rdx, rdx
        jle     .L6
        push    r14
        mov     r14, rcx
        push    r13
        mov     r13, rsi
        push    r12
        mov     r12, rdi
        push    rbp
        mov     rbp, rdx
        push    rbx
        xor     ebx, ebx
.L3:
        mov     rdi, QWORD PTR [r13+0+rbx*8]
        call    r14
        mov     QWORD PTR [r12+rbx*8], rax
        add     rbx, 1
        cmp     rbp, rbx
        jne     .L3
        pop     rbx
        pop     rbp
        pop     r12
        pop     r13
        pop     r14
        ret
.L6:

; int reduce(int *dst, int *src, int n, int acc_init, int(*f)(int, int));
; int f(int acc, int curr_elem);
reduce:
    ; look at these fancy registers
    push rbp
    mov rbp, rsp

    ; sa-nceapa festivalu'

    ; save *dst
    mov rbx, [rbp + 16]
    ; save *src
    mov rcx, [rbp + 24]
    ; save n
    mov rdx, [rbp + 32]
    ; save acc_init
    mov rsi, [rbp + 40]
    ; save f
    mov rdi, [rbp + 48]

    mov rax, rsi
    
    xor rsi, rsi
reduce_loop:
    cmp rsi, rdx
    jge end_reduce_loop

    mov r8, [rcx + 8 * rsi]
    push rax
    push r8
    call rdi
    add rsp, 8

    inc rsi
    jmp reduce_loop

end_reduce_loop:
    leave
    ret

