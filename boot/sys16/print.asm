; print_string
; Prints a null-terminated string pointer to BIOS
; USE:
; mov bx, STR_PTR
; call print_string
; Prints the value in STR_PTR.

print_string:
    pusha ; Push all registries to the stack, to make sure no values are modified
    mov ah, 0x0e ; int 10/ah = 0eh -> print
    mov al, [bx] ; Copy current CHAR to the AL registry

    print_loop:
        int 0x10        ; print(al)

        inc bx ; Increment the bx pointer
        mov al, [bx] ; Copy over *bx to al, for the next printing and also comparison
        cmp al, 0x00 ; Compare al(*bx) to NULL(0x00)
        jle end_print_loop ; If al is NULL, the string is terminated and we can end the loop

        jmp print_loop ; Loop around
    end_print_loop: ; Just a basic label to mark outside of the loop
    popa ; Restore all registry values from stack
    ret ; Return and head back to the location of the call

; write
; Prints a single char to BIOS
; USE:
; mov bx, CHAR
; call write
; Prints CHAR
write:
    pusha
    mov ah, 0x0e ; int 10/ah = 0eh -> print
    int 0x10        ; print(al)
    popa
    ret

; globals

NEWLINE: db 0x0D, 0x0A, 0x00
HELLO_WORLD: db 'Hello, World!', 0x0D, 0x0A, 0x00