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
  ;Vuelve a poner en cero la cantidad de errores.
  call limpiarPantalla
  call mostrarMenu

opciones:
  mov ah, 0                   ;LA INT 16 PIDE UNA TECLA PERO NO LA MUESTRA EN Pantalla
  int 16h                     ;UNA VEZ QUE TENEMOS LA TECLA EN AL LA USAMOS PARA COMPARAR

  cmp al, "1"                 ;SI ES 1 VA AL NIVEL 1
  je cargarMetadatosNivel1

  cmp al, "2"                 ;SI ES 2 VA AL NIVEL 2
  je cargarMetadatosNivel2

  cmp al, "3"                 ;SI ES 3 VA AL NIVEL 3
  je cargarMetadatosNivel3

  cmp al, "4"                 ;SI ES CUATRO VA A LA HISTORIA DEL JUEGO
  je instruccion

  cmp al, "5"                 ;SI ES CUATRO VA A LA HISTORIA DEL JUEGO
  je mostrarHistoria

  cmp al, 27
  je fin

  jmp opciones  ;SI ES CUALQUIER OTRA TECLA VUELVE A PEDIR UNA VALIDA

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

cargarHUD:
  ;Rescato los registros que pisó el nivel con sus metadatos
  mov cantidadFilas, al
  mov cantidadColumnas, ah
  mov origenGrillaX, bl
  mov origenGrillaY, bh

  mov ah, 0
  push ax; en al esta la cantidad de filas.
  push dx; esta el vector jugada

  mov al, cantidadFilas
  dec al
  add al, origenGrillaY
  ;Límite inferior
  push ax

  mov al, cantidadColumnas
  add al, al
  sub al, 2
  add al, origenGrillaX
  ;Límite derecho
  push ax

  ;Límite izquierdo
  mov bh, 0
  push bx
  ;Límite superior
  mov bl, origenGrillaY
  push bx

gameLoop:
  call movimientoJugador
jmp inicio

comoJugar:
  call instruccion
  jmp inicio

mostrarHistoria:
  call limpiarPantalla
  call historia
  jmp inicio
fin:
  call limpiarPantalla

  mov ax, 4c00h
  int 21h

main endp
end
