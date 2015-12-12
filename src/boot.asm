  BITS 16
  ; Project Wintergreen is a simple operating system made in Assembly
  ; Copyright (C) 2015  0xF3d04a

  ; This program is free software: you can redistribute it and/or modify
  ; it under the terms of the GNU Affero General Public License as published
  ; by the Free Software Foundation, either version 3 of the License, or
  ; (at your option) any later version.

  ; This program is distributed in the hope that it will be useful,
  ; but WITHOUT ANY WARRANTY; without even the implied warranty of
  ; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  ; GNU Affero General Public License for more details.

  ; You should have received a copy of the GNU Affero General Public License
  ; along with this program.  If not, see <http://www.gnu.org/licenses/>.
  mov ax, 7C0h ; Set the stack
  mov ss, ax
  add ax, 512
  mov ds, ax
  mov sp, 4096
  xor dh, dh ; Read the kernel from the disc
  mov cx, 2
  mov bx, 1000h
  mov es, bx
  xor bx, bx
load_kernel:
  mov ax, 207h
  int 13h
  jc reset_disc ; If it failed reset the disc and try again
  mov ax, 1000h ; But if it worked then set the stack
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov ss, ax
  jmp 1000h:0h ; And load it
reset_disc:
  xor ah, ah
  int 13h
  jmp load_kernel
  times 510-($-$$) db 0
  dw 0AA55h
