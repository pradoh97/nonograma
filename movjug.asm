.8086
.model small
.stack 100h
.data
  limiteInferior    db 0
  limiteDerecho     db 0
  posicionJugadorX  db 0
  posicionJugadorY  db 0
  origenGrillaX     db 0
  origenGrillaY     db 0
  vectorJugada      db "0111010101101111000101110", 24h
  error             db 30h
  fila              db 0
  nrodefilas        db 0

.code
;Recibe por stack los límites de la matriz de movimiento en el siguiente orden:
; - Inferior
; - Derecho
; - Izquierdo
; - Superior
extrn pintar:proc
extrn cursor:proc
extrn imprimirCaracter:proc
public movimientoJugador
movimientoJugador proc

  salvarRegistros:
    push bp
    mov bp, sp
    push si
    push bx
    push dx
    push di

  cargarDesdeStack:
    ;Rescato los límites para el jugador.
    mov dl, ss:[bp+4]
    mov posicionJugadorY, dl
    mov origenGrillaY, dl
    mov dl, ss:[bp+6]
    mov posicionJugadorX, dl
    mov origenGrillaX, dl
    mov dl, ss:[bp+8]
    mov limiteDerecho, dl
    mov dl, ss:[bp+10]
    mov limiteInferior, dl

    mov si, ss:[bp+12]

    mov dl, ss:[bp+14]
    mov fila, dl

  ;Movimiento o seleccion de casillero.
  tecla:
    ;Espera el input del jugador.
    mov ah, 0
    int 16h

    ;73h = s, 77 = w, 61 = a, 64 = d (TODAS EN MINUSCULAS), 20h = espacio, 27d = esc
    cmp al, 73h
    je abajo

    cmp al, 77h
    je arriba

    cmp al, 61h
    je izquierda

    cmp al, 64h
    je derecha

    cmp al, 20h
    je intermedio

    cmp al, 27
    je salirNivel

    jmp tecla ;Si no ingresa una tecla correcta vuelve a pedir otra

  ;Ver si alcanzó el límite inferior.
  abajo:
    mov al, posicionJugadorY
    cmp al, limiteInferior
    je volverArriba
    inc posicionJugadorY
    mov dh, posicionJugadorY
    mov dl, posicionJugadorX
    call cursor
    jmp tecla

  ;Ver si alcanzó el límite superior.
  arriba:
    mov al, posicionJugadorY
    cmp al, origenGrillaY
    je volverAbajo
    dec posicionJugadorY
    mov dh, posicionJugadorY
    mov dl, posicionJugadorX
    call cursor
    jmp tecla

  ;Ver si alcanzó el límite derecho.
  derecha:
    mov al, posicionJugadorX
    cmp al, limiteDerecho
    jae volverIzquierda
    add posicionJugadorX, 2
    mov dh, posicionJugadorY
    mov dl, posicionJugadorX
    call cursor
    jmp tecla

  ;Ver si alcanzó el límite izquierdo.
  izquierda:
    mov al, posicionJugadorX
    cmp al, origenGrillaX
    je volverDerecha
    sub posicionJugadorX, 2
    mov dh, posicionJugadorY
    mov dl, posicionJugadorX
    call cursor
    jmp tecla

  ;cambiar por respuesta erroneo.
  intermedio:
    jmp comparoVec

  salirNivel:
    jmp restaurarRegistros

  volverArriba:
    mov dh, origenGrillaY
    mov posicionJugadorY, dh
    mov dl, posicionJugadorX
    call cursor
    jmp tecla
  volverAbajo:
    mov dh, limiteInferior
    mov posicionJugadorY, dh
    mov dl, posicionJugadorX
    call cursor
    jmp tecla
  volverIzquierda:
    mov dl, origenGrillaX
    mov posicionJugadorX, dl
    mov dh, posicionJugadorY
    call cursor
    jmp tecla
  volverDerecha:
    mov dl, limiteDerecho
    mov posicionJugadorX, dl
    mov dl, posicionJugadorX
    call cursor
  jmp tecla

  comparoVec:
;bx= nrofilas*(posicionJugadorY)
  mov dl, origenGrillaY
  mov dh, posicionJugadorY
  sub dh, dl
  mov ax, 5
  mul dh
  mov bx, ax
  mov dl, origenGrillaX
  mov dh, posicionJugadorX
  sub dh, dl

  add bl, dh
  mov bh, 0

  cmp vectorJugada[bx], 31h
  je Acierto
  jmp Error

  Acierto:
  mov al, 219
  mov bl, 9h
  mov cx, 2
  call pintar
  mov vectorJugada[bx], 32h
  jmp jump tecla

  Error:
  mov al, "X"
  mov bl, 4h
  mov cx, 2
  call pintar
  mov vectorJugada[bx], 33h

  inc error
  cmp error, 34h
  je GameOver

  mov dh, 3 		    ;COORDENADA DE FILA
  mov dl, 23		      ;COORDENADA DE COLUMNA
  call cursor

  mov al, error
  mov bl, 4h
  mov cx, 2
  call pintar

  mov dh, posicionJugadorY 		    ;COORDENADA DE FILA
  mov dl, posicionJugadorX		      ;COORDENADA DE COLUMNA
  call cursor
    
  jmp tecla


  restaurarRegistros:
    pop di
    pop dx
    pop bx
    pop si
    pop bp
  ret 8
movimientoJugador endp
end
