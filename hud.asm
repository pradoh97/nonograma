.8086
.model small
.stack 100h
.data
  titulo            db "N O N O G R A M - U N S A M", 24h
  nivel             db "NIVEL ", 24h
  numeroNivel       db 0 ;es el caracter 23° de la linea de cantidad de errores.
  errores           db "CANTIDAD DE ERRORRES: ", 24h
  cantidadFilas     db 0
  cantidadColumnas  db 0
  pistaFila         dw 0
  pistaColumna      dw 0
  cursorX           db 0
  cursorY           db 0
  controles         db "Usa W-A-S-D para moverte y ESPACIO para seleccionar.", 0dh, 0ah
                    db " Si deseas volver al menu principal presiona ESC.", 24h

.code
extrn imprimir:proc
extrn imprimirCaracter:proc
extrn cursor:proc
public hud
public actualizarErrores

;Recibe por stack lo siguiente (lo que está después de los : es el offset para BP):
; - El número de nivel: 16
; - Las pistas para las columnas: 14
; - Las pistas para las filas: 12
; - El origen de pistas en X: 10
; - El origen de pistas en Y: 8
; - La cantidad de filas a imprimir: 10
; - La cantidad de columnas a imprimir: 8
hud proc
  ;------------------------------------------------------------------------
  ;ESTABLECEMOS EL CONTENIDO EXTERIOR AL JUEGO:
  ;               -NUMERO DE NIVEL
  ;								-CANTIDAD DE ERRORES
  ;								-CUADRADOS A PINTAR (pistaColumna y pistaFila)
  salvarRegistros:
    push bp
    mov bp, sp

    push dx
    push bx
    push ax

  cargarDesdeStack:
    ;Número de nivel
    mov dl, ss:[bp+16]
    mov numeroNivel, dl

    ;Pistas para columnas y después filas
    mov bx, ss:[bp+14]
    mov pistaColumna, bx
    mov bx, ss:[bp+12]
    mov pistaFila, bx

    ;Coordenadas de origen en X y después Y
    mov dl, ss:[bp+10]
    mov cursorX, dl
    mov dl, ss:[bp+8]
    mov cursorY, dl

    ;Cantidad de filas y columnas
    mov dl, ss:[bp+6]
    mov cantidadFilas, dl
    mov dl, ss:[bp+4]
    mov cantidadColumnas, dl

  imprimirTituloJuego:
    mov dh, cursorY 		    ;COORDENADA DE FILA
    mov dl, cursorX		      ;COORDENADA DE COLUMNA

    call cursor

    lea dx, titulo	;IMPPRIMIMOS EL CARTEL DEL TITULO DEL JUEGO
    call imprimir

  imprimirNivel:
    mov cursorX, 1
    mov cursorY, 3

    mov dh, cursorY 		    ;COORDENADA DE FILA
    mov dl, cursorX		      ;COORDENADA DE COLUMNA
    call cursor

    lea dx, nivel	;IMPPRIMIMOS EL CARTEL DEL NIVEL EN EL QUE ESTA EL JUGADOR
    call imprimir

    add numeroNivel, 30h
    mov dl, numeroNivel
    call imprimirCaracter
  imprimirControles:
    mov cursorX, 1
    mov cursorY, 24

    mov dh, cursorY
    mov dl, cursorX
    call cursor

    lea dx, controles
    call imprimir

  imprimirErrores:
    mov cursorX, 1
    mov cursorY, 3

    mov dh, cursorY 		    ;COORDENADA DE FILA
    mov dl, cursorX		      ;COORDENADA DE COLUMNA
    call cursor

    lea dx, errores	    ;IMPRIMIMOS EL NUMERO DE ERRORES QUE TENDRA EL JUGADOR
    call imprimir		    ;LA IDEA ES QUE VAYA INCREMENTANDO Y CUANDO SUPERE, REINICE EL JUEGO

    mov ah, 02h
    mov dl, 30h
    int 21h

  ;Paso previo a imprimir filas.
  mov cl, cantidadFilas
  mov bx, 0
  mov cursorX, 35
  mov cursorY, 10

  imprimirPistasFilas:
    mov dh, cursorY 		   ;COORDENADA DE FILA
    mov dl, cursorX		     ;COORDENADA DE COLUMNA
    call cursor
    mov si, pistaFila
    mov dl, byte ptr[si+bx]	;IMPRIMIMOS LAS PISTAS QUE REFIEREN A LAS FILAS
    call imprimirCaracter
    inc bx
    inc cursorY
  loop imprimirPistasFilas

  imprimirPistasColumnas:
    mov cursorX, 37
    mov cursorY, 9

    mov dh, cursorY 		    ;COORDENADA DE FILA
    mov dl, cursorX		      ;COORDENADA DE COLUMNA
    call cursor

    mov dx, pistaColumna	;IMPRIMIMOS LAS PISTAS QUE REFIEREN A LAS COLUMNAS
    call imprimir

  restaurarRegistros:
    pop ax
    pop bx
    pop dx
    pop bp

  ret 8
hud endp

;Recibe la cantidad de errores por stack.
actualizarErrores proc
  push bp
  mov bp, sp
  push bx
  push dx

  mov dh, 3
  mov dl, 23
  call cursor

  mov dl, ss:[bp+4]
  add dl, 30h
  call imprimirCaracter
  ret 6
actualizarErrores endp
end
