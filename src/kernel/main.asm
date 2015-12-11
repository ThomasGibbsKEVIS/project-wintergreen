%include "vga.asm"

  BITS 16
  call init_graphics
  mov si, copyright
  call println
  jmp $
