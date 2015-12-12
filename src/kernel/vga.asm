  BITS 16
init_graphics:
  mov ax, 13h ; Set BIOS to VGA mode 0x13
  int 10h
  mov ax, 0A000h ; Set the video memory pointer
  mov gs, ax
  xor di, di ; Zero the memory offset
  ret
calculate_position:
  mov bl, [vga_row] ; Simple enough: Calculate where the pixel should go
  mul di, bl, 320
  mov bx, [vga_col]
  add di, bx
  ret
vga_move_up:
  mov bl, [vga_row]
  dec bl
  mov [vga_row], bl
  ret
vga_move_down:
  mov bl, [vga_row]
  inc bl
  mov [vga_row], bl
  ret
vga_move_left:
  mov bx, [vga_col]
  dec bx
  mov [vga_col], bx
  ret
vga_move_right:
  mov bx, [vga_col]
  inc bx
  mov [vga_col], bx
  ret
write_entry:
  call calculate_position
  mov [gs:di], al ; This line actually writes the data
  ret
