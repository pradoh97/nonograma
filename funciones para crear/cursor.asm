.8086
.model small
.stack 100h

.code
public cursor

cursor proc

mov ah, 2		       ;POSICIONAMOS EL CURSOR
mov bh, 0 		     ;PAGINA SIEMPRE LA MISMA
int 10h

ret
cursor endp
end
