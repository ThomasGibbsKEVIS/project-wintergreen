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
  mov ax, 07C0h ; Set the stack
  mov ss, ax
  mov ax, 1000h
  mov ds, ax
  mov ss, 2000h
  mov ax, 2401h ; Grant us more memory
  int 15h
  jmp $ ; Infinite hang(temporary)
  times 510-($-$$) db 0
  dw 0AA55h
