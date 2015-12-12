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
tss32:
  .link dw 0
  .link_h dw 0
  .esp0 dd 0
  .ss0 dw 0
  .ss0_h dw 0
  .esp1 dd 0
  .ss1 dw 0
  .ss1_h dw 0
  .esp2 dd 0
  .ss2 dw 0
  .ss2_h dw 0
  .cr3 dd 0
  .eip dd 0
  .eflags dd 0
  .eax dd 0
  .ecx dd 0
  .edx dd 0
  .ebx dd 0
  .esp dd 0
  .ebp dd 0
  .esi dd 0
  .edi dd 0
  .es dw 0
  .es_h dw 0
  .cs dw 0
  .cs_h dw 0
  .ss dw 0
  .ss_h dw 0
  .ds dw 0
  .ds_h dw 0
  .fs dw 0
  .fs_h dw 0
  .gs dw 0
  .gs_h dw 0
  .ldt dw 0
  .ldt_h dw 0
  .trap dw 0
  .iomap dw 0
