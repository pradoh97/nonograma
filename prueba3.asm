.8086
.model small
.stack 100h

.data
  titulo            db "N O N O G R A M - U N S A M", 24h
  nivel             db "NIVEL "
  NroNivel          db "1", 24h
  errores           db "CANTIDAD DE ERRORRES: "
  NroError 	        db "0", 24h
  CuadColum         db "0 3 2 3 0", 24h
  CuadColum1        db "  1   1  ", 24h
  CuadFila          db "03230", 24h
  cantidadColumnas  db 5
  cantidadFilas     db 5
  cursorX           db 0
  cursorY           db 0
  grilla            db 176, 20h, 176, 20h, 176, 20h, 176, 20h, 176, 24h
  posX              db 0
  posY              db 0

.code
extrn imprimir:proc
extrn cursor:proc

main proc
  mov ax, @data
  mov ds, ax

;------------------------------------------------------------------------------
;IMPRIMIMOS LA MASCARA DE LA GRILLA VACIA

      mov cl, cantidadFilas
      mov cursorX, 37
      mov cursorY, 10
      imprimirGrilla:
        mov dh, cursorY 		   ;COORDENADA DE FILA
        mov dl, cursorX		      ;COORDENADA DE COLUMNA
        call cursor

        lea dx, grilla
        call imprimir	      ;IMPRIMIMOS LA GRILLA

        inc cursorY
      loop imprimirGrilla

      mov posX, 37 ;SITUAMOS EL CURSOR EN LA MATRIZ
      mov posY, 10

;-----------------------------------------------------------------------------
;ESTABLECEMOS LOS PARAMETROS PARA EL MOVIMIENTO DEL NIVEL FACIL
;O SEA UN CUADRADO DE 5x5

      mov ah, 2
      mov dl, posX
      mov dh, posY
      int 10h

      ;cmp al, 08h
      ;je MenuPrincipal

main endp
end
