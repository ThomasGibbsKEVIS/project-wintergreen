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
  mov si, welcome ; Welcome the user
  call print
getcommand:
  mov si, prompt ; Display the prompt
  call print
  mov di, buffer ; Get the command
  call getstr
  mov si, buffer ; Is the command nothing?
  cmp byte [si], 0
  je getcommand
  mov si, buffer
  mov di, peektrigger ; Is the command peek?
  call strcmp
  jc peek
  mov di, poketrigger ; Is the command poke?
  call strcmp
  jc poke
  mov di, loadtrigger ; Is the command load?
  call strcmp
  jc load
  mov di, runtrigger ; Is the command run?
  call strcmp
  jc run
  mov si, invalid ; Display the "invalid command" message
  call print
  jmp getcommand
  welcome db 'Welcome to Project Wintergreen!', 13, 10, 0
  invalid db 'Oops! That does not seem to be a command!', 13, 10, 0
  wipmsg db 'This command is a work-in-progress.', 13, 10, 0
  prompt db 'kernel>', 0
  peektrigger db 'peek', 0
  poketrigger db 'poke', 0
  loadtrigger db 'load', 0
  runtrigger db 'run', 0
  buffer times 64 db 0
print:
  mov ah, 0Eh ; Set up the interrupt for printing
.loop:
  lodsb ; Get a byte from SI
  cmp al, 0 ; Is it 0?
  je .done ; If so then job well done
  int 10h ; Otherwise print the character to the screen
  jmp .loop ; Look for another character
.done:
  ret ; Back to the main loop
getstr:
  xor cl, cl ; Clear CL as it is the length of the string
.loop:
  xor ah, ah ; Wait for a keystroke
  int 16h
  cmp al, 8 ; Is it backspace?
  je .bs
  cmp al, 13 ; Is it enter?
  je .done
  cmp cl, 63 ; Is the string at the maximum length
  je .loop
  mov ah, 0Eh ; Print the character
  int 10h
  stosb ; Store the character in a link
  inc cl
  jmp .loop ; Get another keystroke
.bs:
  cmp cl, 0 ; Is there nothing in the string to begin with?
  je .loop
  dec di ; Wipe the character from the string
  mov byte [di], 0
  dec cl
  mov ax, 0E08h ; Erase the character from the screen
  int 10h
  mov al, 20h
  int 10h
  mov al, 8 ; And move the cursor back
  int 10h
  jmp .loop
.done:
  xor al, al ; Add a blank entry
  stosb
  mov ax, 0E0Dh ; Newline
  int 10h
  mov al, 10
  int 10h
  ret ; Return to the shell
strcmp:
  mov al, [si] ; Grab a character from each string
  mov bl, [di]
  cmp al, bl ; Compare them
  jne .ne ; If they arn't the same then return false
  cmp al, 0 ; If the first string has come to an end then return true
  je .done
  inc di ; Otherwise look for the next character
  inc si
  jmp strcmp
.ne:
  clc ; Reutrn false
  ret
.done:
  stc ; Return true
  ret
peek:
  mov si, wipmsg
  call print
  jmp getcommand
poke:
  mov si, wipmsg
  call print
  jmp getcommand
load:
  mov si, wipmsg
  call print
  jmp getcommand
run:
  mov si, wipmsg
  call print
  jmp getcommand
  times 3556-($-$$) db 0
  easteregg db 'Totally not an easter egg', 13, 10, 0 ; You cheater
