BITS 16
init_vga:
  mov ax, 13h
  int 10h
  mov ax, 0A000h
  mov gs, ax
  xor di, di
  ret
