%include "keyboard.asm"
%include "spearmint.asm"
%include "starfruit.asm"
%include "vga.asm"

BITS 16
routine:
  call render
  call getinput
  call multitask_routine
  jmp routine
render:
  ; TODO: Make a CLI
  ret
getinput:
  call getkey
  cmp ax, 0
  je .return
  mov bl, [linelen]
  cmp al, 8
  je .bs
  cmp al, 13
  je .send
  cmp bl, 63
  je .return
  mov di, line
  mov [di:bl], al
  inc bl
  mov [linelen], bl
  jmp .return
.bs:
  cmp bl, 0
  je .return
  dec bl
  mov [di:bl], 0
  jmp .return
.done:
  mov bl, [lineready]
  mov bl, 1
  mov [lineready], bl
.return:
  ret
multitask_routine:
  ; TODO: Make the multitasking routine
  ret
line times 64 db 0
linelen db 0
lineready db 0
