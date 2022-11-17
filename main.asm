.8086
.model small
.stack 100h
.data
  cantidadAciertos  db 0
  cantidadFilas     db 0
  cantidadColumnas  db 0
  origenGrillaX     db 0
  origenGrillaY     db 0
.code
extrn mostrarMenu:proc
extrn actualizarErrores:proc
extrn nivel1:proc
extrn nivel2:proc
extrn nivel3:proc
extrn movimientoJugador:proc
extrn historia:proc
extrn hud:proc
extrn limpiarPantalla:proc
extrn instruccion:proc

main proc
  mov ax, @data
  mov ds, ax

  ;----------------------------------------------------------------------------
  ;ESTABLECEMOS LOS PARAMETROS DE VIDEO, PANTALLA DE 80x25 - CON LA INT 10
  ;Y EL MODO 3

inicio:
  call limpiarPantalla
  call mostrarMenu

opciones:
  mov ah, 0                   ;LA INT 16 PIDE UNA TECLA PERO NO LA MUESTRA EN PANTALLA
  int 16h                     ;UNA VEZ QUE TENEMOS LA TECLA EN AL LA USAMOS PARA COMPARAR

  cmp al, "1"                 ;SI ES 1 VA AL NIVEL 1
  je cargarMetadatosNivel1

  cmp al, "2"                 ;SI ES 2 VA AL NIVEL 2
  je cargarMetadatosNivel2

  cmp al, "3"                 ;SI ES 3 VA AL NIVEL 3
  je cargarMetadatosNivel3

  cmp al, "4"                 ;SI ES CUATRO VA A COMO JUGAR
  je intermedio2

  cmp al, "5"                 ;SI ES CINCO VA A LA HISTORIA DEL JUEGO
  je intermedio3

  cmp al, 27                  ;SI ES ESC SALE DEL JUEGO
  je fin

  jmp opciones                ;SI ES CUALQUIER OTRA TECLA VUELVE A PEDIR UNA VALIDA

;Se cargan las propiedades de cada nivel (alto y ancho de grilla, solucion, etc.)
cargarMetadatosNivel1:
  call limpiarPantalla
  call nivel1
  jmp cargarHUD
cargarMetadatosNivel2:
  call limpiarPantalla
  call nivel2
  jmp cargarHUD
cargarMetadatosNivel3:
  call limpiarPantalla
  call nivel3
  jmp cargarHUD

;Saltos intermedios, 1 va al inicio, 2 imprime la ayuda del juego y 3 imprime la historia del juego
intermedio1:
  jmp inicio
intermedio2:
  jmp comoJugar
intermedio3:
  jmp mostrarHistoria

;Se le pasa por stack los parámetros del nivel al gameloop para hacerles seguimiento (y validar fin del juego)
cargarHUD:
  ;Guardo en variables los metadatos que llegan, por registros, desde el nivel seleccionado.
  mov cantidadFilas, al
  mov cantidadColumnas, ah
  mov origenGrillaX, bl
  mov origenGrillaY, bh

  ;Muevo al stack los datos del nivel para pasarlo al gameloop
  mov ah, 0
  push ax            ; cantidad de filas.
  push dx            ; vector jugada.

  ;Calcula y pasa a stack el límite inferior
  mov al, cantidadFilas
  dec al
  add al, origenGrillaY
  push ax

  ;Calcula y pasa a stack el límite derecho
  mov al, cantidadColumnas
  add al, al
  sub al, 2
  add al, origenGrillaX
  push ax

  ;Pasa a stack el límite izquierdo
  mov bh, 0
  push bx
  ;Pasa a stack el Límite superior
  mov bl, origenGrillaY
  push bx

gameLoop:
  call movimientoJugador
  jmp inicio

comoJugar:
  call limpiarPantalla
  call instruccion
  jmp intermedio1

mostrarHistoria:
  call limpiarPantalla
  call historia
  jmp intermedio1
fin:
  call limpiarPantalla

  mov ax, 4c00h
  int 21h

main endp
end
