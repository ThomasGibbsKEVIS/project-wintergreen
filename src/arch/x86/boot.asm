BITS 16
  mov ax, 7C0h
  mov ss, ax
  mov sp, 4096
  mov cx, 2
  xor dh, dh
  mov [boot], dl
  mov bx, 1000h
  mov es, bx
  xor bx, bx
loadfs:
  mov ax, 208h
  int 13h
  jc .reset
  jmp findkernel
.reset:
  xor ah, ah
  int 13h
  jc panic
  jmp loadfs
findkernel:
  ; TODO: Make a function to find the kernel
  ; TODO: Convert LBA returned from the filesystem to a CHS in int 13h format
  mov dl, [boot]
  mov bx, 1000h
  mov es, bx
  xor bx, bx
loadkernel:
  mov ah, 2
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
  jmp 1000h:0
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
  boot db 0
  times 510-($-$$) db 0
  dw 0AA55h
