.8086
.model small
.stack 100h
.data
  pistaColumna          db " 1        121  11   4217164   2141811213"
                           ;111111111.222222222.333333333.444444444.
  pistaFila             db "   2 1  1 3  415  1 3151717517"
                           ;111111111.222222222.333333333.
  vectorSolucion        db "1110111000000100000001111100001101111001100111111110011111011111111000011111000010101000001111111000",24h
                           ;1---------2---------3---------4---------5---------6---------7---------8---------9---------10--------
  cantidadPistasFila    db 3
  cantidadPistasColumna db 4
  nroNivel              db 3 ;es el caracter 23° de la linea de cantidad de errores.
  origenGrillaX         db 36
  origenGrillaY         db 11
  cantidadFilas         db 10
  cantidadColumnas      db 10

.code
  extrn hud:proc
  extrn vec:proc
  public nivel2
  nivel2 proc
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

    ret
  nivel2 endp
end
