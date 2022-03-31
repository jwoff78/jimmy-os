nasm boot_sect.asm -f bin -o build/boot_sect.bin
[ $? -eq 0 ]  || exit 1

gcc -ffreestanding -fno-pic -m32 -mmanual-endbr -c kernel/kernel.c -o build/kernel.o
[ $? -eq 0 ]  || exit 1
ld -o build/kernel.bin -m elf_i386 -Ttext 0x1000 --oformat binary build/kernel.o -nmagic -n -Tlinker.ld
[ $? -eq 0 ]  || exit 1

cat build/boot_sect.bin build/kernel.bin > os_image

qemu-system-x86_64 -fda os_image