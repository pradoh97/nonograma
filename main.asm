.8086
.model small
.stack 100h
.data
  cantidadErrores   db 0
  cantidadAciertos  db 0
  limiteX           db 0
  limiteY           db 0
  origenGrillaX     db 0
  origenGrillaY     db 0
  posicionJugadorX  db 0
  posicionJugadorY  db 0
.code
extrn mostrarMenu:proc
extrn actualizarErrores:proc
extrn nivel1:proc
; extrn nivel2:proc
; extrn nivel3:proc
extrn movimientoJugador:proc
extrn historia:proc
extrn hud:proc
extrn limpiarPantalla:proc

main proc
  mov ax, @data
  mov ds, ax

  ;----------------------------------------------------------------------------
  ;ESTABLECEMOS LOS PARAMETROS DE VIDEO, PANTALLA DE 80x25 - CON LA INT 10
  ;Y EL MODO 3

inicio:
  ;Vuelve a poner en cero la cantidad de errores.
  mov cantidadErrores, 0

  call limpiarPantalla
  call mostrarMenu

opciones:
  mov ah, 0     ;LA INT 16 PIDE UNA TECLA PERO NO LA MUESTRA EN Pantalla
  int 16h       ;UNA VEZ QUE TENEMOS LA TECLA EN AL LA USAMOS PARA COMPARAR

  cmp al, "1"   ;SI ES 1 VA AL NIVEL 1
  je empezarNivel1

  cmp al, "2"   ;SI ES 2 VA AL NIVEL 2
  je empezarNivel2

  cmp al, "3"   ;SI ES 3 VA AL NIVEL 3
  je empezarNivel3

  cmp al, "4"   ;SI ES CUATRO VA A LA HISTORIA DEL JUEGO
  je mostrarHistoria

  cmp al, 27
  je fin

  jmp opciones  ;SI ES CUALQUIER OTRA TECLA VUELVE A PEDIR UNA VALIDA

empezarNivel1:
    call limpiarPantalla
    call nivel1

    push ax; en al esta la cantidad de filas
    push dx; esta el vector solucion
    ;Límite inferior
    push 15
    ;Límite derecho
    push 44
    ;Límite izquierdo
    push 36
    ;Límite superior
    push 11

    jmp gameLoop

empezarNivel2:
  ; call limpiarPantalla
  ; call nivel2
  ;
  ; push
  ; jmp gameLoop

empezarNivel3:
  ; call limpiarPantalla
  ; call nivel3
  ; jmp gameLoop

gameLoop:
  call movimientoJugador
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
