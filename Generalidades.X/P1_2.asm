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
	setf 0x20, A
	movf 0x20, F, A
	btfss STATUS, 4, A
	clrf 0x20, A
	goto start
	end