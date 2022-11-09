.8086
.model small
.stack 100h

.data
  cuadradito db 254
  jugadorX db 0
  jugadorY db 0
  cursor db "c"
  filas dw 4
  columnas dw 4
  cursorX db 0
  cursorY db 0
.code
main proc
  mov ax, @data
  mov ds, ax

  dibujarGrilla:
    mov cx, filas
    loopFila:
      push cx
      mov cx, columnas
      mov cursorX, 0

      loopColumna:
        mov ah, jugadorX
        cmp cursorX, ah
        je jugadorEnX
        jmp dibujarCuadrado

        jugadorEnX:
          mov ah, jugadorY
          cmp cursorY, ah
          je dibujarCursor
        jmp dibujarCuadrado
        dibujarCursor:
          mov dl, cursor
          jmp dibujarCaracter
        dibujarCuadrado:
          mov dl, cuadradito
        dibujarCaracter:
          mov ah, 2h
          int 21h
        inc cursorX
      loop loopColumna

      pop cx
      cmp cx, 1
      darSalto:
        mov ah, 2h
        mov dl, 0dh
        int 21h

        mov ah, 2h
        mov dl, 0ah
        int 21h
      finLoop:
      inc cursorY
    loop loopFila

    mov cursorX, 0
    mov cursorY, 0

  mov ah, 08h
  int 21h
  cmp al, 100
  je moverJugadorDerecha
  cmp al, 97
  je moverJugadorIzquierda
  cmp al, 119
  je moverJugadorArriba
  cmp al, 115
  je moverJugadorAbajo
  cmp al, 0dh
  je fin

  moverJugadorDerecha:
    mov ax, columnas
    dec al
    cmp jugadorX, al
    jae dibujarGrilla
    ; No puedo hacer un jump tan largo, moverlo a una función
    ; cmp jugadorX, 0
    ; je dibujarGrilla
    inc jugadorX
    jmp dibujarGrilla
  moverJugadorIzquierda:
    dec jugadorX
    jmp dibujarGrilla
  moverJugadorArriba:
    dec jugadorY
    jmp dibujarGrilla
  moverJugadorAbajo:
    inc jugadorY
    jmp dibujarGrilla

  fin:
    mov ax, 4c00h
    int 21h

main endp
end
