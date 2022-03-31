;
;  Disk reading
;


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