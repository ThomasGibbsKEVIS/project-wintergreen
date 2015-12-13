BITS 16
  db 'ProjWintergreen', 0
  db 'kernel', 0, 0, 0 ; The name of the file (8 bytes for name, 1 byte for buffer
  dd 10 ; LBA address of file
  dw 0 ; User ID of owner(0 being system)
  db 00000000b ; Permissions to anybody who doesn't own the file
  times 4096-($-$$) db 0
