.8086
.stack 100h
.data

.code
;Recibe por stack los límites de la matriz de movimiento en el siguiente orden:
; - Inferior
; - Superior
; - Izquierdo
; - Derecho
;Recibe por stack el offset del vector de coordenadas del cursor (X,Y).

public movimientoJugador

  movimientoJugador proc

  push bp
  mov bp, sp
  push si
  push bx
  push di

  mov bx, ss:[bp+4] ;Offset de los límites de la matriz de movimiento.
  mov si, ss:[bp+6] ;Offset de las posiciones X e Y del cursor

  ;Movimiento o seleccion de casillero.
  tecla:
    mov ah, 0
    int 16h

    cmp al, 73h
    je abajo

    cmp al, 77h
    je arriba

    cmp al, 61h
    je izquierda

    cmp al, 64h
    je derecha

    cmp al, 20h
    je comparoVec

    jmp tecla

  abajo:
    cmp di[1], si[0]
    je tecla
    inc di[1]
    mov ah, 2
    mov dl, di[0]
    mov dh, di[1]
    int 10h
    jmp tecla

  arriba:
    cmp di[1], 10
    je tecla
    dec di[1]
    mov ah, 2
    mov dl, di[0]
    mov dh, di[1]
    int 10h
    jmp tecla

  derecha:
    cmp di[0], 45
    je tecla
    add di[0], 2
    mov ah, 2
    mov dl, di[0]
    mov dh, di[1]
    int 10h
    jmp tecla

  izquierda:
    cmp di[0], 37
    je tecla
    sub di[0], 2
    mov ah, 2
    mov dl, di[0]
    mov dh, di[1]
    int 10h
    jmp tecla

  ;cambiar por respuesta erroneo.
  comparoVec:

    mov ah, 09h
    mov al, 219
    mov bh, 0h
    mov bl, 4h
    mov cx, 1
    int 10h

    pop di
    pop bx
    pop si
    pop bp
    ret 6
movimientoJugador endp
