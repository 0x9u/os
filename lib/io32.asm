[bits 32]

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_string_pm:
  pusha
  mov edx, VIDEO_MEMORY

print_string_pm_loop:
  mov al, [ebx] ; al = char value
  mov ah, WHITE_ON_BLACK ; ah = attributes (foreground and background)

  cmp al, 0 ; jmp when reach the end
  je print_string_pm_done

  mov [edx], ax

  inc ebx,
  add edx, 2

  jmp print_string_pm_loop

print_string_pm_done:
  popa
  ret