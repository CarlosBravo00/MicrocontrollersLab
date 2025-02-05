#include "p18f45k50.inc"
    processor 18f45k50 	; (opcional).
    org 0x00
    goto CONFIGURA
    org 0x08 		; posici�n para interrupciones.
    retfie
    org 0x18		; posici�n para interrupciones.
    retfie
    org 0x30 		; Origen real (opcional pero recomendado).

; DEFINICION DE REGISTROS VARIABLES.
boton_presionado    EQU 0x20
    
; DEFINICION DE VARIABLES PARA DELAY.
_256	EQU 0x25
_26	EQU 0x26

; DEFINICION DE LEDS Y BIT REPRESENTATIVO DE CADA COLOR.
    #define led_azul		LATA, 0, A
    #define led_amarillo	LATA, 1, A
    #define led_naranja		LATA, 2, A
    #define led_blanco		LATA, 3, A
    #define led_rojo		LATA, 4, A
    #define led_verde		LATA, 5, A
    #define fila1		PORTB, 0, A
    #define fila2		PORTB, 1, A
    #define bit_led_azul	boton_presionado, 0, A
    #define bit_led_amarillo	boton_presionado, 1, A
    #define bit_led_naranja	boton_presionado, 2, A
    #define bit_led_blanco	boton_presionado, 3, A
 
CONFIGURA
    movlb   .15
    clrf    ANSELA, BANKED			; REGA -> DIGITAL.
    clrf    ANSELB, BANKED			; REGB -> DIGITAL.
    bcf	    INTCON2, 7				; ENABLE pull-ups.
    movlw   B'00000011'			
    movwf   TRISB				; 3 salidas, 2 entradas.
    movwf   WPUB				; habilitar 2 pull ups.
    clrf    TRISA				; REGA -> OUTPUT.
    clrf    LATA				; Limpiar la salida A.
    
LOOP
    call    RECORRIDO
    goto    LOOP
    
RECORRIDO
    movlw   b'11111011'			; ACTIVAR COLUMNA 1 (verde, naranja).
    movwf   LATB, A
    btfss   fila1			; Revisar si se presiona el led verde.
    goto    BOTON_VERDE
    btfss   fila2			; Revisar si se presiona el led naranja.
    goto    BOTON_NARANJA
    movlw   b'11110111'			; ACTIVAR COLUMNA 2 (blanco, azul).
    movwf   LATB, A
    btfss   fila1			; Revisar si se presiona el led blanco.
    goto    BOTON_BLANCO
    btfss   fila2			; Revisar si se presiona el led azul.
    goto    BOTON_AZUL
    movlw   b'11101111'			; ACTIVAR COLUMNA 3 (rojo, amarillo).
    movwf   LATB, A
    btfss   fila1			; Revisar si se presiona el led rojo.
    goto    BOTON_ROJO
    btfss   fila2			; Revisar si se presiona el led amarillo.
    goto    BOTON_AMARILLO
    goto    RECORRIDO			; Si no se presiona nada, seguir en espera.
    
BOTON_VERDE
    bsf	    led_verde			; Prender el LED.
    btfss   fila1			; Revisar si sigue presionado el boton.
    goto    BOTON_VERDE			; Si aun no se suleta, esperar.
    bcf	    led_verde			; Apagar el LED.
    clrf    boton_presionado		; Limpiar el registro.
    call    DELAY_20ms			; Antirebote.
    return
BOTON_NARANJA
    bsf	    led_naranja			; Prender el LED.
    btfss   fila2			; Revisar si sigue presionado el boton.
    goto    BOTON_NARANJA		; Si aun no se suleta, esperar.
    bcf	    led_naranja			; Apagar el LED.
    clrf    boton_presionado		; Limpiar el registro.
    bsf	    bit_led_naranja		; Encender el bit representativo del LED naranja.
    call    DELAY_20ms			; Antirebote.
    return
BOTON_BLANCO
    bsf	    led_blanco			; Prender el LED.
    btfss   fila1			; Revisar si sigue presionado el boton.
    goto    BOTON_BLANCO		; Si aun no se suleta, esperar.
    bcf	    led_blanco			; Apagar el LED.
    clrf    boton_presionado		; Limpiar el registro.
    bsf	    bit_led_blanco		; Encender el bit representativo del LED blanco.
    call    DELAY_20ms			; Antirebote.
    return
BOTON_AZUL
    bsf	    led_azul			; Prender el LED.
    btfss   fila2			; Revisar si sigue presionado el boton.
    goto    BOTON_AZUL			; Si aun no se suleta, esperar.
    bcf	    led_azul			; Apagar el LED.
    clrf    boton_presionado		; Limpiar el registro.
    bsf	    bit_led_azul		; Encender el bit representativo del LED azul.
    call    DELAY_20ms			; Antirebote.
    return
BOTON_ROJO
    bsf	    led_rojo			; Prender el LED.
    btfss   fila1			; Revisar si sigue presionado el boton.
    goto    BOTON_ROJO			; Si aun no se suleta, esperar.
    bcf	    led_rojo			; Apagar el LED.
    clrf    boton_presionado		; Limpiar el registro.
    call    DELAY_20ms			; Antirebote.
    return
BOTON_AMARILLO
    bsf	    led_amarillo		; Prender el LED.
    btfss   fila2			; Revisar si sigue presionado el boton.
    goto    BOTON_AMARILLO		; Si aun no se suleta, esperar.
    bcf	    led_amarillo		; Apagar el LED.
    clrf    boton_presionado		; Limpiar el registro.
    bsf	    bit_led_amarillo		; Encender el bit representativo del LED amarillo.
    call    DELAY_20ms			; Antirebote.
    return
    
REVISAR_BOTON
    
DELAY_20ms
    movlw   .0			
    movwf   _256
    movlw   .26
    movwf   _26	
LOOP1
    decfsz  _256
    goto    LOOP1		; (3)*256
    decfsz  _26
    goto    LOOP1		; (3)*256*26 + (3)*26 = 78*256 + 78
    ; 20046+4 = 20.05ms approx. 
    return
  
  end