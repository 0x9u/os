final: boot.bin

boot.bin: boot.asm lib/io.asm
	nasm boot.asm -f bin -o boot.bin

run: boot.bin
	qemu-system-x86_64 boot.bin
