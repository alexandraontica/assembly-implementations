; subtask 1 - qsort

section .text
    global quick_sort
    ;; no extern functions allowed

quick_sort:
    ;; create the new stack frame
    enter 0, 0

    ;; save the preserved registers
    pusha

    ;; recursive qsort implementation goes here
    ; [ebp + 8] = buff
    ; [ebp + 12] = start
    ; [ebp + 16] = end

    mov ebx, [ebp + 12]
    cmp ebx, [ebp + 16]
    jge end_qsort

    ; partition
    mov ecx, [ebp + 16]
    mov edx, [ebp + 8 + 4 * ecx]
    
    dec ebx

    mov esi, [ebp + 12]
patition_loop:
    cmp esi, ecx
    jge end_partition_loop

    cmp [ebp + 8 + 4 * esi], edx
    jg next_iteration_partition_loop

    inc ebx

    ; swap
    mov edi, [ebp + 8 + 4 * esi]
    mov eax, [ebp + 8 + 4 * ebx]
    mov [ebp + 8 + 4 * esi], eax
    mov [ebp + 8 + 4 * ebx], edi

next_iteration_partition_loop:
    inc esi
    jmp patition_loop

end_partition_loop:
    inc ebx

    ; swap
    mov edi, [ebp + 8 + 4 * esi]
    mov eax, [ebp + 8 + 4 * ebx]
    mov [ebp + 8 + 4 * esi], eax
    mov [ebp + 8 + 4 * ebx], edi

    xor eax, eax

end_qsort:
    ;; restore the preserved registers
    popa
    leave
    ret
