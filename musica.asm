.8086
.model small
.stack 100h
.data

.code

public musica
musica proc

  push bx
  push cx

    mov cx, 6087
    mov bx, 100
    int 80h

    mov cx, 4560
    mov bx, 100
    int 80h

    mov cx, 3619
    mov bx, 100
    int 80h

    mov cx, 3043
    mov bx, 100
    int 80h

    mov cx, 2280
    mov bx, 100
    int 80h

    mov cx, 1809
    mov bx, 100
    int 80h

    mov cx, 1521
    mov bx, 300
    int 80h

    mov cx, 1809
    mov bx, 300
    int 80h

    mov cx, 5746
    mov bx, 100
    int 80h

    mov cx, 4560
    mov bx, 100
    int 80h

    mov cx, 3834
    mov bx, 100
    int 80h

    mov cx, 2873
    mov bx, 100
    int 80h

    mov cx, 2280
    mov bx, 100
    int 80h

    mov cx, 1917
    mov bx, 100
    int 80h

    mov cx, 1436
    mov bx, 300
    int 80h

    mov cx, 1917
    mov bx, 300
    int 80h

    mov cx, 5119
    mov bx, 100
    int 80h

    mov cx, 4063
    mov bx, 100
    int 80h

    mov cx, 3416
    mov bx, 100
    int 80h

    mov cx, 2559
    mov bx, 100
    int 80h

    mov cx, 2031
    mov bx, 100
    int 80h

    mov cx, 1715
    mov bx, 100
    int 80h

    mov cx, 1293
    mov bx, 300
    int 80h

    mov cx, 1293
    mov bx, 100
    int 80h

    mov cx, 1293
    mov bx, 100
    int 80h

    mov cx, 1293
    mov bx, 100
    int 80h

    mov cx, 1140
    mov bx, 600
    int 80h

  pop cx
  pop bx

  ret

musica endp
end
