%include "mouse.asm"
%include "vga.asm"

BITS 16
  call init_vga
  call init_mouse
  mov al, 15
drawbackground:
  mov [gs:di], al
  inc di
  cmp di, 64001
  je .pre
  jmp drawbackground
.pre:
  xor di, di
routine:
  call get_mouse
  call set_pos
  call render
  jmp routine
set_pos:
  call .setx
  call .sety
  ret
.setx:
  test cl, cl
  js .subx
  xor ch, ch
  add cx, [mouse_x]
  cmp cx, 320
  jg .maxx
  mov [mouse_x], cx
  ret
.maxx:
  mov cx, 320
  mov [mouse_x], cx
  ret
.subx:
  and cl, 127
  xor ch, ch
  sub cx, [mouse_x]
  cmp cx, 127
  jl .minx
  mov [mouse_x], cx
  ret
.minx:
  xor cx, cx
  mov [mouse_x], cx
  ret
.sety:
  ret ; Placeholder
render:
  mov ax, 0FF0h
  mov [gs:di], ah
  mov cx, [mouse_x]
  mov di, cx
  mov [gs:di], al
  mouse_x dw 0
  mouse_y db 0
