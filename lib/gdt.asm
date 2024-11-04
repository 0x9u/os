[bits 16]

setup_vga:
  pusha 
  mov ax, 0x3
  int 0x10
  popa
  ret

setup_gdt:

gdt_start:
gdt_null: dq 0x0 ; used for null descriptor

gdt_code:
dw 0xffff ; limit (0-15 bits)
dw 0x0 ; base (bits 0-15)
db 0x0 ; base (bits 16 - 23)
db 10011010b ; type flags 
db 11001111b ; limit flags (16 - 19)
db 0x0  ; base (bits 24-31)

gdt_data:
dw 0xffff ; limit (0-15 bits)
dw 0x0 ; base (bits 0-15)
db 0x0 ; base (bits 16 - 23)
db 10011010b ; type flags 
db 11001111b ; limit flags (16 - 19)
db 0x0  ; base (bits 24-31)

gdt_end:

gdt_descriptor:
dw  gdt_end - gdt_start - 1 ;  size of gdt is always 1 less
dd  gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start