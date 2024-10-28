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

  cmp dh, al ; if sectors read != sectors expected then error
  jne disk_err_2
  
  pop dx
  ret

disk_err_1:
  mov bx, disk_err_1_msg
  jmp print_disk_err
disk_err_2:
  mov bx, disk_err_2_msg

print_disk_err:
  call print
  jmp $

disk_err_1_msg: db "Disk read error 1!", 0
disk_err_2_msg: db "Disk read error 2!", 0
