  BITS 16
  mov ax, 7C0h ; Set up the stack
  mov ss, ax
  add ax, 512
  mov ds, ax
  mov sp, 4096
  mov [boot], dl ; Store the boot disc ID
  xor dh, dh ; Read the filesystem header
  mov cx, 2
  mov bx, 1000h
  mov es, bx
  xor bx, bx
load_fs:
  mov ax, 201h ; Load the filesystem header into RAM
  int 13h
  jc .reset
  jmp read_fs
.reset:
  xor ah, ah ; Reset the disc if something went wrong
  int 13h
  jc panic
  jmp load_fs
read_fs:
  mov di, 1010h ; Set the position to search from
  mov si, kernelname
.loop:
  call strcmp ; Search for the kernel
  jc load_kernel
  add di, 8
  jmp .loop
load_kernel:
  mov ax, [si] ; Load the kernel from the filesystem
  call lbachs
  mov bx, 1000h
  mov es, bx
  xor bx, bx
  int 13h
  jc .reset
  mov ax, 1000h ; Run the kernel
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov ss, ax
  jmp 1000h:0h
strcmp:
  mov al, [si]
  mov bl, [di]
  cmp al, bl
  jne .ne
  cmp al, 0
  je .done
  inc di
  inc si
  jmp strcmp
.ne:
  clc
  ret
.done:
  stc
  ret
lbachs:
  push bx
  push ax
  mov bx, ax
  xor dx, dx
  div word 18
  inc dl
  mov cl, dl
  mov ax, bx
  xor dx, dx
  div word 18
  xor dx, dx
  div word 2
  mov dh, dl
  mov ch, al
  pop ax
  pop bx
  mov dl, byte [boot]
  ret
kernelname db 'kernel', 0
boot db 0
