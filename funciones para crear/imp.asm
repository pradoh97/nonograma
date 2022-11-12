.8086
.model small
.stack 100h

.data
.code
public imprimir
;Esta función recibe el offset por el registro DX

imprimir proc
	mov ah, 9
	int 21h
	ret
imprimir endp
end
