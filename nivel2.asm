.8086
.model small
.stack 100h
.data
  pistaColumna          db " 41114 3233423"
  pistaFila             db "    1   11 3 15127171"
  vectorSolucion        db "0111110010001001001101111111101110111111110100010",24h
  vectorJugada          db "0111110010001001001101111111101110111111110100010",24h
  cantidadPistasFila    db 3
  cantidadPistasColumna db 2
  nroNivel              db 2
  origenGrillaX         db 32
  origenGrillaY         db 10
  cantidadFilas         db 7
  cantidadColumnas      db 7

.code
extrn hud:proc
extrn vec:proc
public nivel2
nivel2 proc
cargarDatosHUD:
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

reiniciarNivel:
  lea dx, vectorSolucion
  push dx
  lea dx, vectorJugada
  push dx
  call vec

;Pasa los metadatos del nivel (las variables de este archivo) al gameloop
cargarDatosGameLoop:
  lea dx, vectorJugada
  mov al, cantidadFilas
  mov ah, cantidadColumnas

  mov bl, origenGrillaX
  mov bh, origenGrillaY
ret
nivel2 endp
end
