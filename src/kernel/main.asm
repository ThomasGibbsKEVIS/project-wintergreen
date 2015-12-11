%include "vga.asm"
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
  BITS 16
  call init_graphics
  mov si, welcome
  call println
  jmp $
  welcome db 'Welcome to Project Wintergreen', 0
