.8086
.model small
.stack 100h
.data

i1      db  "COMO JUGAR NONOGRAM", 24h
i2      db  "-La idea del juego es revelar una imagen oculta.", 0dh, 0ah
        db  " " ,0dh, 0ah
        db  " -Para moverte tenes que apretar las teclas WASD.", 0dh, 0ah
        db  " " ,0dh, 0ah
        db  " -Para colorearlo tenes que apretar la barra espaciadora.", 0dh, 0ah
        db  " " ,0dh, 0ah
        db  " -Los numeros son pistas que te indican cuantos cuadros tenes que colorear.", 0dh, 0ah
        db  " " ,0dh, 0ah
        db  " -Todos los numeros corresponden a una secuencia. Si hay mas de un numero", 0dh, 0ah
        db  " tiene que haber al menos un cuadro en blanco entre cada secuencia", 0dh, 0ah
        db  " " ,0dh, 0ah
        db  " -El orden tambien es importante. El orden de los cuadros coloreados es el", 0dh, 0ah
        db  " mismo orden en el que aparecen los numeros.", 0dh, 0ah, 24h
i3			db	"Presione una tecla para regresar al menu principal.", 24h

.code
extrn cursor:proc
extrn imprimir:proc
public instruccion
instruccion proc

  push ax
  push dx

      mov dh, 1
      mov dl, 30
      call cursor

      lea dx, i1
      call imprimir

      mov dh, 3
      mov dl, 1
      call cursor

      lea dx, i2
      call imprimir

      mov dh, 24
      mov dl, 15
      call cursor

      lea dx, i3
      call imprimir

      mov ah, 0
      int 16h

    pop dx
    pop ax

ret
instruccion endp
end
