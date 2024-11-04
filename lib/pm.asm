[bits 16]

switch_to_pm:
  pusha

  cli
  lgdt [gdt_descriptor]

  mov   eax, cr0
  or    eax, 0x1 ; set first bit of cr0 to 1
  mov   cr0, eax ; which is protected mode

  popa
  ret





