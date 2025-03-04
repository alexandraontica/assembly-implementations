; subtask 1 - qsort

section .text
    global quick_sort
    ;; no extern functions allowed

    ; 4 is the size of an integer
    four equ 4

quick_sort:
    ;; create the new stack frame
    enter 0, 0

    ;; save the preserved registers
    pusha

    ;; recursive qsort implementation goes here
    ; [ebp + 8] = buff
    ; [ebp + 12] = start
    ; [ebp + 16] = end

    ; save start
    mov ebx, [ebp + 12]
    ; compare it with end
    cmp ebx, [ebp + 16]
    jge end_qsort

    ; partition
    mov ecx, [ebp + 8]

    ; save end
    mov eax, [ebp + 16]
    mov edx, [ecx + four * eax]

    mov edi, ebx
    dec edi

    mov esi, ebx
    ; save end
    mov ebx, [ebp + 16]
patition_loop:
    cmp esi, ebx
    jge end_partition_loop

    cmp [ecx + four * esi], edx
    jg next_iteration_partition_loop

    inc edi

    ; swap
    push dword [ecx + four * esi]
    push dword [ecx + four * edi]
    pop dword [ecx + four * esi]
    pop dword [ecx + four * edi]

next_iteration_partition_loop:
    inc esi
    jmp patition_loop

end_partition_loop:
    inc edi
    ; swap
    push dword [ecx + four * ebx]
    push dword [ecx + four * edi]
    pop dword [ecx + four * ebx]
    pop dword [ecx + four * edi]

    dec edi
    ; save start
    mov eax, [ebp + 12]

    push edi
    push eax
    push ecx
    call quick_sort
    ; restore the value of esp
    add esp, 12

    inc edi
    inc edi

    push ebx
    push edi
    push ecx
    call quick_sort
    ; restore the value of esp
    add esp, 12

end_qsort:
    ;; restore the preserved registers
    popa
    leave
    ret
