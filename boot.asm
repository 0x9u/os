	mov ah , 0x0e
	mov bp, 0x8000
	mov sp, bp

	mov bx, 'b'
	mov al, bl
	int 0x10

	mov di, msg
	call print

	mov bx, 'c'
	mov al, bl
	int 0x10

	jmp $

msg: db 10, "Baby gronk needs his milk", 13, 10, 0

%include "lib/io.asm"

times 510-($-$$) db 0 ; make it 512 bytes so pc knows it's a boot sector
dw 0xaa55 ; magic number
