.8086
.model small
.stack 100h

.data
.code
public imprimir
public cursor
public limpiarPantalla
public imprimirCaracter

;Recibe el offset de lo que se va a imprimr por el registro DX
imprimir proc
	mov ah, 9
	int 21h
	ret
imprimir endp

;Recibe lo que se va a imprimr por el registro DL
imprimirCaracter proc
	mov ah, 2
	int 21h
	ret
imprimirCaracter endp

;Recibe en dh la coordenada y, en dl la coordenada x a donde posicionar el cursor.
cursor proc
  mov ah, 2		       ;POSICIONAMOS EL CURSOR
  mov bh, 0 		     ;PAGINA SIEMPRE LA MISMA
  int 10h

  ret
cursor endp

limpiarPantalla proc
	push ax

	mov ah, 0
	mov al, 3
	int 10h

	pop ax
	ret
limpiarPantalla endp
end
