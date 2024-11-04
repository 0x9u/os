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

	call setup_vga
	
	call switch_to_pm

	jmp init_pm

msg: db "Baby gronk needs his milk", 13, 10, 0
msg2: db "Fanum tax", 13, 10, 0

; IMPORT HERE

%include "lib/io.asm"

times 510-($-$$) db 0 ; make it 512 bytes so pc knows it's a boot sector
dw 0xaa55 ; magic number

second_segment_start:

%include "lib/pm.asm"
%include "lib/gdt.asm"

print_after_disk_load:
    pusha

    mov bx, oob_msg
    call print

    popa
    ret

oob_msg:
    db "hi from sector 2", 13, 10, 0

[bits 32]

init_pm: ; initialise segment registers

  mov ax, DATA_SEG
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax


  mov ebp, 0x90000
  mov esp, ebp

	mov ebx, msg_init_pm
	call print_string_pm

	jmp $

	call protected_mode ; never return here

protected_mode:

	mov ebx, msg_pm
	call print_string_pm

	jmp $

msg_init_pm: db "Successfully initialised protected mode", 13, 10, 0
msg_pm: db "Successfully entered 32-bit protected mode", 13, 10, 0

%include "lib/io32.asm"

times 510-($-second_segment_start) db 0 ; make it the 2nd sector