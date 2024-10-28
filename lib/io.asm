; 
; print
; Params:
;  bx - address of string to print
; 

print:
  pusha

print_loop:
  
  mov cx, [bx]

  cmp cl, 0
  je print_loop_end

  mov al, cl
  int 0x10

  inc bx
  jmp print_loop

print_loop_end:

  popa
  ret