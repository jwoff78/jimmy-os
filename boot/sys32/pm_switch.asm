[bits 16]

switch_to_pm:
    cli ; Disable interrupts
    lgdt  [gdt_descriptor]

    ; To make the switch, we set the first bit of CR0, a control reg
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax

    jmp CODE_SEG:init_pm ; Make a far jump to out 32-bit code
                         ; This also forces the CPU to flush its cache
                         ; of pre-fetched stuff, which can cause problems

[bits 32]
; Init reisters and the stack once in PM
init_pm:

    mov ax, DATA_SEG ; Now in PM, all old registers are meaningless
    mov ds, ax ; so we point seg registers to the DATA selector
    mov ss, ax ; Defined in the GDT
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000 ; Update the stack pos, so that it is at the top
    mov esp, ebp     ; Of the free space

    call BEGIN_PM    ; Finally, call some well-known label