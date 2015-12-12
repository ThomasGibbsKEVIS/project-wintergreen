db 'ProjWintergreen', 0 ; First 16 bytes: Disc Label
db 'kernel', 0, 0, 0 ; Filename(8 bytes) and the name buffer(1 byte, always 0)
dw 3 ; LBA location of the file
dw 0 ; Owner ID(The user ID of the file owner, 0 being the system)
db 00000000b ; File permissions(Owner gets all permissions this is permissions for anyone else)
dw 0 ; Reserved(Really not used for anything)
times 512-($-$$) db 0 ; Buffer for the rest of the sector
