nasm boot_sect.asm -f bin -o boot_sect.bin
qemu-system-x86_64 -drive format=raw,file=boot_sect.bin