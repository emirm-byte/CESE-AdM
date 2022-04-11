.syntax unified
.thumb
.text

@ Simbolos exportados
.global asm_svc
.global asm_sum
.global asm_zeros
.global asm_productoEscalar32
.global asm_productoEscalar16
.global asm_productoEscalar12

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_svc (void)
@
.thumb_func
    asm_svc:
        svc 0
        bx lr


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   uint32_t asmSum (uint32_t firstOperand, uint32_t secondOperand)
@
@ Parametros recibidos:
@   r0: firstOperand
@   r1: secondOperand
@
@ Valor de retorno:
@   r0: resultado de la suma de firstOperand y secondOperand
@
.thumb_func
    asm_sum:
        add r0, r1  @ r0 = r0 + r1
        bx lr       @ vuelve adonde fue llamada (especificamente, si "pc"
                    @ es la direccion, en el codigo del programa, de la
                    @ instruccion "bl asm_sum" usada para saltar a
                    @ esta funcion, entonces "lr" contiene ese "pc" + 4).
                    @ el valor de retorno debe quedar en el registro r0.
                    @ En este caso, r0 es el resultado de r0 + r1.

        @ Otras alternativas para el retorno
        @ mov pc,lr
        @ bx lr
        @ push {lr} ... pop {pc}


@Prototipo en "C":
@   void asm_zeros (uint32_t * vector, uint32_t longitud);
@
@ Parametros recibidos:
@   r0: puntero a vector
@   r1: longitud
@
@ Valor de retorno:
@   r0: vector en 0
@


.thumb_func
    asm_zeros:
    	mov r2, 0      //le asigno 0 a r2
    .asm_zeros_for:
    	str r2, [r0], 4   //corchetes equivale a *vector++ = r2 // *vector = r2 ; vector += 4; //incremento el puntero
    	subs r1, 1     //resto 1 a longitud y actualizo el registro de estado
    	bne .asm_zeros_for            // si el resultado de la resta no es cero (flag Z=0) sigue saltando
    	bx lr //volvemos


@Prototipo en "C":
@     void asm_productoEscalar32 (uint32_t * vectorIn, uint32_t * vectorOut, uint32_t longitud, uint32_t escalar);@
@
@Parametros recibidos:
@   r0: puntero a vectorIn
@   r1: puntero a vectorOut
@   r2: longitud
@	r3: escalar



.thumb_func
    asm_productoEscalar32:
		push {r4,r5}
		.esc32_for:
			ldr r4, [r0], #4       //almaceno un valor del vector de entrada en resgistro r4 e incremento el puntero.
			mul r5, r4, r3
			str r5, [r1], #4
			subs r2, 1     //resto 1 a longitud y actualizo el registro de estado
    		bne .esc32_for            // si el resultado de la resta no es cero (flag Z=0) sigue saltando

    	 pop {r4,r5}
    	 bx lr //volvemos



@Prototipo en "C":
@     void asm_productoEscalar16 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitud, uint16_t escalar);@
@
@Parametros recibidos:
@   r0: puntero a vectorIn
@   r1: puntero a vectorOut
@   r2: longitud
@	r3: escalar



.thumb_func
    asm_productoEscalar16:
    	push {r4,r5}
		.esc16_for:
			ldrh r4, [r0], #2       //almaceno un valor del vector de entrada en resgistro r4 e incremento el puntero.
			mul r5, r4, r3
			strh r5, [r1], #2       //h instrucciones half word
			subs r2, 1              //resto 1 a longitud y actualizo el registro de estado
    		bne .esc16_for            // si el resultado de la resta no es cero (flag Z=0) sigue saltando
    	pop {r4,r5}
    	bx lr //volvemos



@Prototipo en "C":
@     void asm_productoEscalar12 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitud, uint16_t escalar);
@
@Parametros recibidos:
@   r0: puntero a vectorIn
@   r1: puntero a vectorOut
@   r2: longitud
@	r3: escalar


.thumb_func
    asm_productoEscalar12:
		push {r4,r5}
		.esc12_for:
			ldrh r4, [r0], #2       //almaceno un valor del vector de entrada en resgistro r4 e incremento el puntero.
			mul r5, r4, r3
			usat r5, 12, r5
			strh r5, [r1], #2       //h instrucciones half word
			subs r2, 1              //resto 1 a longitud y actualizo el registro de estado
    		bne .esc12_for            // si el resultado de la resta no es cero (flag Z=0) sigue saltando
    	pop {r4,r5}
    	bx lr //volvemos



