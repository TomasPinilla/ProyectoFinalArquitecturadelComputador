Inicio:	    
	    MOV ACC, VAR_A      ;Almacenamos VAR_A que es diferente al registro A en ACC  
            MOV DPTR, ACC       ;Almacenamos VAR_A en el DTPR
            MOV ACC, 0x00       ;Cargamos una constante
            MOV [DPTR], ACC     ;Vamos al VAR_A inicializada en 0000 0000
Inicializar_Count:
            MOV ACC, Count      ;Almacenamos Count n-bits en ACC
            MOV DPTR, ACC       ;Almacenamos Count en DPTR
            MOV ACC, 0b00001000 ;Almacenamos 0000 1000 (8 en decimal) en ACC
            MOV [DPTR], ACC     ;Almacenamos 0000 1000 en el Count
Inicializar_Q-1:
            MOV ACC, Q-1        ;Almacenamos Q-1 en el ACC
            MOV DPTR, ACC       ;Movemos Q-1 a DPTR
            MOV ACC, 0x00       ;Almacenamos 0000 0000 en el ACC
            MOV [DPTR], ACC     ;Almacenamos 0000 0000 en Q-1
 Calcular_Q0:         
            MOV ACC, Q    	;Almacenamos Q en el ACC
            MOV DPTR, ACC       ;Movemos Q al DPTR
            MOV ACC, [DPTR]     ;Almacenamos el valor que contiene el apuntados en ACC
		    MOV A, ACC		  ;Almacenamos el valor del acumulador en el registro de A
            MOV ACC, 0b00000001 ;Almacenamos el numero 0000 0001 en el ACC
            AND ACC, A          ;Calculamos AND de 0000 0001 con el valor de Q
            MOV A, ACC          ;Almacenamos ACC en A           
Guardar_Q0:
            MOV ACC, Q0     	;Almacenamos Q0 en ACC
            MOV DPTR, ACC       ;Almacenamos Q0 en el DPTR
            MOV ACC, A          ;Almacenamos el valor del registro A en el ACC
            MOV [DPTR], ACC     ;Almacenamos el valor del acumulador Q0
Preguntar_Q-1=0: 
		  MOV ACC, Q0		  ;Almacenamos Q0 en ACC
	      MOV DPTR, ACC	      ;Almacenamos el valor que contiene el ACC en DPTR
	      MOV ACC, [DPTR]	  ;Almacenamos el valor que contiene el apuntador en ACC
	      MOV A, ACC		  ;Almacenamos el valor que contien el acumulador en el registro de A
            MOV ACC, Q-1	      ;Almacenamos Q-1 en ACC  
            MOV DPTR, ACC       ;Almacenamos Q-1 en el DPTR
            MOV ACC, [DPTR]     ;Almacenamos 0000 0000 en el ACC
            MOV DPTR, ACC        ;Se mueve la variable al registro A para la bandera
            JZ Preguntar_0-	  ;Saltamos a la instruccion que pregunta por 0  
Preguntar_-1:
            MOV ACC, A          ;Almacenamos el valor del registro A en ACC
            JZ Hacer_01         ;Saltamos a la instruccion que opera por el 01
Preguntar_0-:
            MOV ACC, A          ;Almacenamos el valor del registro A en ACC
            JZ DesplazarAritmetico;Saltamos a la instruccion que desplaza por aritmetica
	      MOV ACC, [DPTR]	  ;Almacenamos la dirección de memoria del DPTR en ACC
	      JZ Hacer_10		  ;Saltamos a la instruccion que para hacer el caso 10
Hacer_11:
            JMP DesplazarAritmetico  ;Saltamos a la instruccion que desplaza por aritmetica
Hacer_10:
            MOV ACC, M          ;Almacenamos M en ACC
            MOV DPTR, ACC       ;Almacenamos M en el DPTR
            MOV ACC, [DPTR]     ;Se almacena el valor que contiene el apuntador en ACC
	      INV ACC		      ;Invertimos M
	      MOV A, ACC		  ;Movemos el acumulador al registro A
	      MOV ACC, 0b00000001 ;Cargamos una constante 1
	      ADD ACC, A		  ;Hacemos complemente A2  de M
            MOV A, ACC          ;Vamos a almacenar - M en el registro A
            MOV ACC, VAR_A      ;Almacenamos VAR_A en ACC
            MOV DPTR, ACC       ;Almacenamos VAR_A en DPTR
            MOV ACC, [DPTR]     ;Almacenamos 0000 0000 en el ACC
            ADD ACC, A          ;Sumamos A y -M 
            MOV [DPTR], ACC     ;Almacenamos A-M en A
            JMP DesplazarAritmetico ;Saltamos a la instruccion que desplaza por aritmetica
Hacer_01:
            MOV ACC, M          ;Almacenamos M en ACC
            MOV DPTR, ACC       ;Almacenamos M en DPTR
            MOV ACC, [DPTR]     ;Almacenamos 0000 0011 en ACC
            MOV A, ACC          ;almacenamos 0000 0011 en R
            MOV ACC, VAR_A	  ;Almacenamos VAR_A en ACC            
            MOV DPTR, ACC       ;Almacenamos VAR_A en DPTR
            MOV ACC, [DPTR]     ;Almacenamos 0000 00000 en ACC
            ADD ACC, A          ;Sumamos 0000 0000 con 0000 0011
            MOV [DPTR], ACC     ;Almacenamos 0000 0011 en VAR_A
DesplazarAritmetico:
            MOV ACC, Q0         ;Almacenamos Q0 en ACC
            MOV DPTR, ACC       ;Almacenamos Q0 en DPTR
            MOV ACC, [DPTR]     ;Vamos al ACC y el valor que contiene el apuntador
            MOV A, ACC          ;Almacenamos el valor del acumulador en el registro A
            MOV ACC, Q-1        ;Almacenamos Q-1 en ACC
            MOV DPTR, ACC       ;Almacenamos Q-1 en DPTR
            MOV ACC, A          ;Almacenamos el valor del registro A en ACC
            MOV [DPTR], ACC     ;Almacenamos el valor del acumulador en Q-1
Obtener_VAR_A0:
            MOV ACC, VAR_A      ;Almacenamos VAR_A en ACC
            MOV DPTR, ACC       ;Almacenamos VAR_A en DPTR
            MOV ACC, [DPTR]     ;Almacenamos el valor que contiene el apuntador en ACC
            MOV A, ACC          ;Almacenamos el valor del acumulador en registro A
            MOV ACC, 0b00000001 ;Vamos al ACC y almacenamos una constante 
            AND ACC, A          ;Calculamos AND entre los valores del registro A y el acumulador
            MOV A, ACC          ;Almacenamos el valor que contiene el acumulador en el registro A
            JZ DesplazarDerecha_Q;Se hace la verificación y saltamos a la instruccion que desplaza Q
            MOV ACC, 0b10000000 ;Almacenamos una constante en ACC
            MOV A, ACC          ;Almacenamos el valor del acumulador en el registro A
DesplazarDerecha_Q:
            MOV ACC, Q          ;Almacenamos Q en ACC
            MOV DPTR, ACC       ;Almacenamos Q en DPTR
            MOV ACC, [DPTR]      ;Almacenamos el valor que contiene el apuntador en ACC
            RSH ACC, 0x1               ;Desplazamos un bit a la derecha 
            ADD ACC, A          ;Sumamos los valores que contienen el registro A y el acumulador
            MOV [DPTR], ACC     ;Almacenamos el valor que contiene el acumulador en Q
Empezar_A:
            MOV ACC, VAR_A      ;Almacenamos VAR_A en ACC
            MOV DPTR, ACC       ;Almacenamos VAR_A en DPTR
            MOV ACC, [DPTR]     ;Almacenamos el valor que contiene el apuntador en ACC
            MOV A, ACC          ;Almacenamos el valor del acumulador en A
            MOV ACC, 0b10000000 ;Almacenamos una constante en ACC
            AND ACC, A          ;Calculamos AND entre el valor del acumulador y el registro A
            MOV A, ACC          ;Almacenamos el valor del acumulador en A
	      	MOV ACC, [DPTR]	    ;Almacenamos el valor del DPTR en ACC
Desplazar_A:
            RSH ACC, 0x1        ;Desplazamos un bit a la derecha 
            ADD ACC, A          ;Sumamos el valor que contiene el acumulador y el registro A
            MOV [DPTR], ACC     ;Almacenamos el valor del acumulador en VAR_A
Cargamos_Count: 
	        MOV ACC, Count 	    ;Almacenamos la variable Count en ACC
	        MOV DPTR, ACC	    ;Almacenamos la direacción de memoria del acumulador en DPTR
		    MOV ACC, [DPTR]	    ;Almacenamos el valor que contiene el apuntador en ACC
	        MOV A, ACC		    ;Almacenamos el valor del acumulador en el registro A
	        MOV ACC, 0b11111111	;Vamos al acumulador y cargamos una constante
            ADD ACC, A		    ;Sumamos Count y -1 
Guardar_Count:
            MOV [DPTR], ACC     ;Almacenamos el valor del acumulador en cout
            JZ Terminar_Algoritmo;Verificación de 0 y saltamos a la instruccion que guarda los resultados
            JMP Calcular_Q0	    ;Saltamos a la instruccion que calcula Q0 para el ciclo
Terminar_Algoritmo:
            HLT				    ;Terminación del programa
Inicialización de las variables: 
VAR_A	: 0b0 
Q: 0b10000000; Multiplicador
Q-1: 0b0
M: 0b00001000; Multiplicando
Count: 0x8
Q0: 0b0

;Rúbrica de instrucciones adicionales del PDUA:

;OPCODE: 	NEMÓNICO:	Bytes: 
; 01000xxx	AND ACC, A 	1
; 1xxxxxxx	SHR ACC		1