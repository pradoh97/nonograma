.8086
.model small
.stack 100h
.data
  pistaColumna          db " 1        121  11   4217164   2141811213"
  pistaFila             db "   2 1  1 3  415  1 3151717517"
  vectorSolucion        db "1110111000000100000001111100001101111001100111111110011111011111111000011111000010101000001111111000",24h
  vectorJugada          db "1110111000000100000001111100001101111001100111111110011111011111111000011111000010101000001111111000",24h
  cantidadPistasFila    db 3
  cantidadPistasColumna db 4
  nroNivel              db 3
  origenGrillaX         db 30
  origenGrillaY         db 8
  cantidadFilas         db 10
  cantidadColumnas      db 10

.code
  extrn hud:proc
  extrn vec:proc
  public nivel3
  nivel3 proc
    ;Número nivel
    mov al, nroNivel
    push ax

    ;Pistas
    lea dx, pistaColumna
    push dx
    lea dx, pistaFila
    push dx

    ;cantidad de pistas fila y columna
    mov al, cantidadPistasFila
    push ax
    mov al, cantidadPistasColumna
    push ax

    ;Coordenadas de origen en X y después Y
    mov al, origenGrillaX
    push ax
    mov al, origenGrillaY
    push ax

    ;Cantidad de filas y columnas
    mov al, cantidadFilas
    push ax
    mov al, cantidadColumnas
    push ax

    call hud

    lea dx, vectorSolucion
    push dx
    lea dx, vectorJugada
    push dx
    call vec

    lea dx, vectorJugada
    mov al, cantidadFilas
    mov ah, cantidadColumnas

    mov bl, origenGrillaX
    mov bh, origenGrillaY

    ret
  nivel3 endp
end
