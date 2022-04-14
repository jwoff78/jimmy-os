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
    mov dh, 54   ; The first 54 sectors(as big as the ISO file is), from the boot disk
    mov dl, [BOOT_DRIVE]  ; To adress KERNEL_OFFSET
    call disk_load

    ret

[bits 32]

BEGIN_PM:
    
    mov ebx, MSG_PROT_MODE
    call print_string_pm ; Use 32 bit ver

    ; This magic code disables the blinking cursor
    push    ax
    push    dx
    mov     al,0x0A         ;Function 10 of the video card.
    mov     dx,0x03D4       ;Video command port
    out     dx,al           ;Activate command
    mov     dx,0x03D5       ;Video status port
    in      al,dx
    or      ax,00010000b    ;Flick the cursor off.
    out     dx,ax
    push    dx
    push    ax

    call KERNEL_OFFSET ; Jump to kernel adress

    jmp $ ; Hang

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