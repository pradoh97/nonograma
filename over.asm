.8086
.model small
.stack 100h
.data
	posCartelX db 15             ;MODIFICAR
	posCartelY db 4             ;MODIFICAR
	texto db 'Pulse Enter para volver al menu.',24h  ;MODIFICAR
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

	extrn cursor:proc
	extrn limpiarPantalla:proc
	extrn musicad:proc
	extrn imprimir:proc
public over
	over proc
		call limpiarPantalla

		mov ah, 2h										;posicion inicial del cartel
		mov bh, 0 										;misma página
		mov dh, posCartelY
 		mov dl, posCartelx
 		int 10h
		push dx

		mov dx, offset borde
		call imprimir
		pop dx
		inc dh
	;---------------------------------------------------
		mov ah, 2h
 		int 10h
		push dx

		lea dx, game1
		call imprimir
		pop dx
		inc dh

		mov ah, 2h
 		int 10h
		push dx

		lea dx, game2
		call imprimir
		pop dx
		inc dh

		mov ah, 2h
 		int 10h
		push dx

		lea dx, game3
		call imprimir
		pop dx
		inc dh

		mov ah, 2h
 		int 10h
		push dx

		lea dx, game4
		call imprimir
		pop dx
		inc dh

		mov ah, 2h
 		int 10h
		push dx

		lea dx, game5
		call imprimir
		pop dx
		inc dh
	;---------------------------------------------------
		mov ah, 2h
 		int 10h
		push dx

		lea dx, borde
		call imprimir
		pop dx
		inc dh
	;---------------------------------------------------
		mov ah, 2h
 		int 10h
		push dx

		lea dx, over1
		call imprimir
		pop dx
		inc dh

		mov ah, 2h
 		int 10h
		push dx

		lea dx, over2
		call imprimir
		pop dx
		inc dh

		mov ah, 2h
 		int 10h
		push dx

		lea dx, over3
		call imprimir
		pop dx
		inc dh

		mov ah, 2h
 		int 10h
		push dx

		lea dx, over4
		call imprimir
		pop dx
		inc dh

		mov ah, 2h
 		int 10h
		push dx

		lea dx, over5
		call imprimir
		pop dx
		inc dh
	;---------------------------------------------------
		mov ah, 2h
 		int 10h
		push dx

		lea dx, borde
		call imprimir
		pop dx
		inc dh
	;---------------------------------------------------

		mov dl, 15
		mov dh, 25
 		call cursor

		lea dx, texto
		call imprimir
	;---------------------------------------------------
		call musicad

	leerTecla:

		mov ah, 0
		int 16h
		cmp al, 0dh

	jne leerTecla

	ret
	over endp
end
