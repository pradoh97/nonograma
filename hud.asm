.8086
.model small
.stack 100h
.data
  titulo            db "N O N O G R A M - U N S A M", 24h
  nivel             db "NIVEL ", 24h
  nroNivel          db 0 ;es el caracter 23° de la linea de cantidad de errores.
  errores           db "CANTIDAD DE ERRORRES: ", 24h
  cantidadErrores   db 0
  cantidadFilas     db 0
  cantidadColumnas  db 0
  pistaColumna      db ""
  pistaFila         db ""
  cursorX           db 0
  cursorY           db 0
  controles         db "Usa W-A-S-D para moverte y ESPACIO para seleccionar. Si deseas volver al menu principal presiona ESC.", 24h

.code
extrn imprimir:proc
extrn cursor:proc
public hud
;Recibe por stack:
; - El número de nivel
; - Las pistas para las columnas
; - Las pistas para las filas
; - El origen de pistas en X
; - El origen de pistas en Y
; - La cantidad de filas a imprimir
; - La cantidad de columnas a imprimir

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
    push cx
    push bx
    push ax

  cargarDesdeStack:
    ;EN TODAS ESTAS, TENIA QUE INDICAR SI ES BYTE O NO?
    mov al, ss:[bp+4]
    mov nroNivel, al

    mov al, ss:[bp+6]
    mov pistaColumna, al
    mov al, ss:[bp+8]
    mov pistaFila, al

    mov ax, ss:[bp+10]
    mov cursorX, al
    mov ax, ss:[bp+12]
    mov cursorY, al

    mov al, ss:[bp+14]
    mov cantidadFilas, al
    mov al, ss:[bp+16]
    mov cantidadColumnas, al

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

    add nroNivel, 30h
    mov ah, 02h
    mov dl, nroNivel
    int 21h

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
    mov cursorY, 4

    mov dh, cursorY 		    ;COORDENADA DE FILA
    mov dl, cursorX		      ;COORDENADA DE COLUMNA
    call cursor

    lea dx, errores	    ;IMPRIMIMOS EL NUMERO DE ERRORES QUE TENDRA EL JUGADOR
    call imprimir		    ;LA IDEA ES QUE VAYA INCREMENTANDO Y CUANDO SUPERE, REINICE EL JUEGO

    mov ah, 02h
    add cantidadErrores, 30h
    mov dl, cantidadErrores
    int 21h

  mov cl, cantidadFilas
  mov bx, 0
  mov cursorX, 35
  mov cursorY, 10


  imprimirPistasFilas:
    mov dh, cursorY 		   ;COORDENADA DE FILA
    mov dl, cursorX		     ;COORDENADA DE COLUMNA
    call cursor

    mov dl, pistaFila[bx]	;IMPRIMIMOS LAS PISTAS QUE REFIEREN A LAS FILAS
    mov ah, 2
    int 21h
    inc bx
    inc cursorY
  loop imprimirPistasFilas

  ; imprimirPistasColumnas:
  ;   mov cursorX, 37
  ;   mov cursorY, 9
  ;
  ;   mov dh, cursorY 		    ;COORDENADA DE FILA
  ;   mov dl, cursorX		      ;COORDENADA DE COLUMNA
  ;   call cursor
  ;
  ;   lea dx, pistaColumna	;IMPRIMIMOS LAS PISTAS QUE REFIEREN A LAS COLUMNAS
  ;   call imprimir

  restaurarRegistros:
    pop ax
    pop bx
    pop cx
    pop dx
    pop bp
ret
hud endp
end
