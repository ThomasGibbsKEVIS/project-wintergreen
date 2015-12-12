%include "a20.asm"
%include "gdt.asm"
%include "vga.asm"
  BITS 16
bootup_16:
  call enable_a20
  jc $
  call load_gdt32
  jmp 0h:bootup_32
  BITS 32
bootup_32:
  jmp $
