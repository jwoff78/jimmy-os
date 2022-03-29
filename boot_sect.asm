;
;  Basic stack stuff
;

;[org 0x7c00] ; Affset all memory readings to where BIOS would start loading the bootloader

mov bx, 30

; if bx <= 4, run(jump to) "if"
cmp bx, 4
jle if

; if bx < 40, do "elif"
cmp bx, 40
jl elif

; Otherwise, do "else"
jmp else

if:
    mov al, 'A'
    jmp end ; Jump to end of loop
elif:
    mov al, 'B'
    jmp end ; Jump to end of the loop
else:
    mov al, 'C'
end:


mov ah, 0x0e ; int 10/ah = 0eh -> print
int 0x10        ; print(al)

jmp $ ; Just hang the CPU

;
; Boot sector magic(padding + identification)
;

times 510-($-$$) db 0

dw 0xaa55