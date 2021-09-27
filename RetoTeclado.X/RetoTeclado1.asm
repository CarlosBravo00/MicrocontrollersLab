    #include "p18f45k50.inc"
    processor 18f45k50 	; (opcional).
    org 0x00
    goto CONFIGURA
    org 0x08 		; posici�n para interrupciones.
    retfie
    org 0x18		; posici�n para interrupciones.
    retfie
    org 0x30 		; Origen real (opcional pero recomendado).
    
; VARIABLES
V1 EQU 0
V2 EQU 1
 
CONFIGURA
    MOVLB .15
    CLRF ANSELA, BANKED			; REGA -> DIGITAL.
    CLRF ANSELB, BANKED			; REGB -> DIGITAL.
    BCF INTCON2, 7			; ENABLE pull-ups.
    MOVLW B'00001111'			
    MOVWF TRISB				; Mitad entradas/salidas.
    MOVWF WPUB				; Mitad pull-ups.
    CLRF TRISA				; REGA -> OUTPUT.
    CLRF LATA				; Limpiar la salida A.
    org	0x40				; C�digo principal.
    
SETUP 
    MOVLW b'11101111' ;RB4 COLUMNA 1,4,5,*
    MOVWF LATB
    BTFSS PORTB,0
    GOTO UNO
    BTFSS PORTB,1
    GOTO CUATRO
    BTFSS PORTB,2
    GOTO SIETE
    BTFSS PORTB,3
    GOTO ASTERISCO
    
    MOVLW b'11011111'  ;RB5 COLUMNA DOS, CINCO, OCHO, CERO
    MOVWF LATB
    
    BTFSS PORTB,0
    GOTO DOS
    BTFSS PORTB,1
    GOTO CINCO
    BTFSS PORTB,2
    GOTO OCHO
    BTFSS PORTB,3
    GOTO CERO
    
    MOVLW b'10111111' ;RB6 COLUMNA TRES,SEIS,NUEVE, #
    MOVWF LATB
    
    BTFSS PORTB,0
    GOTO TRES
    BTFSS PORTB,1
    GOTO SEIS
    BTFSS PORTB,2
    GOTO NUEVE
    BTFSS PORTB,3
    GOTO GATO
    
    MOVLW b'01111111' ;RB7 COLUMNA A,B,C,D
    MOVWF LATB
    BTFSS PORTB,0
    GOTO LETRA_A
    BTFSS PORTB,1
    GOTO LETRA_B
    BTFSS PORTB,2
    GOTO LETRA_C
    BTFSS PORTB,3
    GOTO LETRA_D
    GOTO SETUP 

 ;INPUT Si se presiona alg�n bot�n, se le asigna ese valor a W y se manda directo a los Leds
UNO ;Columna1   bot�n del n�mero uno
    CALL DELAY
    BTFSC PORTB, 0
    MOVLW D'1' 
    MOVWF LATA
    GOTO SETUP 
CUATRO ;bot�n del n�mero cuatro
    CALL DELAY
    BTFSC PORTB, 1
    MOVLW D'4' 
    MOVWF LATA
    GOTO SETUP
SIETE ;bot�n del n�mero siete
    CALL DELAY
    BTFSC PORTB, 2
    MOVLW D'7' 
    MOVWF LATA
    GOTO SETUP 
ASTERISCO ;bot�n del asterisco
    CALL DELAY
    BTFSC PORTB, 3
    MOVLW b'10000001' 
    MOVWF LATA
    GOTO SETUP 
    
DOS ;Columna 2  bot�n del  n�mero dos
    CALL DELAY
    BTFSC PORTB, 0
    MOVLW D'2' 
    MOVWF LATA
    GOTO SETUP 
CINCO ;bot�n del n�mero cinco 
    CALL DELAY
    BTFSC PORTB, 1
    MOVLW D'5' 
    MOVWF LATA
    GOTO SETUP 
OCHO ;bot�n del n�mero ocho
    CALL DELAY
    BTFSC PORTB, 2
    MOVLW D'8' 
    MOVWF LATA
    GOTO SETUP 
CERO ;bot�n del n�mero cero
    CALL DELAY
    BTFSC PORTB, 3
    MOVLW D'0' 
    MOVWF LATA
    GOTO SETUP 
    
TRES ; Columna 3 ;bot�n del n�mero tres
    CALL DELAY
    BTFSC PORTB, 0
    MOVLW D'3' 
    MOVWF LATA
    GOTO SETUP 
SEIS ;bot�n del n�mero seis
    CALL DELAY
    BTFSC PORTB, 1
    MOVLW D'6' 
    MOVWF LATA
    GOTO SETUP 
NUEVE ;bot�n del n�mero nueve
    CALL DELAY
    BTFSC PORTB, 2
    MOVLW D'9' 
    MOVWF LATA
    GOTO SETUP 
GATO ;bot�n del gato
    CALL DELAY
    BTFSC PORTB, 3
    MOVLW b'01010101' 
    MOVWF LATA
    GOTO SETUP 

LETRA_A ;Columna 4 ;bot�n de letra A
    CALL DELAY
    BTFSC PORTB, 0
    MOVLW D'10' 
    MOVWF LATA
    GOTO SETUP 
LETRA_B ;bot�n de letra B
    CALL DELAY
    BTFSC PORTB, 1
    MOVLW D'11' 
    MOVWF LATA
    GOTO SETUP 
LETRA_C ;bot�n de letra C
    CALL DELAY
    BTFSC PORTB, 2
    MOVLW D'12' 
    MOVWF LATA
    GOTO SETUP 
LETRA_D ;bot�n de letra D
    CALL DELAY
    BTFSC PORTB, 3
    MOVLW D'13' 
    MOVWF LATA
    GOTO SETUP 
    
DELAY  ;rutina anti rebote
    MOVLW 0XFF
    MOVWF V1
    MOVWF V2
LOOP1
    DECFSZ V2
    GOTO LOOP1
    DECFSZ V1
    GOTO LOOP1
    RETURN
    
    END