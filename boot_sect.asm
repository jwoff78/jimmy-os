;
;  Basic stack stuff
;

;[org 0x7c00] ; Affset all memory readings to where BIOS would start loading the bootloader

mov ah, 0x0e ; int 10/ah = 0eh -> print

mov bp, 0x8000 ; Set base of stack above boot sector
mov sp, bp ; Resets stack

; Push these chars onto stack. They will be convertex to 16-bit by appending 0x00 to the end.
; The value wont change but the size doubles(0x01 becomes 0x0100 wich both is worth 1)

push 'A'
push 'B'
push 'C'

pop bx ; Pop the current 16-bit stack value. Note that this is 16 bits(one word)
mov al, bl ; Copy the low bits of bl to al(0x12 in the number 0x1234)
int 0x10 ; Print al

pop bx ; Pop next value
mov al, bl
int 0x10 ; Print al

mov al, [0x7ffe] ; To prove the stack grows down, fetch the char at
                ; 0x8000 - 0x2 (i.e 16 bits)
int 0x10        ; print(al)

jmp $ ; Just hang the CPU

;
; Boot sector magic(padding + identification)
;

times 510-($-$$) db 0

dw 0xaa55