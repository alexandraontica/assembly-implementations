; Interpret as 32 bits code
[bits 32]

%include "../include/io.mac"

section .text
; int check_parantheses(char *str)
global check_parantheses
check_parantheses:
    push ebp
    mov ebp, esp

    mov esi, [ebp + 8]

    xor eax, eax  ; assume the parantheses are close correctly
                  ; if not, return 1

    xor ecx, ecx
    xor edx, edx  ; if I add something to the stack, edx becomes 1
check_each_character:
    cmp byte [esi + ecx], 0
    je end

    cmp byte [esi + ecx], '('
    je add_to_stack

    cmp byte [esi + ecx], '['
    je add_to_stack

    cmp byte [esi + ecx], '{'
    je add_to_stack

add_to_stack:
    movzx edi, byte [esi + ecx]
    push edi
    mov edx, 1
    jmp next_iteration

    cmp byte [esi + ecx], ')'
    je check_stack

    cmp byte [esi + ecx], ']'
    je check_stack

    cmp byte [esi + ecx], '}'
    je check_stack

check_stack:
    cmp edx, 0
    je fount_mismatch

    pop edi
    cmp byte [esi + ecx], ')'
    jne parantheses2

    cmp byte [edi], '('
    jne fount_mismatch

parantheses2:
    cmp byte [esi + ecx], ']'
    jne parantheses3

    cmp byte [edi], '['
    jne fount_mismatch

parantheses3:
    cmp byte [esi + ecx], '}'
    jne next_iteration

    cmp byte [edi], '{'
    jne fount_mismatch

next_iteration:
    inc ecx
    jmp check_each_character

fount_mismatch:
    mov eax, 1

end:
    leave
    ret
