.8086
.model small
.stack 100h
.data
.code

public vec

vec proc
;ESTA FUNCION RECIBE EL VECTOR SOLUCION DE CADA NIVEL Y LO DUPLICA
;EN EL VECTOR JUGADA.
  push bp
  mov bp, sp
  push bx
  push si
  push ax


  mov bx, ss:[bp+6] ;rescato el offset vector solucion
  mov si, ss:[bp+4] ;rescato el offset vector jugada

  carga:
    mov al, [bx]
    mov byte [si], al
    inc si
    inc bx
    cmp byte ptr [bx], 24h
    je finCarga
    jmp carga

  finCarga:
    pop ax
    pop si
    pop bx
    pop bp
  ret 4
  vec endp
end
