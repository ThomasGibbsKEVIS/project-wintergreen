db 'ProjWintergreen', 0 ; First 16 bytes: Disc Label
db 'kernel', 0, 0, 0 ; Filename(8 bytes) and the name buffer(1 byte, always 0)
dw 3 ; LBA location of the file
db 32 ; Size of the file in sectors
dw 0 ; Unused bytes of last sector(512 - (<filesize in bytes> % 512))
db 0 ; Owner ID(The user ID of the file owner, 0 being the system)
db 00000000b ; File permissions(Owner gets all permissions this is permissions for anyone else)
db 'shell', 0, 0, 0, 0
dw 35
db 16
dw 0
db 0
db 00000000b
times 512-($-$$) db 0 ; Buffer for the rest of the sector
