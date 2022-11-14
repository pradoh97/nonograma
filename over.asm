.8086
.model small
.stack 100h
.data
	posCartelX db 10             ;MODIFICAR
	posCartelY db 2              ;MODIFICAR
	texto db 'Pulse enter para empezar denuevo o alguna boludes si kieren', 0dh,0ah,24h  ;MODIFICAR
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
	main proc
		mov ax,@data
		mov ds, ax

		mov ah, 2h		;posicion inicial del cartel
		mov bh, 0 		;misma página
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
		mov ah, 4ch
		int 21h
	main endp
end
