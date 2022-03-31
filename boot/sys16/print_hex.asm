; print_hex
; Prints out a hex value to BIOS
; Useful for debugging
; USE:
; mov dx, 0x1fb6
; call print_hex
; Prints "0x1FB6"

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
    call print_string

    popa
    ret

; GLOBALS
HEX_OUT: db '0x0000', 13, 10, 0