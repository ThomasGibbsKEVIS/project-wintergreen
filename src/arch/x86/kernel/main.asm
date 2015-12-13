%include "keyboard.asm"
%include "vga.asm"

BITS 16
routine:
  call render
  call getinput
  call multitask_routine
  jmp routine
