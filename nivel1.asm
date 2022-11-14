.8086
.model small
.stack 100h
.data
  pistaColumna          db "   1  131 31113"
  pistaFila             db " 1    111 31313"
  vectorSolucion        db "0111010101101111000101110", 24h
  vectorJugada          db "0111010101101111000101110", 24h
  cantidadPistasFila    db 3
  cantidadPistasColumna db 3
  nroNivel              db 1                                    ;es el caracter 23° de la linea de cantidad de errores.
  origenGrillaX         db 36
  origenGrillaY         db 11
  cantidadFilas         db 5
  cantidadColumnas      db 5

.code
extrn hud:proc
extrn vec:proc
public nivel1
nivel1 proc
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

  lea dx, vectorSolucion
  push dx
  lea dx, vectorJugada
  push dx
  call vec

  call hud

  lea dx, vectorJugada
  mov al, cantidadFilas

  ret
nivel1 endp
end
