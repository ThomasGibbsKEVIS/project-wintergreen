BITS 16
init_mouse:
  mov ax, 0C205h
  mov bh, 3
  int 15h
  mov ax, 0C200h
  int 15h
  ret
get_mouse:
  mov ax, 0C209h
  int 15h
  ret
