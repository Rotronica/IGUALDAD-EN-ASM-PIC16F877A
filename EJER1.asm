;EJERCICIO 1
;Compara el dato del puerto de entrada PORTA con un numero (por ejemplo, el 13). Pueden darse dos posibilidades:
;• Si (PORTA) = NUMERO, se encienden todos los diodos LED de salida.
;• Si (PORTA) ? NUMERO, se activan los LED pares y se apagan los impares.

	__CONFIG _XT_OSC & _WDTE_OFF & _PWRTE_ON & _CP_OFF & _LVP_OFF & _BOREN_OFF
    LIST  	P=16F877A		;Procesador pic 16f877A
	INCLUDE <P16F877A.INC>	;Incluir fichero del microcontrolador
   		ORG	 	0X00		;El programa comienza en la direccion 0x00
		GOTO 	CONFIGURAR	;Ir a la subrutina configurar
		;ORG		0X05
CONFIGURAR:
		BSF		STATUS,RP0	;Ingresar al Banco 1
		MOVLW	0X06		;MOVER EL DATO 0X06 al registro de "W"
		MOVWF	ADCON1		;Mover el valor del registro "W" al registro ADCON1
		MOVLW	0XFF		;Mover el dato 0xFF al registro "W"
		MOVWF	TRISA		;Mover el "W" al registro
		CLRF	TRISB		;Limpiar el TRISB(los bits de este registro se colocan 00000000)
		BCF		STATUS,RP0	;Volver al banco 0
		CLRF	PORTA		;Limpiar el PortA
		CLRF	PORTB		;Limpiar el PortB

;----------Programa principal-------------------
MAIN:
		MOVLW	D'13'		;Mover el 
		SUBWF	PORTA,W 	;W=PORTA-W  esto es equivalente a 13=13
		BTFSS	STATUS,Z	;Realiza un salto su z=1
		GOTO	PRENDE_PARES;si Z=0 ejeuta esta instrucción
PRENDER_TODO:
		MOVLW	0XFF		;Mover el dato 0xFF al registro de trabajo
		MOVWF	PORTB		;Mover el contenido del 'W' al registro PORTB
		GOTO	MAIN		;Ir a Main
PRENDE_PARES:
		MOVLW	B'01010101'	;Mover el dato al registro 'W'
		MOVWF	PORTB		;Mover el registro 'W' al registro PORTB
		GOTO	MAIN		;Ir a la etiqueta MAIN
		END