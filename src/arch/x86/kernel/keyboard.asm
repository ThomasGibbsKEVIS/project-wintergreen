BITS 16
getkey:
  mov ah, 1
  int 16h
  jnz .return
  xor ax, ax
.return:
  ret
