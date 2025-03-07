; Interpret as 32 bits code
[bits 32]

%include "../include/io.mac"

section .text
; int check_parantheses(char *str)
global check_parantheses
check_parantheses:
    push ebp
    mov ebp, esp

    ; save the string
    mov esi, [ebp + 8]

    ; assume the parantheses are closed correctly
    xor eax, eax

    xor edx, edx
    ; if I add something to the stack, edx becomes 1

check_each_character:
    ; check if the current character is different from '\0'
    cmp byte [esi], 0
    je end_parantheses

    ; add the open parantheses to the stack
    cmp byte [esi], '('
    je add_to_stack

    cmp byte [esi], '['
    je add_to_stack

    cmp byte [esi], '{'
    je add_to_stack

    cmp byte [esi], ')'
    je check_stack

    cmp byte [esi], ']'
    je check_stack

    cmp byte [esi], '}'
    je check_stack

add_to_stack:
    push esi
    ; change the value in edx because something was added to the stack
    mov edx, 1
    jmp next_iteration

check_stack:
    ; check if I added something to the stack
    cmp edx, 0
    je found_mismatch

    ; when a closing parantheses is met,
    ; check if its "match" was met right before
    ; (check if the "match" is the last 
    ; character added to the stack)
    pop edi
    cmp byte [esi], ')'
    jne parantheses2

    cmp byte [edi], '('
    jne found_mismatch

parantheses2:
    cmp byte [esi], ']'
    jne parantheses3

    cmp byte [edi], '['
    jne found_mismatch

parantheses3:
    cmp byte [esi], '}'
    jne next_iteration

    cmp byte [edi], '{'
    jne found_mismatch

next_iteration:
    inc esi
    jmp check_each_character

found_mismatch:
    ; return 1
    mov eax, 1

end_parantheses:
    leave
    ret
