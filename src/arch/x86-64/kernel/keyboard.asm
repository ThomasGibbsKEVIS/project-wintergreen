BITS 64
init_keys:
  out 64h, 0F5h
  call waitack
  jc init_keys
.resend1:
  out 64h, 0F2h
  call waitack
  jc .resend1
.resend2:
  call waitpacket
  cmp al, 0ABh
  je .confirm
  jmp .fail
.confirm:
  out 64h, 0F0h
  out 64h, 1
  call waitack
  jc .confirm
  clc
  ret
.fail:
  stc
  ret
waitack:
  in al, 64h
  cmp al, 0FAh
  je .success
  cmp al, 0FEh
  je .fail
  jmp waitack
.success:
  clc
  ret
.fail:
  stc
  ret
waitpacket:
  in al, 64h
  cmp al, 0
  je waitpacket
  ret
