.8086
.model small
.stack 100h
.data

.code

public musicad
musicad proc

  push bx
  push cx

    mov cx, 4063
    mov bx, 400
    int 80h

    mov cx, 4304
    mov bx, 400
    int 80h

    mov cx, 4560
    mov bx, 400
    int 80h

    mov cx, 4831
    mov bx, 650
    int 80h

  pop cx
  pop bx

ret

musicad endp
end
