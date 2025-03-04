%include "../include/io.mac"

; The `expand` function returns an address to the following type of data
; structure.
struc neighbours_t
    .num_neighs resd 1  ; The number of neighbours returned.
    .neighs resd 1      ; Address of the vector containing the `num_neighs` neighbours.
                        ; A neighbour is represented by an unsigned int (dword).
endstruc

; 4 is the size of a dword/int32_t
four equ 4

section .bss
; Vector for keeping track of visited nodes.
visited resd 10000
global visited

section .data
; Format string for printf.
fmt_str db "%u", 10, 0

section .text
global dfs
extern printf
extern expand

; C function signiture:
;   void dfs(uint32_t node, neighbours_t *(*expand)(uint32_t node))
; where:
; - node -> the id of the source node for dfs.
; - expand -> pointer to a function that takes a node id and returns a structure
; populated with the neighbours of the node (see struc neighbours_t above).
; 
; note: uint32_t is an unsigned int, stored on 4 bytes (dword).
dfs:
    push ebp
    mov ebp, esp

    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi

    ; TODO: Implement the depth first search algorith, using the `expand`
    ; function to get the neighbours. When a node is visited, print it by
    ; calling `printf` with the format string in section .data.

    ; save first arg
    mov ebx, [ebp + 8]
    ; save second arg
    mov edx, [ebp + 12]

    ; check if it was already visited
    cmp dword [visited + four * ebx], 0
    jne end_dfs

    push ebx
    push fmt_str
    call printf
    ; restore esp
    add esp, 8

    ; mask as visited
    mov dword [visited + four * ebx], 1

    push ebx
    call expand
    add esp, four
    mov edi, [eax + four]

    xor esi, esi
dfs_loop:
    cmp esi, [eax]
    jge end_dfs

    mov ecx, [edi + four * esi]

    push edx
    push ecx
    call dfs
    ; restore esp
    add esp, 8

    inc esi
    jmp dfs_loop

end_dfs:
    pop edi 
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    leave
    ret
