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
  mov ax, 1000h
  mov ds, ax
  mov sp, 2000h
  mov ax, 2401h ; Grant us more memory
  int 15h
  mov ax, 1112h ; Set up 80x50 graphics mode
  xor bl, bl
  int 10h
  mov ax, 207h ; Read the kernel into memory
  mov cx, 1
  xor dh, dh
  xor bx, bx
  mov es, bx
  mov bx, 2000h
  int 13h
  mov ah, 2 ; Remove that annoying cursor
  xor bh, bh
  mov dx, 0FA0h
  int 10h
  mov ax, 2000h ; Set the stack for the kernel
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov ss, ax
  jmp 0h:2000h
  times 510-($-$$) db 0
  dw 0AA55h
