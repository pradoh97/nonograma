.8086
.model small
.stack 100h

.data
.code
public imprimir
public cursor

;Recibe el offset de lo que se va a imprimr por el registro DX
imprimir proc
	mov ah, 9
	int 21h
	ret
imprimir endp

;Recibe en dl la coordenada y, en dh la coordenada x a donde posicionar el cursor.
cursor proc
  mov ah, 2		       ;POSICIONAMOS EL CURSOR
  mov bh, 0 		     ;PAGINA SIEMPRE LA MISMA
  int 10h

  ret
cursor endp
end
