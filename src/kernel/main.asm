  BITS 16
  mov si, welcome
  call temp_print
  jmp $
  welcome db 'Welcome to Project Wintergreen!', 0
temp_print:
  mov ah, 0Eh
.loop:
  lodsb
  cmp al, 0
  je .done
  int 10h
  jmp .loop
.done:
  ret
