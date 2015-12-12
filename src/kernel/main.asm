%include "a20.asm"
%include "gdt.asm"
%include "idt.asm"
%include "panic.asm"
%include "paging.asm"
%include "vga.asm"
  BITS 16
bootup_16:
  call enable_a20
  jc panic16
  call load_gdt32
  call load_idt32
  jmp 0h:bootup_32
  BITS 32
bootup_32:
  call enable_paging
  call load_gdt64
  call load_idt64
  jmp 0h:bootup_64
  BITS 64
bootup_64:
  call init_vga
  ; TODO: Display the bootsplash
routine:
  ; TODO: Write the multitasking routine
