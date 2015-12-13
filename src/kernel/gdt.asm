  BITS 16
load_gdt32:
  cli
  lgdt [gdt32_desc]
  mov eax, cr0
  or al, 2
  mov cr0, eax
  ret
gdt32:
  dq 0
  dq 0C09A0000001000h
  dq 0C0920000001000h
  dq 0
gdt32_desc:
  dw gdt_32
  dd gdt_32 - gdt_32_desc - 1
tss32:
  times 26 dd 0
