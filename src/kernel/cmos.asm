  BITS 64
cmos_in:
  out 70h, al
  in al, 71h
  ret
cmos_out:
  out 70h, al
  out 71h, ah
  ret
