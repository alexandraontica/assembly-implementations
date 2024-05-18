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


; int reduce(int *dst, int *src, int n, int acc_init, int(*f)(int, int));
; int f(int acc, int curr_elem);
; reduce:
;     ; look at these fancy registers
;     push rbp
;     mov rbp, rsp

;     ; sa-nceapa festivalu'

;     leave
;     ret

