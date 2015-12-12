%include "a20.asm"
%include "gdt.asm"
%include "panic.asm"
%include "vga.asm"
  BITS 16
bootup_16:
  call enable_a20
  jc panic16
  call load_gdt32
  call load_idt32
  jmp 0h:bootup_32
  BITS 32
bootup_32:
  mov si, welcome
  call temp_print
  jmp $
  welcome db 'Welcome to Project Wintergreen', 0
temp_print:
  xor ax, ax
  mov gs, ax
  xor di, di
  mov ah, 0Fh
.loop:
  lodsb
  cmp al, 0
  je .done
  mov [gs:di], ax
  add di, 2
  jmp .loop
.done:
  ret
