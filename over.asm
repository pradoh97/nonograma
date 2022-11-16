.8086
.model small
.stack 100h
.data
	posCartelX db 15             ;MODIFICAR
	posCartelY db 4             ;MODIFICAR
	texto db 'Pulse Enter para volver al menu.', 0dh,0ah,24h  ;MODIFICAR
	borde db 50 dup (176),0dh,0ah,24h
	game1 db 176,176,176,176,219,219,176,176,219,219,176,176,176,176,176,176,219,219,219,219,219,219,176,176,176,176,219,219,176,176,'XX',176,176,219,219,176,176,219,219,219,219,219,219,219,219,219,219,176,176,0dh,0ah,24h
	game2 db 176,176,219,219,176,176,176,176,176,176,176,176,176,176,219,219,176,176,176,176,176,176,219,219,176,176,219,219,219,219,176,176,219,219,219,219,176,176,176,176,'XX',176,176,176,176,176,176,176,176,0dh,0ah,24h
	game3 db 176,176,219,219,176,176,219,219,219,219,219,219,176,176,219,219,219,219,219,219,176,176,219,219,176,176,219,219,176,176,219,219,176,176,219,219,176,176,219,219,219,219,219,219,219,219,176,176,176,176,0dh,0ah,24h
	game4 db 176,176,219,219,176,176,'XX',176,176,219,219,176,176,219,219,176,176,176,176,176,176,219,219,176,176,219,219,176,176,176,176,176,176,176,176,176,176,219,219,176,176,176,176,176,176,176,176,176,176,0dh,0ah,24h
	game5 db 176,176,176,176,219,219,219,219,219,219,176,176,176,176,219,219,176,176,176,176,176,176,219,219,'XX',219,219,176,176,176,176,176,176,219,219,176,176,219,219,219,219,219,219,219,219,219,219,176,176,0dh,0ah,24h
	over1 db 176,176,176,176,219,219,219,219,219,219,176,176,176,176,219,219,176,176,176,176,'XX',219,219,176,176,219,219,219,219,176,176,219,219,219,219,176,176,219,219,219,219,219,219,219,219,176,176,176,176,0dh,0ah,24h
	over2 db 176,176,219,219,'XX',176,176,176,176,219,219,176,176,219,219,176,176,176,176,176,176,219,219,176,176,219,219,176,176,176,176,176,176,176,176,176,176,219,219,176,176,176,176,176,176,219,219,176,176,0dh,0ah,24h
	over3 db 176,176,219,219,176,176,176,176,176,176,219,219,176,176,176,176,176,176,176,176,219,219,176,176,176,176,219,219,219,219,219,219,176,176,'XX',176,176,219,219,176,176,219,219,219,219,176,176,176,176,0dh,0ah,24h
	over4 db 176,176,219,219,176,176,176,176,176,176,219,219,176,176,176,176,219,219,176,176,219,219,176,176,176,176,219,219,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,219,219,'XX',0dh,0ah,24h
	over5 db 176,176,176,176,219,219,176,176,219,219,176,176,176,176,176,176,176,176,219,219,176,176,'XX',176,176,219,219,219,219,219,219,219,219,219,219,176,176,219,219,176,176,176,176,176,176,219,219,176,176,0dh,0ah,24h
.code
public over
	extrn limpiarPantalla:proc

	over proc
		call limpiarPantalla

		mov ah, 2h										;posicion inicial del cartel
		mov bh, 0 										;misma página
		mov dh, posCartelY
 		mov dl, posCartelx
 		int 10h
		push dx

		mov ah,9
		mov dx, offset borde
		int 21h
		pop dx
		inc dh
	;---------------------------------------------------
		mov ah, 2h
 		int 10h
		push dx

		mov ah,9
		mov dx, offset game1
		int 21h
		pop dx
		inc dh

		mov ah, 2h
 		int 10h
		push dx

		mov ah,9
		mov dx, offset game2
		int 21h
		pop dx
		inc dh

		mov ah, 2h
 		int 10h
		push dx

		mov ah,9
		mov dx, offset game3
		int 21h
		pop dx
		inc dh

		mov ah, 2h
 		int 10h
		push dx

		mov ah,9
		mov dx, offset game4
		int 21h
		pop dx
		inc dh

		mov ah, 2h
 		int 10h
		push dx

		mov ah,9
		mov dx, offset game5
		int 21h
		pop dx
		inc dh
	;---------------------------------------------------
		mov ah, 2h
 		int 10h
		push dx

		mov ah,9
		mov dx, offset borde
		int 21h
		pop dx
		inc dh
	;---------------------------------------------------
		mov ah, 2h
 		int 10h
		push dx

		mov ah,9
		mov dx, offset over1
		int 21h
		pop dx
		inc dh

		mov ah, 2h
 		int 10h
		push dx

		mov ah,9
		mov dx, offset over2
		int 21h
		pop dx
		inc dh

		mov ah, 2h
 		int 10h
		push dx

		mov ah,9
		mov dx, offset over3
		int 21h
		pop dx
		inc dh

		mov ah, 2h
 		int 10h
		push dx

		mov ah,9
		mov dx, offset over4
		int 21h
		pop dx
		inc dh

		mov ah, 2h
 		int 10h
		push dx

		mov ah,9
		mov dx, offset over5
		int 21h
		pop dx
		inc dh
	;---------------------------------------------------
		mov ah, 2h
 		int 10h
		push dx

		mov ah,9
		mov dx, offset borde
		int 21h
		pop dx
		inc dh
	;---------------------------------------------------
		mov ah, 2h
		mov dl, 15
		add dh, 4
 		int 10h

		mov ah,9
		mov dx, offset texto
		int 21h
	;---------------------------------------------------
	musicaDerrota:
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

	leerTecla:

		mov ah, 08h
		int 21h

		cmp al, 0dh
	jne leerTecla

	ret
	over endp
end
