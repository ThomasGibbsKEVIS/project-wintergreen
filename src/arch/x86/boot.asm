; Project Wintergreen - An operating system meant to be efficient as possible
; Copyright (C) 2015  0xF3d04a

; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU Affero General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.

; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU Affero General Public License for more details.

; You should have received a copy of the GNU Affero General Public License
; along with this program.  If not, see <http://www.gnu.org/licenses/>.

BITS 16
  mov ax, 7C0h
  mov ss, ax
  mov ax, 1000h
  mov ds, ax
  mov sp, 4096
  mov cx, 2
  mov bx, 1000h
  mov es, bx
  xor bx, bx
  xor dh, dh
loadkernel:
  mov ax, 208h
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
  jmp 1000h:0h
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
  times 510-($-$$) db 0
  dw 0AA55h
