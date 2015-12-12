  BITS 16
load_gdt32:
  cli
  lgdt [gdt_desc]
  mov eax, cr0
  or al, 2
  mov cr0, eax
  ret
gdt_32:
  dq 0
  dq 0C09A0000001000h
  dq 0C0920000001000h
  dq 0
gdt_32_desc:
  dw gdt_32
  dd gdt_32 - gdt_32_desc - 1
