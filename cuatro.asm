.8086
.model small
.stack 100h
.data

titulo 	db	"HISTORIA DEL NONOGRAM", 24h
re1		db 	"En 1987, Non Ishida, un editor de gráficos japonés, ganó una competencia en", 0dh, 0ah
		db	"Tokio por el diseño de imágenes en cuadrícula usando luces de rascacielos", 0dh, 0ah
		db	"que eran encendidas y apagadas. Casualmente, un diseñador de rompecabezas", 0dh, 0ah
		db	"profesional japonés, llamado Tetsuya Nishio, inventó el mismo rompecabezas.", 0dh, 0ah
		db	"Los rompecabezas para -pintar por números- comenzaron a aparecer en revistas", 0dh, 0ah
	 	db	"japonesas especializadas en puzzles. Non Ishida publicó tres rompecabezas de", 0dh, 0ah
	 	db	"imágenes cuadriculadas en 1988, en Japón, bajo el nombre de -Window Art Puzzles-.", 0dh, 0ah
		db  "Más tarde en 1990, James Dalgety en el Reino Unido inventó el nombre Nonogramas, luego", 0dh, 0ah
		db	"de que Non Ishida y el periódico británico The Sunday Telegraph comenzaran a ", 0dh, 0ah
		db	"publicarlos una vez por semana. En 1993, el primer libro de nonogramas fue publicado", 0dh, 0ah
		db	"por Non Ishida en Japón. The Sunday Telegraph publicó un libro dedicado a los puzles", 0dh, 0ah
		db	"titulado	el -Libro de Nonogramas-. Los nonogramas también fueron publicados en", 0dh, 0ah
		db	"Suecia, Estados Unidos (originalmente por la revista Games), Sudáfrica y ", 0dh, 0ah
		db	"otros países. El periódico The Sunday Telegraph realizó una competencia en 1998", 0dh, 0ah
		db	"para escoger un nuevo nombre para sus rompecabezas. El nombre elegido por los", 0dh, 0ah
		db	"lectores fue Griddlers.", 0dh, 0ah, 24h
re2	db	"Presione una tecla para regresar al menu principal", 24h

.code
public Historia
extrn imprimir:proc
extrn cursor:proc

	Historia proc

	mov ax, @data
	mov ds, ax

			mov ah, 0
  		mov al, 3
  		int 10h


  		mov dh, 1 		    ;COORDENADA DE FILA
  		mov dl, 20		      ;COORDENADA DE COLUMNA
  		call cursor

      	lea dx, titulo
      	call imprimir

  		mov dh, 3 		    ;COORDENADA DE FILA
  		mov dl, 0		      ;COORDENADA DE COLUMNA
  		call cursor

      	lea dx, re1
      	call imprimir

  		mov dh, 3 		    ;COORDENADA DE FILA
  		mov dl, 0		      ;COORDENADA DE COLUMNA
  		call cursor

      	lea dx, re1
      	call imprimir

				mov dh, 24 		    ;COORDENADA DE FILA
	  		mov dl, 20		      ;COORDENADA DE COLUMNA
	  		call cursor

	      	lea dx, re2
	      	call imprimir

      	mov ah, 0
      	int 16h

				ret
    Historia endp

end
