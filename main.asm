.8086
.model small
.stack 100h
.data
  nroNivel          db "" ;es el caracter 23° de la linea de cantidad de errores.
  cantidadErrores   db 0
  pistaColumna      db "0 3 2 3 0", 24h
  pistaFila         db "03230", 24h
  origenPistasX     db ""
  origenPistasY     db ""
.code
extrn mostrarMenu:proc
extrn actualizarErrores:proc
; extrn nivel1:proc
; extrn nivel2:proc
; extrn nivel3:proc
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
  je nivel1

  cmp al, "2"   ;SI ES 2 VA AL NIVEL 2
  je nivel2

  cmp al, "3"   ;SI ES 3 VA AL NIVEL 3
  je nivel3

  cmp al, "4"   ;SI ES CUATRO VA A LA HISTORIA DEL JUEGO
  je mostrarHistoria

  cmp al, 27
  je fin

  jmp opciones  ;SI ES CUALQUIER OTRA TECLA VUELVE A PEDIR UNA VALIDA

  nivel1:
    ;Número nivel
    push 1

    ;Pistas
    lea dx, pistaColumna
    push dx
    lea dx, pistaFila
    push dx

    ;Coordenadas de origen en X y después Y
    push 25
    push 1

    ;Cantidad de filas y columnas
    push 5
    push 5

    call limpiarPantalla
    call hud

    mov ah, 01h
    int 21h

    push 1
    call actualizarErrores

    jmp fin

nivel2:
  ; call nivel2
  jmp fin

nivel3:
  ; call nivel3
  jmp fin

mostrarHistoria:
  call limpiarPantalla
  call historia
  jmp inicio

fin:
  ;Esto lo llamo solo para hacer pruebas, borrar cuando terminemos (lo estoy usando para ver que se imprima el hud en el nivel sin tener el nivel)
  mov ah, 01h
  int 21h

  call limpiarPantalla

  mov ax, 4c00h
  int 21h

main endp
end
