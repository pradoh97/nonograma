.8086
.model small
.stack 100h

.data
  cursorX db 0
  cursorY db 0

  ;t 1 a 5 es el título del juego (nonogram)
  t1      db 219,20h,20h,20h,20h,219,20h,20h,219,219,219,219,20h,20h,219,20h,20h,20h,20h,219,20h,20h,219,219,219,219,20h,20h,219,219,219,219,219,219,20h,20h,219,219,219,219,219,219,20h,20h,219,219,219,219,219,20h,20h,219,20h,20h,20h,20h,219, 24h
  t2      db 219,219,20h,20h,20h,219,20h,20h,219,20h,20h,219,20h,20h,219,219,20h,20h,20h,219,20h,20h,219,20h,20h,219,20h,20h,219,20h,20h,20h,20h,20h,20h,20h,219,20h,20h,20h,20h,219,20h,20h,219,20h,20h,20h,219,20h,20h,219,219,20h,20h,219,219, 24h
  t3      db 219,20h,219,20h,20h,219,20h,20h,219,20h,20h,219,20h,20h,219,20h,219,20h,20h,219,20h,20h,219,20h,20h,219,20h,20h,219,20h,20h,219,219,219,20h,20h,219,219,219,219,219,20h,20h,20h,219,219,219,219,219,20h,20h,219,20h,219,219,20h,219, 24h
  t4      db 219,20h,20h,219,20h,219,20h,20h,219,20h,20h,219,20h,20h,219,20h,20h,219,20h,219,20h,20h,219,20h,20h,219,20h,20h,219,20h,20h,20h,20h,219,20h,20h,219,20h,20h,20h,219,20h,20h,20h,219,20h,20h,20h,219,20h,20h,219,20h,20h,20h,20h,219, 24h
  t5      db 219,20h,20h,20h,219,219,20h,20h,219,219,219,219,20h,20h,219,20h,20h,20h,219,219,20h,20h,219,219,219,219,20h,20h,219,219,219,219,219,219,20h,20h,219,20h,20h,20h,20h,219,20h,20h,219,20h,20h,20h,219,20h,20h,219,20h,20h,20h,20h,219, 24h

  t66     db "SISTEMAS DE PROCESAMIENTO DE DATOS 2022", 24h

  t76     db "Si desea juegar en modo FACIL, presione 1.", 0dh,0ah
          db " Si desea juegar en modo INTERMEDIO, presione 2.", 0dh,0ah
          db " Si desea juegar en modo DIFICIL, presione 3.", 0dh,0ah
          db " Si desea saber COMO JUGAR, presione 4.", 0dh, 0ah
          db " Si desea saber sobre la HISTORIA del juego, presione 5.", 0dh, 0ah
          db " Si desea SALIR del juego, presione ESC.", 24h

  nombres db "  Hernan Prado - Gabriel Tarquini - Guillermo Carbone - Agustina Venanzoni", 24h

  ;Logo UNSAM
  u1      db 201,205,205,205,242,242,242,242,242,205,205,205,187,24h
  u2      db 186,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,186,20h, "Universidad Nacional", 24h
  u3      db 186,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,186,20h,20h,20h,20h,20h,"de San Martin", 24h
  u4      db 200,205,205,205,242,242,242,242,242,205,205,205,188,24h

.code
extrn imprimir:proc
extrn cursor:proc
public mostrarMenu

mostrarMenu proc
  mov ax, @data
  mov ds, ax

    imprimirTituloJuego:
      mov cursorX, 10
      mov cursorY, 1

  		mov dh, cursorY
  		mov dl, cursorX
  		call cursor

      lea dx, t1
      call imprimir

      inc cursorY

      mov dh, cursorY
  		mov dl, cursorX
  		call cursor

      lea dx, t2
      call imprimir

      inc cursorY

      mov dh, cursorY
  		mov dl, cursorX
  		call cursor

      lea dx, t3
      call imprimir
      inc cursorY

      mov dh, cursorY
  		mov dl, cursorX
  		call cursor

      lea dx, t4
      call imprimir

      inc cursorY

      mov dh, cursorY
  		mov dl, cursorX
  		call cursor

      lea dx, t5
      call imprimir

    imprimirNombreMateria:
      mov cursorY, 7
      mov cursorX, 20

      mov dh, cursorY
  		mov dl, cursorX
  		call cursor

      lea dx, t66
      call imprimir

    imprimirOpciones:
      mov cursorY, 10
      mov cursorX, 1

      mov dh, cursorY
  		mov dl, cursorX
  		call cursor

      lea dx, t76
      call imprimir

      mov cursorY, 17
      mov cursorX, 21

      mov dh, cursorY
  		mov dl, cursorX
  		call cursor

    imprimirLogoUniversidad:
      lea dx, u1
      call imprimir

      inc cursorY

      mov dh, cursorY
  		mov dl, cursorX
  		call cursor

      lea dx, u2
      call imprimir

      inc cursorY

      mov dh, cursorY
  		mov dl, cursorX
      call cursor

      lea dx, u3
      call imprimir

      inc cursorY

      mov dh, cursorY
  		mov dl, cursorX
  	  call cursor

      lea dx, u4
      call imprimir

    imprimirNombresIntegrantes:
      mov cursorY, 24
      mov cursorX, 1

      mov dh, cursorY
  		mov dl, cursorX
  		call cursor

      lea dx, nombres
      call imprimir
  ret

mostrarMenu endp
end
