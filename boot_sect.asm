; 
; 32-bit boot sector!
;

[org 0x7c00]

    mov bp, 0x9000 ; Set the stack
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print_string

    call switch_to_pm ; Note that this is the end

    jmp $

; INCLUDES

%include "print.asm"
%include "sys32/gtd.asm"
%include "sys32/print_pm.asm"
%include "sys32/pm_switch.asm"

[bits 32]

BEGIN_PM:
    
    mov ebx, MSG_PROT_MODE
    call print_string_pm ; Use 32 bit ver

    jmp $ ; Hand

; GLOBALS
MSG_REAL_MODE db "Started in 16-bit real mode!", 0
MSG_PROT_MODE db "Landed in 32-bit protected mode!", 0

;
; Boot sector magic(padding + identification)
;

times 510-($-$$) db 0
dw 0xaa55