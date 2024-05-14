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

    mov ecx, [ebp + 8]
    
    mov edi, ebx
    dec edi

    mov esi, ebx
    mov ebx, [ebp + 16]
patition_loop:
    cmp esi, ebx
    jge end_partition_loop

    cmp [ecx + 4 * esi], edx
    jg next_iteration_partition_loop

    inc edi

    ; swap
    push dword [ecx + 4 * esi]
    push dword [ecx + 4 * edi]
    pop dword [ecx + 4 * esi]
    pop dword [ecx + 4 * edi]

next_iteration_partition_loop:
    inc esi
    jmp patition_loop

end_partition_loop:
    inc edi
    ; swap
    push dword [ecx + 4 * ebx]
    push dword [ecx + 4 * edi]
    pop dword [ecx + 4 * ebx]
    pop dword [ecx + 4 * edi]

    dec edi
    mov eax, [ebp + 12]

    push edi
    push eax
    push ecx
    call quick_sort
    add esp, 12

    inc edi
    inc edi

    push ebx
    push edi
    push ecx
    call quick_sort
    add esp, 12

end_qsort:
    ;; restore the preserved registers
    popa
    leave
    ret
