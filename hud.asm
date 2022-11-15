.8086
.model small
.stack 100h
.data
  titulo                db "N O N O G R A M - U N S A M", 24h
  nivel                 db "NIVEL ", 24h
  numeroNivel           db 0 ;es el caracter 23° de la linea de cantidad de errores.
  errores               db "CANTIDAD DE ERRORRES: ", 24h
  cantidadFilas         db 0
  cantidadColumnas      db 0
  cantidadPistasFila    db 0
  cantidadPistasColumna db 0
  pistaFila             dw 0
  pistaColumna          dw 0
  cursorX               db 0
  cursorY               db 0
  origenGrillaX         db 0
  origenGrillaY         db 0
  controles             db "Usa W-A-S-D para moverte y ESPACIO para seleccionar.", 0dh, 0ah
                        db " Si deseas volver al menu principal presiona ESC.", 24h
  grilla                db 0

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
; - La cantidad de filas a imprimir: 6
; - La cantidad de columnas a imprimir: 4
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
    mov dl, ss:[bp+20]
    mov numeroNivel, dl

    ;Pistas para columnas y después filas
    mov bx, ss:[bp+18]
    mov pistaColumna, bx
    mov bx, ss:[bp+16]
    mov pistaFila, bx

    ;Cantidad de pistas filas y cantidad pistas columnas
    mov al, ss:[bp+14]
    mov cantidadPistasFila, al
    mov al, ss:[bp+12]
    mov cantidadPistasColumna, al

    ;Coordenadas de origen en X y después Y
    mov dl, ss:[bp+10]
    mov origenGrillaX, dl
    mov dl, ss:[bp+8]
    mov origenGrillaY, dl

    ;Cantidad de filas y columnas
    mov dl, ss:[bp+6]
    mov cantidadFilas, dl
    mov dl, ss:[bp+4]
    mov cantidadColumnas, dl

  imprimirTituloJuego:
    mov dh, 1 		    ;COORDENADA DE FILA
    mov dl, 25        ;COORDENADA DE COLUMNA

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

  ;Posicionar cursor en la primera hilera de pistas a imprimir (la de mas a la izquierda).
  mov al, origenGrillaX
  sub al, cantidadPistasFila
  mov cursorX, al

  mov cl, cantidadPistasFila
  mov bx, 0

  imprimirPistasVertical:
    mov al, origenGrillaY
    mov cursorY, al
    push cx

    ;Inicio el contador de filas
    mov cl, cantidadFilas
    imprimirPistasFilas:
      ;Posiciono el cursor
      mov dh, cursorY
      mov dl, cursorX
      call cursor

      mov si, pistaFila
      mov dl, byte ptr[si+bx]	;IMPRIMIMOS LAS PISTAS QUE REFIEREN A LAS FILAS
      call imprimirCaracter
      inc bx
      inc cursorY
    loop imprimirPistasFilas

    pop cx
    inc cursorX
  loop imprimirPistasVertical

  ;Posicionar cursor en la primera hilera de pistas a imprimir (la de mas a arriba).
  mov al, origenGrillaY
  sub al, cantidadPistasColumna
  mov cursorY, al

  mov cl, cantidadPistasColumna
  mov bx, 0

  imprimirPistasHorizontal:
    mov al, origenGrillaX
    mov cursorX, al
    push cx

    ;Inicio el contador de filas
    mov cl, cantidadFilas
    imprimirPistasColumnas:
      ;Posiciono el cursor
      mov dh, cursorY
      mov dl, cursorX
      call cursor

      mov si, pistaColumna
      mov dl, byte ptr[si+bx]	;IMPRIMIMOS LAS PISTAS QUE REFIEREN A LAS FILAS
      call imprimirCaracter
      inc bx
      add cursorX, 2
    loop imprimirPistasColumnas

    pop cx
    inc cursorY
  loop imprimirPistasHorizontal

  mov al, origenGrillaY
  mov cursorY, al

  mov cl, cantidadFilas
  ;Este loop se mueve por las filas (loop lento)
  imprimirGrilla:
    ;Nos posiciona en la columna 0
    mov al, origenGrillaX
    mov cursorX, al

    push cx

    ;Inicio el contador de filas y lo duplico porque usamos el doble de ancho para que se vea re canchero.
    mov cl, cantidadColumnas
    add cl, cl

    ;Este loop se mueve por las columnas (loop rápido)
    imprimirGrillaCeldas:
      ;Posiciono el cursor
      mov dh, cursorY
      mov dl, cursorX
      call cursor

      mov dl, 176	;IMPRIMIMOS EL CARACTER DE LA MATRIZ (el cuadradito)
      call imprimirCaracter

      inc cursorX
    loop imprimirGrillaCeldas

    pop cx
    inc cursorY
  loop imprimirGrilla

  moverCursorAOrigen:
    mov dh, origenGrillaY
    mov dl, origenGrillaX
    call cursor

  restaurarRegistros:
    pop ax
    pop bx
    pop dx
    pop bp

  ret 18

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
  call imprimirCaracter

    pop dx
    pop bx
    pop bp

  ret 2
actualizarErrores endp
end
