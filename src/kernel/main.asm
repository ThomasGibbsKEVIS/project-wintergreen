; 16-bit drivers
%include "a20.asm"
%include "gdt32.asm"
%include "idt32.asm"
; 32-bit drivers
%include "paging.asm"
%include "gdt64.asm"
%include "idt64.asm"
; 64-bit drivers
%include "vga.asm"
  BITS 16
bootup_16:
  call enable_a20
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
