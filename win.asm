.8086
.model small
.stack 100h
.data

  cartelWin1                  db 201, 18 dup (205), 187,0dh,0ah,24h
  cartelWin2                  db 186,'Bien hecho Pedro',33,33,186,0dh,0ah,24h
  cartelWin3                  db 200, 18 dup (205), 188,0dh,0ah,24h
  pulseEnter                  db 'Pulse Enter para volver al menu.',0dh,0ah,24h

.code
extrn cursor:proc
extrn musica:proc
public win:proc
win proc

  push ax
  push bx
  push cx
  push dx

      mov dh, 3		                    ;Y
      mov dl, 30		                  ;X
      call cursor

      mov ah, 9
      mov dx, offset cartelWin1         ;"==========="
      int 21h

      mov dh, 4
      mov dl, 30
      call cursor

      mov ah, 9
      mov dx, offset cartelWin2         ;"Bien hecho Pedro"
      int 21h

      mov dh, 5
      mov dl, 30
      call cursor

      mov ah, 9
      mov dx, offset cartelWin3         ;"==========="
      int 21h


      ;PARTE DE LA MUSIQUITA
      call musica

      mov dh, 20
      mov dl, 15
      call cursor

      mov ah, 9
      mov dx, offset pulseEnter         ;"Presione enter para continuar"
      int 21h

      pedirVolver:
      mov ah, 8h
      int 21h
      cmp al, 0dh
      jne pedirVolver

  pop ax
  pop bx
  pop cx
  pop dx
ret
win endp
end
