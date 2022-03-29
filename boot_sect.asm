;
;  Basic stack stuff
;

[org 0x7c00] ; Affset all memory readings to where BIOS would start loading the bootloader

mov dx, 0x1fb6
call print_hex

jmp $ ; Just hang the CPU

; Inclusions can and should be done post-loop to avoid calling them

%include "print.asm"

QUIT_MSG:
 dw 'Bye!', 0

;
; Boot sector magic(padding + identification)
;

times 510-($-$$) db 0

dw 0xaa55