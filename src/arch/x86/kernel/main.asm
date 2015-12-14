BITS 16
  mov si, welcome
  call println
routine:
  mov si, prompt
  call print
  mov di, input
  call getstr
  mov si, input
  cmp byte [si], 0
  je routine
  mov si, input
  call displayargs
  jmp routine
println:
  call print
  mov ax, 0E0Ah
  int 10h
  mov al, 0Dh
  int 10h
  ret
print:
  mov ah, 0Eh
.loop:
  lodsb
  cmp al, 0
  je .return
  int 10h
  jmp .loop
.return:
  ret
getstr:
  xor bl, bl
.loop:
  xor ah, ah
  int 16h
  cmp al, 8
  je .erase
  cmp al, 13
  je .return
  cmp bl, 63
  je .loop
  mov ah, 0Eh
  int 10h
  stosb
  inc bl
  jmp .loop
.erase:
  cmp bl, 0
  je .loop
  dec di
  mov byte [di], 0
  dec bl
  mov ax, 0E08h
  int 10h
  mov al, 20h
  int 10h
  mov al, 8
  int 10h
  jmp .loop
.return:
  xor al, al
  stosb
  mov ax, 0E0Dh
  int 10h
  mov al, 10
  int 10h
  ret
displayargs:
  mov ah, 0Eh
.loop:
  lodsb
  cmp al, 0
  je .return
  cmp al, 32
  je .segment
  int 10h
  jmp .loop
.segment:
  mov al, 44
  int 10h
  jmp .loop
.return:
  mov al, 10
  int 10h
  mov al, 13
  int 10h
  ret
welcome db 'Welcome to Project Wintergreen!', 0
prompt db '[Wintergreen]~ ', 0
input times 64 db 0
