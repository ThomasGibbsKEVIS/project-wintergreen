BITS 16
  mov ax, 7C0h
  mov ss, ax
  mov ax, 1000h
  mov ds, ax
  mov sp, 4096
  mov cx, 2
  mov bx, 1000h
  mov es, bx
  xor bx, bx
  xor dh, dh
loadkernel:
  mov ax, 208h
  int 13h
  jc .reset
  jmp runkernel
.reset:
  xor ah, ah
  int 13h
  jc panic
  jmp loadkernel
runkernel:
  mov ax, 1000h
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov ss, ax
  jmp 1000h:0h
panic:
  mov si, panicmsg
  mov ah, 0Eh
.loop:
  lodsb
  cmp al, 0
  je $
  int 10h
  jmp .loop
  panicmsg db 'Oops! #BlameF3d04a', 0
  times 510-($-$$) db 0
  dw 0AA55h
