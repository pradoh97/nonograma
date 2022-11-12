.8086
.model small
.stack 100h
.data
.code
extrn mostrarMenu:proc
extrn nivel1:proc
extrn nivel2:proc
extrn nivel3:proc
extrn historia:proc

main proc
  mov ax, @data
  mov ds, ax

  ;----------------------------------------------------------------------------
  ;ESTABLECEMOS LOS PARAMETROS DE VIDEO, PANTALLA DE 80x25 - CON LA INT 10
  ;Y EL MODO 3

inicio:
  mov ah, 0
  mov al, 3
  int 10h
  call mostrarMenu

opciones:
  mov ah, 0     ;LA INT 16 PIDE UNA TECLA PERO NO LA MUESTRA EN Pantalla
  int 16h       ;UNA VEZ QUE TENEMOS LA TECLA EN AL LA USAMOS PARA COMPARAR

  ; cmp al, "1"   ;SI ES 1 VA AL NIVEL 1
  ; je nivel1
  ;
  ; cmp al, "2"   ;SI ES 2 VA AL NIVEL 2
  ; je nivel2
  ;
  ; cmp al, "3"   ;SI ES 3 VA AL NIVEL 3
  ; je nivel3

  cmp al, "4"   ;SI ES CUATRO VA A LA HISTORIA DEL JUEGO
  je mostrarHistoria

  cmp al, 27
  je fin

  jmp opciones  ;SI ES CUALQUIER OTRA TECLA VUELVE A PEDIR UNA VALIDA

; nivel1:
;   call nivel1
;   jmp incio
;
; nivel2:
;   call nivel2
;   jmp incio
;
; nivel3:
;   call nivel3
;   jmp incio

mostrarHistoria:
  call historia
  jmp inicio

fin:
  mov ah, 0
  mov al, 3
  int 10h
  mov ax, 4c00h
  int 21h

main endp
end
