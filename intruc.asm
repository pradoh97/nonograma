.8086
.model small
.stack 100h
.data

i1      db  "COMO JUGAR NONOGRAM", 24h
i2      db  "-La idea del juego es revelar una imagen oculta.", 0dh, 0ah
        db  "-Para moverte tenes que apretar las teclas WASD.", 0dh, 0ah
        db  "-Para colorearlo tenes que apretar la barra espaciadora.", 0dh, 0ah
        db  "-Los numeros son pistas que te indican cuantos cuadros tenes que colorear.", 0dh, 0ah
        db  "-Todos los numeros corresponden a una secuencia. Si hay mas de un numero", 0dh, 0ah
        db  "tiene que haber al menos un cuadro en blanco entre cada secuencia", 0dh, 0ah
        db  "-El orden tambien es importante. El orden de los cuadros coloreados es el", 0dh, 0ah
        db  "mismo orden en el que aparecen los numeros.", 0dh, 0ah, 24h

.code

extrn cursor:proc
extrn imprimir:proc
public intruccion
intruccion proc




ret
intruccion endp
end
