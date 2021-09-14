    #include "p18f45k50.inc"
    processor 18f45k50		; (opcional)
    
    org	0x00
    goto configura
    org	0x08			; posici�n para interrupciones.
    retfie
    org	0x18			; posici�n para interrupciones.
    retfie
    org	0x30			; Origen real (opcional pero recomendado).
configura			; Configuraci�n.
    movlb   .15			; BSR = 15.
    clrf    ANSELA, BANKED	; RA -> DIGITAL.
    clrf    TRISA, A		; RA -> OUTPUT.
    clrf    ANSELB, BANKED	; RB -> DIGITAL.
    setf    TRISB, A		; RB -> INPUT.
    bcf	    INTCON2, 7, A	; ENABLE PULL-UPs.
    bsf	    WPUB, 0, A		; ENABLE PULL-UP RB0.
    clrf    LATA, A		; Clear REGA.
	
; Definici�n de variables RA(hgfedcba).
cero	EQU b'00111111'
uno	EQU b'00000110'
dos	EQU b'01011011'
tres	EQU b'01001111'
cuatro	EQU b'01100110'
cinco	EQU b'01101101'
seis	EQU b'01111101'
siete	EQU b'00000111'
ocho	EQU b'01111111'
nueve	EQU b'01101111'
	org	0x40			; C�digo principal.
start
Cero
    movlw   cero
    movwf   LATA, A
    btfsc   PORTB, 0,  A		; Si no se activa el bot�n, entrar a ciclo.
    goto    Cero
    call    ESPERA			; Esperar a que se suelte el bot�n.
Uno
    movlw   uno
    movwf   LATA, A
    btfsc   PORTB, 0,  A		; Si no se activa el bot�n, entrar a ciclo.
    goto    Uno
    call    ESPERA			; Esperar a que se suelte el bot�n.
Dos
    movlw   dos
    movwf   LATA, A
    btfsc   PORTB, 0,  A		; Si no se activa el bot�n, entrar a ciclo.
    goto    Dos
    call    ESPERA			; Esperar a que se suelte el bot�n.
Tres
    movlw   tres
    movwf   LATA, A
    btfsc   PORTB, 0,  A		; Si no se activa el bot�n, entrar a ciclo.
    goto    Tres
    call    ESPERA			; Esperar a que se suelte el bot�n.
Cuatro
    movlw   cuatro
    movwf   LATA, A
    btfsc   PORTB, 0,  A		; Si no se activa el bot�n, entrar a ciclo.
    goto    Cuatro
    call    ESPERA			; Esperar a que se suelte el bot�n.
Cinco
    movlw   cinco
    movwf   LATA, A
    btfsc   PORTB, 0,  A		; Si no se activa el bot�n, entrar a ciclo.
    goto    Cinco
    call    ESPERA			; Esperar a que se suelte el bot�n.
Seis
    movlw   seis
    movwf   LATA, A
    btfsc   PORTB, 0,  A		; Si no se activa el bot�n, entrar a ciclo.
    goto    Seis
    call    ESPERA			; Esperar a que se suelte el bot�n.
Siete
    movlw   siete
    movwf   LATA, A
    btfsc   PORTB, 0, A			; Si no se activa el bot�n, entrar a ciclo.
    goto    Siete
    call    ESPERA			; Esperar a que se suelte el bot�n.
Ocho
    movlw   ocho
    movwf   LATA, A
    btfsc   PORTB, 0,  A		; Si no se activa el bot�n, entrar a ciclo.
    goto    Ocho
    call    ESPERA			; Esperar a que se suelte el bot�n.
Nueve
    movlw   nueve
    movwf   LATA, A
    btfsc   PORTB, 0,  A		; Si no se activa el bot�n, entrar a ciclo.
    goto    Nueve
    call    ESPERA			; Esperar a que se suelte el bot�n.
;Regresar a 0 despu�s del 9.
    goto    Cero

ESPERA
    btfss   PORTB, 0, A
    goto    ESPERA			; Si se sigue recibiendo 0 (pulsado), esperar a que se suelte.
    return				; Si se recibe un 1 (no pulsado), regresar

  end
