; 
; print
; Params:
;  ax - address of string to print
; 

print:
  pusha

print_loop:
  
  mov al, [di]
  xor ah, ah
  cmp al, 0
  je print_loop_end
  int 0x10

  inc di
  jmp print_loop
print_loop_end:

  mov bx, 'a'
  mov al, bl
  int 0x10

  popa
  ret