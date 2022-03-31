# Automatically expand to a list of existing files that match the patterns
C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

# Create a list of object files to build, simple by replacing the '.c' extention
# of filenames in C_SOURCES with '.o'
OBJ = ${C_SOURCES:.c=.o}


all: os-image

# Run whatever we need
run: all
	qemu-system-x86_64 -fda os_image

# This is the actual disk image that the computer loads
# which is the combination of out compiled bootsector and kernel
os-image: boot/boot_sect.bin kernel.bin
	cat $^ > os-image

# This builds out kernel from two object files:
# - the kernel entry, which jumps to main() in out kernel
# - the compiled C kernel
kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld -o $@ -m elf_i386 -Ttext 0x1000 $^ --oformat binary -nmagic -n -Tlinker.ld

# Build our object files
%.o : %.c ${HEADERS}
	gcc -ffreestanding -fno-pic -m32 -mmanual-endbr -c $< -o $@

# Assemble kernel entry
%.o : %.asm
	nasm $< -f elf -o $@

%.bin : %.asm
	nasm $< -f bin -I 'boot/' -o $@

# Clear away all generated files
clean:
	rm -fr *.bin *.dis *.o os-image
	rm -fr kernel/*.o boot/*.bin drivers/*.o

# Disassemble our kernel - might be useful for debugging
kernel.dis : kernel.bin
	ndisasm -b 32 $< > $@