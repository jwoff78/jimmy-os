[bits 32]
; Constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; Prints a null-terminated pointed to by EDX
print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY ; Set EDX to start of video memory
print_string_pm_loop:
    mov al, [ebx] ; Store the char at EDX in AL
    mov ah, WHITE_ON_BLACK ; Store attribs in AH

    cmp al, 0 ; If al == 0, jump to done
    je print_string_pm_done

    mov [edx], ax ; Store char and attribs at current char cell

    add ebx, 1 ; Increment EBX to the next char in string
    add edx, 2 ; Move to the next char cell in vid memory

    jmp print_string_pm_loop

print_string_pm_done:
    popa
    ret ; End the function