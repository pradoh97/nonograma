.8086
.model small
.stack 100h
.data

;Título
titulo 	db	"HISTORIA DEL NONOGRAM", 24h

;Cuerpo
re1			db 	"En 1987, Non Ishida, un editor de graficos japones, gano una competencia en", 0dh, 0ah
				db	"Tokio por la creacion de imagenes en cuadricula usando luces de rascacielos", 0dh, 0ah
				db	"que eran encendidas y apagadas. Casualmente, un desarrollador de rompecabezas", 0dh, 0ah
				db	"profesional japones, llamado Tetsuya Nishio, invento el mismo rompecabezas.", 0dh, 0ah
				db	"Los rompecabezas para -pintar por numeros- comenzaron a aparecer en revistas", 0dh, 0ah
		 	  db	"japonesas especializadas en puzzles. Non Ishida publico tres rompecabezas de", 0dh, 0ah
		 	  db	"imagenes cuadriculadas en 1988, en Japon, bajo el nombre de Window Art Puzzles.", 0dh, 0ah
			  db  "En 1990, James Dalgety en el Reino Unido invento el nombre Nonogramas, luego", 0dh, 0ah
			  db	"de que Non Ishida y el periodico britanico The Sunday Telegraph comenzaran a ", 0dh, 0ah
			  db	"publicarlos semanalmente. En 1993, el primer libro de nonogramas fue publicado", 0dh, 0ah
			  db	"por Non Ishida. The Sunday Telegraph dedico un libro a los puzles", 0dh, 0ah
			  db	"titulado	el 'Libro de Nonogramas'.", 24h

;Retorno
re2			db	"Presione una tecla para regresar al menu principal.", 24h

.code
public historia
extrn imprimir:proc
extrn cursor:proc

	historia proc
		imprimirHistoria:
  		mov dh, 1
  		mov dl, 27
  		call cursor

    	lea dx, titulo
    	call imprimir

  		mov dh, 3
  		mov dl, 0
  		call cursor

      lea dx, re1
      call imprimir

  		mov dh, 3
  		mov dl, 0
  		call cursor

      lea dx, re1
      call imprimir

			mov dh, 24
	  	mov dl, 15
	  	call cursor

	    lea dx, re2
	    call imprimir

      mov ah, 0
      int 16h

			ret
		historia endp
end
