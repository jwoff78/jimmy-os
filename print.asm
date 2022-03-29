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

    mov ax, 3
    print_hex_loop:

        ; CX should become the current char.
        ; We need to get the current 4 bits of dx

        mov bx, HEX_OUT
        add bx, 5
        sub bx, ax

        mov cx, dx
        and cx, 0xF000
        shr cx, 12
        add cx, 48

        cmp cx, 56
        jg print_hex_if
        jmp print_hex_if_else

        print_hex_if:
            add cx, 7
            mov word[bx], cx
            jmp print_hex_if_end
        print_hex_if_else:
            mov word[bx], cx
    print_hex_if_end:

        dec ax
        shl dx, 4

        cmp ax, 0
        jl print_hex_loop_end ; If al is NULL, the string is terminated and we can end the loop

        jmp print_hex_loop

print_hex_loop_end:
    mov bx, HEX_OUT
    call print

    popa
    ret

; globals
HEX_OUT: db '0x0000', 13, 10, 0