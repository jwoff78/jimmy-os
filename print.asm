print:
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

print_hex:
    pusha
    ;TODO: Manipulate chars at HEX_OUT to reflex DX

    mov ax, 4
    mov bx, HEX_OUT
    add bx, 2
    print_hex_loop:

        mov cx, dx
        shr dx, 4
        and cl, 0xFF
        add cl, 48

        mov word[bx], cx

        inc bx
        dec ax

        cmp ax, 0x00 ; Compare al(*bx) to NULL(0x00)
        jle print_hex_loop_end ; If al is NULL, the string is terminated and we can end the loop

        jmp print_hex_loop

print_hex_loop_end:
    mov bx, HEX_OUT
    call print

    ret

; globals
HEX_OUT: db '0x0000', 0