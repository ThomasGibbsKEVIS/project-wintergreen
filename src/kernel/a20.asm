  BITS 16
enable_a20:
  call checka20
  jnc .done
  call biosa20
  call checka20
  jnc .done
  call keyboarda20
  call checka20
  jnc .done
  call fasta20
  call checka20
  jnc .done
  ret
.done:
  clc
  ret
checka20:
  mov ax, 2402h
  int 15h
  cmp al, 1
  jne .disabled
  ret
.disabled:
  stc
  ret
biosa20:
  mov ax, 2401h
  int 15h
  ret
fasta20:
  in al, 92h
  or al, 2
  out 92h, al
  ret
keyboarda20:
  cli
  call .wait1
  mov al, 0ADh
  out 64h, al
  call .wait1
  mov al, 0D0h
  out 64h, al
  call .wait2
  in al, 60h
  push eax
  call .wait1
  mov al, 0D1h
  out 64h, al
  call .wait1
  pop eax
  or al, 2
  out 60h, al
  call .wait1
  mov al, 0AEh
  out 64h, al
  call .wait1
  sti
  ret
.wait1:
  in al, 64h
  test al, 2
  jnz .wait1
  ret
.wait2:
  in al, 64h
  test al, 1
  jnz .wait2
  ret
