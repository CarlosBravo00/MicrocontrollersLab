	#include "p18f45k50.inc"
	processor 18f45k50 	; (opcional)
	org 0x00
	goto configura
	org 0x08 		; posici�n para interrupciones
	retfie
	org 0x18		; posici�n para interrupciones
	retfie
	org 0x30 		; Origen real (opcional pero recomendado)
configura			; Configuraci�n
	setf TRISA, A
	?
	; C�digo principal
	org 0x40


start		
	clrf .32, A
	btfss .16, 0, A
	goto par	    ;si es par
	bsf .32, 1, A	    ;si es impar
	goto start
par
	bsf .32, 0, A
	goto start
	end