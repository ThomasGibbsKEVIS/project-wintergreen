%include "mouse.asm"
%include "vga.asm"

BITS 16
  call init_vga
  mov al, 15
drawbackground:
  mov [gs:di], al
  inc di
  cmp di, 64001
  je routine
  jmp drawbackground
routine:
  ; TODO: Render the mouse on the screen
  jmp routine
