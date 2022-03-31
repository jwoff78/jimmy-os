; 
; 32-bit boot sector!
;

[org 0x7c00]
KERNEL_OFFSET equ 0x1000 ; This is the offset to load kernel to
    mov bp, 0x9000 ; Set the stack
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print_string

    call load_kernel ; Load the kernel

    call switch_to_pm ; Note that this is the end

    jmp $

; INCLUDES

%include "sys16/print.asm"
%include "sys16/disk_read.asm"
%include "sys32/gtd.asm"
%include "sys32/print_pm.asm"
%include "sys32/pm_switch.asm"

[bits 16]

; load kernel
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print_string

    mov bx, KERNEL_OFFSET ; Setup the disk_load routine so that we load 
    mov dh, 15            ; The first 15 sectors, from the boot disk
    mov dl, [BOOT_DRIVE]  ; To adress KERNEL_OFFSET
    call disk_load

    ret

[bits 32]

BEGIN_PM:
    
    mov ebx, MSG_PROT_MODE
    call print_string_pm ; Use 32 bit ver

    call KERNEL_OFFSET ; Jump to kernel adress

    jmp $ ; Hand

; GLOBALS
BOOT_DRIVE      db 0
MSG_REAL_MODE   db "Started in 16-bit real mode!", 0
MSG_PROT_MODE   db "Landed in 32-bit protected mode!", 0
MSG_LOAD_KERNEL db "Loading kernel into memory.", 0

;
; Boot sector magic(padding + identification)
;

times 510-($-$$) db 0
dw 0xaa55