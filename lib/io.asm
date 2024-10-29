; 
; print
; Params:
;  bx - address of string to print
; 

print:
  push bx
  ; set text output
  mov ah, 0x0e

print_loop:
  
  mov al, [bx]
  test al, al
  je print_loop_end

  int 0x10
  inc bx
  jmp print_loop

print_loop_end:
  pop bx
  ret

;
; disk_load
; load sectors specified by dh
; Params:
; dh - amount of sectors to load
; bx - limit
;
disk_load:
  push dx
  

  ; also its up to user to set bx (load limit)
  mov ah, 0x02 ; BIOS read sector
  mov al, dh ; Read dh sectors
  mov ch, 0x00 ; select cylinder 0
  mov dh, 0x00 ; select head 0
  mov cl, 0x02 ; start reading from 2nd sector (after boot sector)
  int 0x13

  jc disk_err_1 ; jmp if carry flag is set
  ; carry flag is used as general error

  pop dx
  ret

disk_err_1:
  mov bx, disk_err_1_msg
  call print
  jmp $

disk_err_1_msg: db "Disk read error 1!", 0
disk_err_2_msg: db "Disk read error 2!", 0


enable_a20:
  pusha
  
  mov ax, 0x2401 ; Fast a20
  int 0x15
  jc a2_err

  popa
  ret

a2_err:
  mov bx, a2_err_msg
  call print
  jmp $

a2_err_msg: db "A2 error!", 0

test_a20:
  pusha

  mov ax, 0x0000
  mov es, ax
  mov byte [es:0x000000], 0x55
  mov byte [es:0x000010], 0xAA
  
  cmp byte [es:0x000000], 0x55
  jne a2_test_err

  cmp byte [es:0x000010], 0xAA
  jne a2_test_err

  mov bx, a2_success_msg
  call print

  popa
  ret

a2_test_err:
  mov bx, a2_test_err_msg
  call print
  jmp $

a2_test_err_msg: db "A2 test error!", 0

a2_success_msg: db "A2 success!!!", 13, 10, 0

a2_load_msg: db "Loading A2", 13, 10, 0