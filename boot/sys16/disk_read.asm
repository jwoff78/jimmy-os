; load DH sectors to ES:BX from drive DL

disk_load:
    push dx ; Store DX on stack so later we can recal
            ; how many sectors were request to be read
            ; even if it was altered
    
    mov ah, 0x02 ; BIOS read sector func
    mov al, dh ; Read DH sectors
    mov ch, 0x00 ; Select cylinder 0
    mov dh, 0x00 ; Select head 0
    mov cl, 0x02 ; Start readong from second sector(i.e after the boot sector)

    int 0x13 ; Run it!

    jc disk_error ; Error check

    pop dx ; Restore DX
    cmp dh, al ; if sectors read != sectors expected, display error
    jne disk_error
    ret

disk_error:

    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

; Variables
DISK_ERROR_MSG: db "Disk read error!", 0