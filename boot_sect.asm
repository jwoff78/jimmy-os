;
;  Basic stack stuff
;

[org 0x7c00] ; Affset all memory readings to where BIOS would start loading the bootloader

mov dx, 0x1234
call print_hex

mov bx, NEWLINE
call print

mov bx, HELLO_WORLD
call print

jmp $ ; Just hang the CPU

; Inclusions can and should be done post-loop to avoid calling them

%include "print.asm"

;
; Boot sector magic(padding + identification)
;

times 510-($-$$) db 0

dw 0xaa55