.8086
.model small
.stack 100h
.data
  pistaColumna      db "0 3 2 3 0", 24h
  pistaFila         db "03230", 24h
  cantidadPistasFila db 3
  cantidadPistasColumna db 3
  nroNivel          db 1 ;es el caracter 23° de la linea de cantidad de errores.
  origenGrillaX     db 35
  origenGrillaY     db 10
  cantidadFilas     db 5
  cantidadColumnas  db 5
;   1 2 3 2 1
;   1 2 1 2 1
; 5 ■ ■ ■ ■ ■
; 3 ■ ■ ■ ■ ■
; 1 ■ ■ ■ ■ ■
; 11■ ■ ■ ■ ■
; 5 ■ ■ ■ ■ ■
.code
extrn hud:proc
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

  ret
nivel1 endp
end
