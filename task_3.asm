%include "../include/io.mac"

; The `expand` function returns an address to the following type of data
; structure.
struc neighbours_t
    .num_neighs resd 1  ; The number of neighbours returned.
    .neighs resd 1      ; Address of the vector containing the `num_neighs` neighbours.
                        ; A neighbour is represented by an unsigned int (dword).
endstruc

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

    ; TODO: Implement the depth first search algorith, using the `expand`
    ; function to get the neighbours. When a node is visited, print it by
    ; calling `printf` with the format string in section .data.

    mov ebx, [ebp + 8]
    mov edx, [ebp + 12]

    cmp dword [visited + 4 * ebx], 0
    jne end_dfs

    push ebx
    push fmt_str
    call printf
    add esp, 8

    mov dword [visited + 4 * ebx], 1

    push ebx
    call expand
    add esp, 4
    mov edi, [eax + 4]

    xor esi, esi
dfs_loop:
    cmp esi, [eax]
    jge end_dfs

    mov ecx, [edi + 4 * esi]

    push edx
    push ecx
    call dfs
    add esp, 8

    inc esi
    jmp dfs_loop

end_dfs:
    leave
    ret
