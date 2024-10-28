[org 0x7c00]
[bits 16]

	; VGA mode
	;mov ax, 0x13
	;int 0x10
	
	mov bp, 0x7c00
	mov sp, bp

	mov bx, msg
	call print

	mov bx, 0x7e00 ; load 0x000
	mov dh, 1
	mov dl, [BOOT_DRIVE]
	call disk_load

	jmp $

msg: db "Baby gronk needs his milk", 13, 10, 0

; Globals

BOOT_DRIVE: db 0

; IMPORT HERE

%include "lib/io.asm"

times 510-($-$$) db 0 ; make it 512 bytes so pc knows it's a boot sector
dw 0xaa55 ; magic number

times 256 dw 0xdada
times 256 dw 0xface