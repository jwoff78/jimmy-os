;
;  Basic find-the-byte
;

[org 0x7c00] ; Affset all memory readings to where BIOS would start loading the bootloader

mov ah, 0x0e ; int 10/ah = 0eh -> print


; First attempt
mov al, the_secret
int 0x10

; Second attempt
mov al, [the_secret]
int 0x10

; Third attempt
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; Attempt 4
mov al, [0x7c1e]
int 0x10

jmp $ ; Jump to current(while true be like)

the_secret:
    db "X"

;
; Boot sector magic(padding + identification)
;

times 510-($-$$) db 0

dw 0xaa55