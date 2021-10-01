#include "p18f45k50.inc"
    processor 18f45k50 	; (opcional).
    org 0x00
    goto CONFIGURA
    org 0x08 		; posici�n para interrupciones.
    retfie
    org 0x18		; posici�n para interrupciones.
    retfie
    org 0x30 		; Origen real (opcional pero recomendado).

; DEFINICI�N DE REGISTROS VARIABLES.
_255 EQU 0x10

 
CONFIGURA
    movlb .15
    GOTO START