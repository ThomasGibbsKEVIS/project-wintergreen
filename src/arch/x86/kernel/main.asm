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
