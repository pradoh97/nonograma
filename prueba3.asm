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
  CuadFila          db "03230"
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

  ;----------------------------------------------------------------------------
  		;ESTABLECEMOS LOS PARAMETROS DE VIDEO, PANTALLA DE 80x25 - CON LA INT 10
  		;Y EL MODO 3

  		mov ah, 0
  		mov al, 3
  		int 10h

  		;------------------------------------------------------------------------
      ;ESTABLECEMOS EL CONTENIDO EXTERIOR AL JUEGO:
      ;               -NUMERO DE NIVEL
  		;								-CANTIDAD DE ERRORES
  		;								-CUADRADOS A PINTAR (CuadColum y CuadFila)

      mov cursorX, 25
      mov cursorY, 1

      mov dh, cursorY 		    ;COORDENADA DE FILA
  		mov dl, cursorX		      ;COORDENADA DE COLUMNA
  		call cursor

  		lea dx, titulo	;IMPPRIMIMOS EL CARTEL DEL NIVEL EN EL QUE ESTA EL JUGADOR
  		call imprimir

      mov cursorX, 1
      mov cursorY, 3

      mov dh, cursorY 		    ;COORDENADA DE FILA
  		mov dl, cursorX		      ;COORDENADA DE COLUMNA
  	  call cursor

  		lea dx, nivel	;IMPPRIMIMOS EL CARTEL DEL NIVEL EN EL QUE ESTA EL JUGADOR
  		call imprimir

      mov cursorX, 1
      mov cursorY, 24

      mov dh, cursorY 		    ;COORDENADA DE FILA
  		mov dl, cursorX		      ;COORDENADA DE COLUMNA
  		call cursor

  		lea dx, errores	    ;IMPRIMIMOS EL NUMERO DE ERRORES QUE TENDRA EL JUGADOR
  		call imprimir		    ;LA IDEA ES QUE VAYA INCREMENTANDO Y CUANDO SUPERE 3
  					              ;REINICE EL JUEGO

      mov cl, cantidadFilas
      mov bx, 0
      mov cursorX, 35
      mov cursorY, 10

      imprimirFilas:
        mov dh, cursorY 		   ;COORDENADA DE FILA
        mov dl, cursorX		     ;COORDENADA DE COLUMNA
        call cursor

        mov dl, CuadFila[bx]	;IMPRIMIMOS LAS PISTAS QUE REFIEREN A LAS FILAS
        mov ah, 2
        int 21h
        inc bx
        inc cursorY
      loop imprimirFilas

      mov cursorX, 37
      mov cursorY, 9

      mov dh, cursorY 		    ;COORDENADA DE FILA
  		mov dl, cursorX		      ;COORDENADA DE COLUMNA
  		call cursor

  		lea dx, CuadColum	;IMPRIMIMOS LAS PISTAS QUE REFIEREN A LAS COLUMNAS
  		call imprimir

      mov cursorX, 37
      mov cursorY, 8

      mov dh, cursorY 		    ;COORDENADA DE FILA
  		mov dl, cursorX		      ;COORDENADA DE COLUMNA
  		call cursor

  		lea dx, CuadColum1	;IMPRIMIMOS LAS PISTAS QUE REFIEREN A LAS COLUMNAS
  		call imprimir
  		int 21h

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
