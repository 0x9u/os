[bits 16]

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
  mov byte [es:0x001000], 0xAA
  
  cmp byte [es:0x000000], 0x55
  jne a2_test_err

  cmp byte [es:0x001000], 0xAA
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