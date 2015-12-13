BITS 16
  mov ax, 7C0h
  mov ss, ax
  mov sp, 4096
  mov cx, 2
  xor dh, dh
  mov [boot], dl
  xor bx, bx
  mov es, bx
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
  ; TODO: Find the kernel
loadkernel:
  ; TODO: Load the kernel at 0x00000000
pmodeinit:
  mov ax, 2402h
  int 15h
  jc panic
  cmp al, 1
  je .skipa20
  mov ax, 2401h
  int 15h
  jc panic
  jmp pmodeinit
.skipa20:
  cli
  lgdt [gdt_desc]
  mov ax, 0 ; TODO: Make a pointer to the TSS descriptor
  ltr ax
  mov eax, cr0
  or al, 2
  mov cr0, eax
  xor ax, ax
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov ss, ax
  jmp 0:0
panic:
  mov si, panicmsg
  mov ah, 0Eh
.loop:
  lodsb
  cmp al, 0
  je $
  int 10h
  jmp .loop
  panicmsg db 'Oops! It seems a panic has occured! #BlameF3d04a', 0
  boot db 0
gdt:
  dq 0000000000000000h
  dq 0000000000000000h ; TODO: Make the code descriptor
  dq 0000000000000000h ; TODO: Make the data descriptor
  dq 0000000000000000h ; TODO: Make the TSS descriptor
gdt_desc:
  dw (gdt_desc - gdt) - 1
  dd gdt
tss:
  times 26 db 0
  times 510-($-$$) db 0
  dw 0AA55h
