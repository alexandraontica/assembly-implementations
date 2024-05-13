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
    
    mov edi, ebx
    dec edi

    mov esi, ebx
patition_loop:
    cmp esi, ecx
    jge end_partition_loop

    cmp [ebp + 8 + 4 * esi], edx
    jg next_iteration_partition_loop

    inc edi

    ; swap
    ; mov ebx, [ebp + 8 + 4 * esi]
    ; mov eax, [ebp + 8 + 4 * edi]
    ; mov [ebp + 8 + 4 * esi], eax
    ; mov [ebp + 8 + 4 * edi], ebx

next_iteration_partition_loop:
    inc esi
    jmp patition_loop

end_partition_loop:
    inc edi
    ; swap
    ; mov ebx, [ebp + 8 + 4 * ecx]
    ; mov eax, [ebp + 8 + 4 * edi]
    ; mov [ebp + 8 + 4 * ecx], eax
    ; mov [ebp + 8 + 4 * edi], ebx

    dec edi
    mov ebx, [ebp + 12]
    mov eax, [ebp + 8]

    push edi
    push ebx
    push eax
    call quick_sort
    add esp, 12

    inc edi
    inc edi

    push ecx
    push edi
    push eax
    call quick_sort
    add esp, 12

end_qsort:
    ;; restore the preserved registers
    popa
    leave
    ret
