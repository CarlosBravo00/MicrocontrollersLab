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
    clrf    TRISB, A		; RB -> OUTPUT.
    clrf    ANSELB, BANKED	; RB -> DIGITAL.
    org	0x40		; C�digo principal.
start
    clrf   LATB, A
    
incrementa
    incf    LATB,F,A
    goto incrementa
    
  end
