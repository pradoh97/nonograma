.8086
.model small
.stack 100h

.data
  cursorX           db 0
  cursorY           db 0

  t1  db 219,20h,20h,20h,20h,219,20h,20h,219,219,219,219,20h,20h,219,20h,20h,20h,20h,219,20h,20h,219,219,219,219,20h,20h,219,219,219,219,219,219,20h,20h,219,219,219,219,219,219,20h,20h,219,219,219,219,219,20h,20h,219,20h,20h,20h,20h,219, 24h
  t2  db 219,219,20h,20h,20h,219,20h,20h,219,20h,20h,219,20h,20h,219,219,20h,20h,20h,219,20h,20h,219,20h,20h,219,20h,20h,219,20h,20h,20h,20h,20h,20h,20h,219,20h,20h,20h,20h,219,20h,20h,219,20h,20h,20h,219,20h,20h,219,219,20h,20h,219,219, 24h
  t3  db 219,20h,219,20h,20h,219,20h,20h,219,20h,20h,219,20h,20h,219,20h,219,20h,20h,219,20h,20h,219,20h,20h,219,20h,20h,219,20h,20h,219,219,219,20h,20h,219,219,219,219,219,20h,20h,20h,219,219,219,219,219,20h,20h,219,20h,219,219,20h,219, 24h
  t4  db 219,20h,20h,219,20h,219,20h,20h,219,20h,20h,219,20h,20h,219,20h,20h,219,20h,219,20h,20h,219,20h,20h,219,20h,20h,219,20h,20h,20h,20h,219,20h,20h,219,20h,20h,20h,219,20h,20h,20h,219,20h,20h,20h,219,20h,20h,219,20h,20h,20h,20h,219, 24h
  t5  db 219,20h,20h,20h,219,219,20h,20h,219,219,219,219,20h,20h,219,20h,20h,20h,219,219,20h,20h,219,219,219,219,20h,20h,219,219,219,219,219,219,20h,20h,219,20h,20h,20h,20h,219,20h,20h,219,20h,20h,20h,219,20h,20h,219,20h,20h,20h,20h,219, 24h
  t66  db "SISTEMA DE PROCESAMIENTO DE DATOS 2022", 24h

  t76  db "Si desea juegar en modo FACIL presione 1", 0dh,0ah
  t8  db " Si desea juegar en modo INTERMEDIO presione 2", 0dh,0ah
  t9  db " Si desea juegar en modo DIFICIL presione 3", 0dh,0ah
  t10 db " Si desea saber sobre la historia del juego presione 4", 24h

  nombres db "Hernan Prado - Tamara Mecozi - Gabriel Tarquini", 24h
  u1      db 201,205,205,205,242,242,242,242,242,205,205,205,187,24h
  u2      db 186,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,186,20h, "Universidad Nacional", 24h
  u3      db 186,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,186,20h,20h,20h,20h,20h,"de San Martin", 24h
  u4      db 200,205,205,205,242,242,242,242,242,205,205,205,188,24h

.code

main proc
  mov ax, @data
  mov ds, ax

  ;-----------------------------------------------------------------------
  		;ESTABLECEMOS LOS PARAMETROS DE VIDEO, PANTALLA DE 80x25 - CON LA INT 10
  		;Y EL MODO 3

  		mov ah, 0
  		mov al, 3
  		int 10h

  		;------------------------------------------------------------------------
  		;ESTABLECEMOS EL CONTENIDO EXTERIOR AL JUEGO: 	-NUMERO DE NIVEL
  		;												-CANTIDAD DE ERRORES
  		;												-CUADRADOS A PINTAR (CuadColum y CuadFila)

      mov cursorX, 10
      mov cursorY, 1

      mov ah, 2		;POSICIONAMOS EL CURSOR
  		mov bh, 0 		;PAGINA SIEMPRE LA MISMA
  		mov dh, cursorY 		;COORDENADA DE FILA
  		mov dl, cursorX		;COORDENADA DE COLUMNA
  		int 10h

      lea dx, t1
      mov ah, 9
      int 21h
      inc cursorY

      mov ah, 2		;POSICIONAMOS EL CURSOR
  		mov bh, 0 		;PAGINA SIEMPRE LA MISMA
  		mov dh, cursorY 		;COORDENADA DE FILA
  		mov dl, cursorX		;COORDENADA DE COLUMNA
  		int 10h

      lea dx, t2
      mov ah, 9
      int 21h
      inc cursorY

      mov ah, 2		;POSICIONAMOS EL CURSOR
  		mov bh, 0 		;PAGINA SIEMPRE LA MISMA
  		mov dh, cursorY 		;COORDENADA DE FILA
  		mov dl, cursorX		;COORDENADA DE COLUMNA
  		int 10h

      lea dx, t3
      mov ah, 9
      int 21h
      inc cursorY

      mov ah, 2		;POSICIONAMOS EL CURSOR
  		mov bh, 0 		;PAGINA SIEMPRE LA MISMA
  		mov dh, cursorY 		;COORDENADA DE FILA
  		mov dl, cursorX		;COORDENADA DE COLUMNA
  		int 10h

      lea dx, t4
      mov ah, 9
      int 21h
      inc cursorY

      mov ah, 2		;POSICIONAMOS EL CURSOR
  		mov bh, 0 		;PAGINA SIEMPRE LA MISMA
  		mov dh, cursorY 		;COORDENADA DE FILA
  		mov dl, cursorX		;COORDENADA DE COLUMNA
  		int 10h

      lea dx, t5
      mov ah, 9
      int 21h

      mov cursorY, 7
      mov cursorX, 20

      mov ah, 2		;POSICIONAMOS EL CURSOR
  		mov bh, 0 		;PAGINA SIEMPRE LA MISMA
  		mov dh, cursorY 		;COORDENADA DE FILA
  		mov dl, cursorX		;COORDENADA DE COLUMNA
  		int 10h

      lea dx, t66
      mov ah, 9
      int 21h

      mov cursorY, 12
      mov cursorX, 1

      mov ah, 2		;POSICIONAMOS EL CURSOR
  		mov bh, 0 		;PAGINA SIEMPRE LA MISMA
  		mov dh, cursorY 		;COORDENADA DE FILA
  		mov dl, cursorX		;COORDENADA DE COLUMNA
  		int 10h

      lea dx, t76
      mov ah, 9
      int 21h

      mov cursorY, 24
      mov cursorX, 15

      mov ah, 2		;POSICIONAMOS EL CURSOR
  		mov bh, 0 		;PAGINA SIEMPRE LA MISMA
  		mov dh, cursorY 		;COORDENADA DE FILA
  		mov dl, cursorX		;COORDENADA DE COLUMNA
  		int 10h

      lea dx, nombres
      mov ah, 9
      int 21h

      mov cursorY, 19
      mov cursorX, 21

      mov ah, 2		;POSICIONAMOS EL CURSOR
  		mov bh, 0 		;PAGINA SIEMPRE LA MISMA
  		mov dh, cursorY 		;COORDENADA DE FILA
  		mov dl, cursorX		;COORDENADA DE COLUMNA
  		int 10h

      lea dx, u1
      mov ah, 9
      int 21h

      inc cursorY

      mov ah, 2		;POSICIONAMOS EL CURSOR
  		mov bh, 0 		;PAGINA SIEMPRE LA MISMA
  		mov dh, cursorY 		;COORDENADA DE FILA
  		mov dl, cursorX		;COORDENADA DE COLUMNA
  		int 10h

      lea dx, u2
      mov ah, 9
      int 21h

      inc cursorY

      mov ah, 2		;POSICIONAMOS EL CURSOR
  		mov bh, 0 		;PAGINA SIEMPRE LA MISMA
  		mov dh, cursorY 		;COORDENADA DE FILA
  		mov dl, cursorX		;COORDENADA DE COLUMNA
  		int 10h

      lea dx, u3
      mov ah, 9
      int 21h

      inc cursorY

      mov ah, 2		;POSICIONAMOS EL CURSOR
  		mov bh, 0 		;PAGINA SIEMPRE LA MISMA
  		mov dh, cursorY 		;COORDENADA DE FILA
  		mov dl, cursorX		;COORDENADA DE COLUMNA
  		int 10h

      lea dx, u4
      mov ah, 9
      int 21h

    mov ah, 1
    int 21h
  main endp
  end
