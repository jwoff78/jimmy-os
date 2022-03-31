;
;  Disk reading
;
[org 0x7c00]

    mov [BOOT_DRIVE], dl ; BIOS stores out boot drive in DL, so it's best to remember this

    mov bp, 0x8000 ; Here we set our stack out of the way
    mov sp, bp

    mov bx, 0x9000 ; Load 5 sectors to 0x0000(ES):0x9000(BX) from the boot disk
    mov dh, 5
    mov dl, [BOOT_DRIVE]
    call disk_load

    mov dx, [0x9000 + 512] ; Also, print the first word from the 2nd loaded sector
                           ; Should be 0xface
    call print_hex

    jmp $

; Inclusions can and should be done post-loop to avoid calling them

; GLOBALS
BOOT_DRIVE: db 0

;
; Boot sector magic(padding + identification)
;

times 510-($-$$) db 0
dw 0xaa55

; We know that BIOS will load only the first 512 byte sector from the disk,
; So if we purposely add a few more sectors to our code by repeating some familliar
; numbers, we can prove ourselfs that we actually loaded those additional
; two sectors from the disk we booted from
times 256 dw 0xdada
times 256 dw 0xface