; GTD
gtd_start:

gtd_null: ; The mandatory null descriptor
    dd 0x0 ; dd is define double word(4 bytes/32 bits)
    dd 0x0

gtd_code: ; Code seg descriptor
    ; base=0x0, limit=0xfffff,
    ; 1st flags: present, privilege=00, descriptor type=1 ->1001b
    ; type flags: code, readable -> 1010b
    ; 2nd flags: granularity 32-bit -> 1100b
    dw 0xffff ; Limit(0-15)
    dw 0x0 ; Base (bits 0-15)
    db 0x0 ; Base(bits 16-23)
    db 10011010b ; 1st flags, type flags
    db 11001111b ; 2nd flags, Limit(bits 19-19)
    db 0x0 ; Base (24-31)

gdt_data: ; Data segment descriptor
    ; Same except for type flags
    ; type flags: writable -> 0010b
    dw 0xffff
    dw 0x0 ; Base (bits 0-15)
    db 0x0 ; eBase(bits 16-23)
    db 10010010b ; 1st flags, type flags
    db 11001111b ; 2nd flags, Limit(bits 19-19)
    db 0x0 ; Base (24-31)

gdt_end: ; We put a label at the end so that the compiler can
         ; Calculate the size of the GDT for our GDT descriptor

gdt_descriptor:
    dw gdt_end - gtd_start - 1 ; Size of the GDT, always one less
    dd gtd_start ; Start adress

; Define some handy GDT constants for the GDT descriptor offsets,
; which are what segment registers must contain when in protected mode.
; For example, when we set DS = 0x10 in PM, the CPU knows that we mean
; it to use the segment described at offset 0x10(i.e 16 bytes) in our GDT,
; which in our case is te DATA segment (0x0 -> NULL, 0x08 -> CODE; 0x10 -> DATA)
CODE_SEG equ gtd_code - gtd_start
DATA_SEG equ gdt_data - gtd_start