  BITS 16
  mov ax, 7C0h ; Set up the stack
  mov ss, ax
  add ax, 512
  mov ds, ax
  mov sp, 4096
  xor dh, dh ; Read the filesystem header
  mov cx, 2
  mov bx, 1000h
  mov es, bx
  xor bx, bx
load_fs:
  mov ax, 201h
  int 13h
  jc .reset
  jmp read_fs
.reset:
  xor ah, ah
  int 13h
  jc panic
  jmp load_fs
read_fs:
  ; TODO: Read the filesystem and find the kernel
load_kernel:
  ; TODO: Load the kernel from the filesystem
run_kernel:
  mov ax, 1000h
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov ss, ax
  jmp 1000h:0h
