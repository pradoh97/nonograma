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
  offsetVectorJugada dw 0
  cantidadErrores    db 30h
  cantidadFilas     db 0
  nrodefilas        db 0
  cantidadAciertos  db 0 ;Los aciertos totales de un nivel.
  cantidadAciertosJugador  db 0 ;Los aciertos que hizo el jugador.
.code
;Recibe por stack los límites de la matriz de movimiento en el siguiente orden:
; - Inferior
; - Derecho
; - Izquierdo
; - Superior
;Recibe vector jugada
extrn actualizarErrores:proc
extrn over:proc
extrn pintar:proc
extrn cursor:proc
extrn imprimirCaracter:proc
public movimientoJugador
movimientoJugador proc
  mov cantidadErrores, 30h
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

    mov bx, ss:[bp+12]
    mov offsetVectorJugada, bx
    mov dl, ss:[bp+14]
    mov cantidadFilas, dl

  ;Cuenta cuantos aciertos hay en un nivel.
  mov di, offsetVectorJugada
  contarAciertosEnNivel:
    cmp byte ptr[di], 24h
    je tecla

    cmp byte ptr[di], "1"
    je sumaAciertoEnNivel
    inc di
    jmp contarAciertosEnNivel

    sumaAciertoEnNivel:
      inc di
      inc cantidadAciertos
  jmp contarAciertosEnNivel

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
    jae volverArriba
    inc posicionJugadorY
    mov dh, posicionJugadorY
    mov dl, posicionJugadorX
    call cursor
    jmp tecla

  ;Ver si alcanzó el límite superior.
  arriba:
    mov al, posicionJugadorY
    cmp al, origenGrillaY
    jbe volverAbajo
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
    mov dh, posicionJugadorY
    call cursor
  teclaIntermedio:
    jmp tecla

  comparoVec:
    ;Para asegurarnos
    xor dx, dx
    ;Para asegurarnos
    xor ax, ax
    ;bx= nrofilas*(posicionJugadorY-origenGrillaY)+(posicionJugadorX-origenGrillaX)/2
    mov dh, posicionJugadorY
    sub dh, origenGrillaY

    ;Nro filas
    mov ah, 0
    mov al, cantidadFilas

    ;Multiplica al por dh
    mul dh
    mov bx, ax

    ;dec dl
    mov dh, posicionJugadorX
    sub dh, origenGrillaX
    shr dh, 1

    add bl, dh
    mov bh, 0
    mov ax, bx

    mov si, offsetVectorJugada
    add si, bx
    cmp byte ptr[si], 31h
    je acierto
    cmp byte ptr[si], 32h
    je teclaIntermedio
    cmp byte ptr[si], 33h
    je teclaIntermedio
    jmp error

  acierto:
    inc cantidadAciertosJugador

    mov byte ptr[si], 32h
    mov al, 219
    mov bl, 9h
    mov cx, 2
    call pintar

    mov al, cantidadAciertos
    cmp cantidadAciertosJugador, al
    je gameOver

    jmp teclaIntermedio

  error:
    mov byte ptr[si], 33h
    mov al, "X"
    mov bl, 4h
    mov cx, 2
    call pintar

    inc cantidadErrores
    cmp cantidadErrores, 34h
    je gameOver

    mov dl, cantidadErrores
    push dx
    call actualizarErrores

    mov dl, posicionJugadorX
    mov dh, posicionJugadorY
    call cursor

    jmp teclaIntermedio

  gameOver:
    call over

  restaurarRegistros:
    pop di
    pop dx
    pop bx
    pop si
    pop bp
  ret 12
movimientoJugador endp
end
