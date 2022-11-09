;Cambia el modo de video a 04h que es 320x200
mov ah, 00h
mov al, 04h
int 10h

;Cambia el color de fondo a 05h que es magenta
mov ah, 0bh
mov bx, 0005h
int 10h

;Posiciona el cursor de texto en el renglón 0 (dh), columna 0 (dl)
mov ah, 02h
mov dh, 0
mov dl, 0
int 10h
