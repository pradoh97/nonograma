.8086
.model small
.stack 100h
.data
  limiteInferior              db 0
  limiteDerecho               db 0
  posicionJugadorX            db 0
  posicionJugadorY            db 0
  origenGrillaX               db 0
  origenGrillaY               db 0
  offsetVectorJugada          dw 0
  cantidadErrores             db 30h
  cantidadFilas               db 0
  nrodefilas                  db 0
  cantidadAciertos            db 0
  cantidadAciertosJugador     db 0

.code
;Recibe por stack los límites de la matriz de movimiento en el siguiente orden:
;Cantidad de filas
;Recibe vector jugada
; - Inferior
; - Derecho
; - Izquierdo
; - Superior
extrn win:proc
extrn actualizarErrores:proc
extrn over:proc
extrn pintar:proc
extrn cursor:proc
extrn imprimirCaracter:proc
public movimientoJugador
movimientoJugador proc
  mov cantidadErrores, 30h
  ;Profilaxis.
  salvarRegistros:
    push bp
    mov bp, sp
    push si
    push bx
    push dx
    push di
  cargarDesdeStack:
    ;Límite superior
    mov dl, ss:[bp+4]
    mov posicionJugadorY, dl
    mov origenGrillaY, dl
    ;Límite izquierdo
    mov dl, ss:[bp+6]
    mov posicionJugadorX, dl
    mov origenGrillaX, dl
    ;Límite derecho
    mov dl, ss:[bp+8]
    mov limiteDerecho, dl
    ;Límite izquierdo
    mov dl, ss:[bp+10]
    mov limiteInferior, dl

    ;Rescata el vector jugada del nivel seleccionado
    mov bx, ss:[bp+12]
    mov offsetVectorJugada, bx

    ;Rescata la cantidad de filas del nivel seleccionado
    mov dl, ss:[bp+14]
    mov cantidadFilas, dl

  ;Cuenta cuantos aciertos hay en un nivel.
  mov di, offsetVectorJugada
  mov cantidadAciertos, 0
  mov cantidadAciertosJugador, 0

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
    ;Espera el input del jugador. Si no ingresa una tecla correcta vuelve a pedir otra
    mov ah, 0
    int 16h

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

    jmp tecla

  ;Todas las direcciones validan que no se haya alcanzado un límite.
  abajo:
    mov al, posicionJugadorY
    cmp al, limiteInferior
    jae volverArriba
    inc posicionJugadorY
    mov dh, posicionJugadorY
    mov dl, posicionJugadorX
    call cursor
    jmp tecla
  arriba:
    mov al, posicionJugadorY
    cmp al, origenGrillaY
    jbe volverAbajo
    dec posicionJugadorY
    mov dh, posicionJugadorY
    mov dl, posicionJugadorX
    call cursor
    jmp tecla
  derecha:
    mov al, posicionJugadorX
    cmp al, limiteDerecho
    jae volverIzquierda
    add posicionJugadorX, 2
    mov dh, posicionJugadorY
    mov dl, posicionJugadorX
    call cursor
    jmp tecla
  izquierda:
    mov al, posicionJugadorX
    cmp al, origenGrillaX
    je volverDerecha
    sub posicionJugadorX, 2
    mov dh, posicionJugadorY
    mov dl, posicionJugadorX
    call cursor
    jmp tecla

  ;Valida la respuesta dada.
  intermedio:
    jmp comparoRespuesta

  salirNivel:
    jmp restaurarRegistros

  ;Si se alcanza algún límite de la grilla, devuelve al jugador al límite opuesto.
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

  ;Compara la respuesta con la solución. Utilizamos el teorema fundamental de Guille.
  comparoRespuesta:
    ;Posición vertical en 2D pasado a 1D
    xor dx, dx
    xor ax, ax
    mov dh, posicionJugadorY
    sub dh, origenGrillaY

    ;Posición horizontal en 2D pasado 1D
    mov ah, 0
    mov al, cantidadFilas
    mul dh
    mov bx, ax

    ;Ya que la relación horizontal:vertical es 2:1, necesitamos dividir por dos a la posición en X en 1D
    mov dh, posicionJugadorX
    sub dh, origenGrillaX
    shr dh, 1

    ;Obtenemos la posición final en el espacio de 1D
    add bl, dh
    mov bh, 0

    ;Valido la respuesta
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

    ;Cambia el caracter de la matriz por el indicador valido
    mov byte ptr[si], 32h
    mov al, 219
    mov bl, 9h
    mov cx, 2
    call pintar

    mov al, cantidadAciertos
    cmp cantidadAciertosJugador, al
    je ganaste
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

    ;Actualiza los errores usando el valor pasado por stack que está en DL
    mov dl, cantidadErrores
    push dx
    call actualizarErrores

    mov dl, posicionJugadorX
    mov dh, posicionJugadorY
    call cursor

    jmp teclaIntermedio

  gameOver:
    call over
    jmp restaurarRegistros

  ganaste:
    call win
    jmp restaurarRegistros

  restaurarRegistros:
    pop di
    pop dx
    pop bx
    pop si
    pop bp
  ret 12
movimientoJugador endp
end
