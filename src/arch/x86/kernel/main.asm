BITS 32
  mov si, welcome
  mov ax, 0B800h
  mov gs, ax
  xor di, di
  mov ah, 0Fh
.loop:
  lodsb
  cmp al, 0
  je $
  mov [gs:di], ax
  add di, 2
  jmp .loop
  welcome db 'Welcome to Project Wintergreen', 0
