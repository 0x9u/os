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
	call disk_load

  call print_after_disk_load

	mov bx, a2_load_msg
	call print

	call enable_a20
	call test_a20

	jmp $

msg: db "Baby gronk needs his milk", 13, 10, 0


; IMPORT HERE

%include "lib/io.asm"

times 510-($-$$) db 0 ; make it 512 bytes so pc knows it's a boot sector
dw 0xaa55 ; magic number

print_after_disk_load:
    pusha

    mov bx, oob_msg
    call print

    popa
    ret

oob_msg:
    db "hi from sector 2", 13, 10, 0
