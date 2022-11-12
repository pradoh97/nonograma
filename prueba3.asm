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
  vec               db "1111101110001000101011111"


.code
extrn imprimir: proc
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
  		;ESTABLECEMOS EL CONTENIDO EXTERIOR AL JUEGO: 	-NUMERO DE NIVEL
  		;												-CANTIDAD DE ERRORES
  		;												-CUADRADOS A PINTAR (CuadColum y CuadFila)

      mov cursorX, 25
      mov cursorY, 1

      mov ah, 2		      ;POSICIONAMOS EL CURSOR
  		mov bh, 0 		    ;PAGINA SIEMPRE LA MISMA
  		mov dh, cursorY   ;COORDENADA DE FILA
  		mov dl, cursorX	  ;COORDENADA DE COLUMNA
  		int 10h

  		lea dx, titulo	;IMPPRIMIMOS EL CARTEL DEL NIVEL EN EL QUE ESTA EL JUGADOR
  		call imprimir

      mov cursorX, 1
      mov cursorY, 3

      mov ah, 2		       ;POSICIONAMOS EL CURSOR
  		mov bh, 0 		     ;PAGINA SIEMPRE LA MISMA
  		mov dh, cursorY 	 ;COORDENADA DE FILA
  		mov dl, cursorX		 ;COORDENADA DE COLUMNA
  		int 10h

  		lea dx, nivel	;IMPPRIMIMOS EL CARTEL DEL NIVEL EN EL QUE ESTA EL JUGADOR
  		call imprimir

      mov cursorX, 1
      mov cursorY, 24

  		mov ah, 2h		;POSICIONAMOS EL CURSOR
  		mov bh, 0 		;PAGINA SIEMPRE LA MISMA
  		mov dh, cursorY 		;COORDENADA DE FILA
  		mov dl, cursorX		;COORDENADA DE COLUMNA
  		int 10h

  		lea dx, errores	;IMPRIMIMOS EL NUMERO DE ERRORES QUE TENDRA EL JUGADOR
  		call imprimir		    ;LA IDEA ES QUE VAYA INCREMENTANDO Y CUANDO SUPERE 3
  		call imprimir			    ;REINICE EL JUEGO

      mov cl, cantidadFilas
      mov bx, 0
      mov cursorX, 35
      mov cursorY, 10

      imprimirFilas:
        mov ah, 2h		;POSICIONAMOS EL CURSOR
        mov bh, 0 		;PAGINA SIEMPRE LA MISMA
        mov dh, cursorY 		;COORDENADA DE FILA
        mov dl, cursorX		;COORDENADA DE COLUMNA
        int 10h

        mov dl, CuadFila[bx]	;IMPRIMIMOS LAS PISTAS QUE REFIEREN A LAS FILAS
        mov ah, 2
        int 21h
        inc bx
        inc cursorY
      loop imprimirFilas

      mov cursorX, 37
      mov cursorY, 9

      mov ah, 2h		;POSICIONAMOS EL CURSOR
  		mov bh, 0 		;PAGINA SIEMPRE LA MISMA
  		mov dh, cursorY 		;COORDENADA DE FILA
  		mov dl, cursorX		;COORDENADA DE COLUMNA
  		int 10h

  		lea dx, CuadColum	;IMPRIMIMOS LAS PISTAS QUE REFIEREN A LAS COLUMNAS
  		call imprimir

      mov cursorX, 37
      mov cursorY, 8

      mov ah, 2h		      ;POSICIONAMOS EL CURSOR
  		mov bh, 0 		      ;PAGINA SIEMPRE LA MISMA
  		mov dh, cursorY 		;COORDENADA DE FILA
  		mov dl, cursorX		  ;COORDENADA DE COLUMNA
  		int 10h

  		lea dx, CuadColum1	;IMPRIMIMOS LAS PISTAS QUE REFIEREN A LAS COLUMNAS
  		call imprimir
  		int 21h

;------------------------------------------------------------------------------
;IMPRIMIMOS LA MASCARA DE LA GRILLA VACIA

      mov cl, cantidadFilas
      mov cursorX, 37
      mov cursorY, 10
      imprimirGrilla:
        mov ah, 2h		;POSICIONAMOS EL CURSOR
        mov bh, 0 		;PAGINA SIEMPRE LA MISMA
        mov dh, cursorY 		;COORDENADA DE FILA
        mov dl, cursorX		;COORDENADA DE COLUMNA
        int 10h

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

    tecla:

      mov ah, 0
      int 16h

      cmp al, 20h
      je comparoVec

      cmp al, 73h
      je abajo

      cmp al, 77h
      je arriba

      cmp al, 61h
      je izquierda

      cmp al, 64h
      je derecha

      jmp tecla

    comparoVec:
      mov ah, 09h
      mov al, 219
      mov bh, 0h
      mov bl, 4h
      mov cx, 1
      int 10h

    abajo:
      cmp posY, 14
      je tecla
      inc posY
      mov ah, 2
      mov dl, posX
      mov dh, posY
      int 10h
      jmp tecla

    arriba:
      cmp posY, 10
      je tecla
      dec posY
      mov ah, 2
      mov dl, posX
      mov dh, posY
      int 10h
      jmp tecla

    derecha:
      cmp posX, 45
      je tecla
      add posX, 2
      mov ah, 2
      mov dl, posX
      mov dh, posY
      int 10h
      jmp tecla

    izquierda:
      cmp posX, 37
      je tecla
      sub posX, 2
      mov ah, 2
      mov dl, posX
      mov dh, posY
      int 10h
      jmp tecla

main endp
end
