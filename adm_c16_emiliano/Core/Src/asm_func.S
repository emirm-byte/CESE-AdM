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
.global asm_filtroVentana10
.global asm_pack32to16
.global asm_max
.global asm_downsampleM
.global asm_invertir


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


@Prototipo en "C":
@     void asm_filtroVentana10 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitudVectorIn);

@
@Parametros recibidos:
@   r0: puntero a vectorIn .--16bits
@   r1: puntero a vectorOut --16bits
@   r2: longitudVectorIn
@
@   r4: indice1
@   r5: indice2
@   r6: acumulador
@   r7: aux_out

.thumb_func
	asm_filtroVentana10:
		push {r4,r7}
		mov r4, #0
		mov r5, #0
		mov r6, #0
		mov r7, #0
		.first_for:

			ldrh r3, [r0], #2       //almaceno un valor del vector de entrada en resgistro r3 e incremento el puntero.
			add r6, r6, r3          //sumo el acumulador con el valor del vector de entrada
			add r4, #1
			cmp		r4,#10		    // salgo si:  i=10
			bne .first_for
		udiv r7,r6,r4

		strh r7, [r1], #2       //h instrucciones half word
		pop {r4,r7}
    	bx lr //volvemos


@Prototipo en "C":
@     void asm_pack32to16 (int32_t * vectorIn, int16_t *vectorOut, uint32_t longitud);

@
@Parametros recibidos:
@   r0: puntero a vectorIn .--32bits
@   r1: puntero a vectorOut --16bits
@   r2: longitud
@


.thumb_func
	asm_pack32to16:
		push {r4,r5}
		.pack32_for:
			ldr r4, [r0], #4       //Almaceno un valor del vector de entrada en resgistro r4 e incremento el puntero.
			lsr r5, r4, #16        //Desplazo a la derecha el registro 16 bits.
			strh r5, [r1], #2       //h instrucciones half word
			subs r2, 1              //resto 1 a longitud y actualizo el registro de estado
    		bne .pack32_for            // si el resultado de la resta no es cero (flag Z=0) sigue saltando
		pop {r4,r5}
		bx lr //volvemos


@Prototipo en "C":
@     int32_t asm_max (int32_t * vectorIn, uint32_t longitud);

@
@Parametros recibidos:
@   r0: puntero a vectorIn y valor de retorno de la funcion - indice del max .--32bits
@   r1: longitud --32bits
@
@

.thumb_func
	asm_max:
		push {r4,r5}
		mov r2, r1    //almaceno en r2 el valor de la longitud
		mov r3, r1    //almaceno en r3 el valor de la longitud
		ldr r4, [r0], #4 //Almaceno un valor del vector de entrada en resgistro r4 e incremento el puntero.
		sub r1, #1
    	.max_for:
    		ldr r5, [r0], #4
    		cmp r4, r5        //Compara si r4 es mayor o igual que r5
    		bge .no_es_max
    		mov r4, r5         //Almaceno en r4 el nuevo máximo
    		mov r3, r1         //Almaceno el indice del maximo en r3
    		.no_es_max:
    		 subs r1, #1
             bne .max_for
    	sub r0, r2, r3         //Calculo el indice del máximo como longitud_array - r3
        pop {r4,r5}
		bx lr


@Prototipo en "C":
@     void asm_downsampleM (int32_t * vectorIn, int32_t * vectorOut, uint32_t longitud, uint32_t N);

@
@Parametros recibidos:
@   r0: puntero a vectorIn
@   r1: puntero a vectorOut
@   r2: longitud
@   r3: N

.thumb_func
	asm_downsampleM:
		push {r4,r6}
		mov r4, r3       //Almaceno en r4 el valor N de la cantidad de muestras
		mov r6, #0
		.down_sample_for:
			ldr r5, [r0], #4 //Almaceno un valor del vector de entrada en resgistro r5 e incremento el puntero.
			subs r4, #1
			bne .pass_sample
			mov r4, r3
			str r6, [r1], #4
			b .cont
			.pass_sample:
			str r5, [r1], #4
		   .cont:
			subs r2, #1              //resto 1 a longitud y actualizo el registro de estado
    		bne .down_sample_for
    		pop {r4,r6}
    		bx lr


@Prototipo en "C":
@     void asm_invertir (uint16_t * vector, uint32_t longitud);

@
@Parametros recibidos:
@   r0: puntero a vector -16Bits
@   r1: longitud

.thumb_func
	asm_invertir:
		push {r4}
		mov r2, #2
		mul r1, r2
		sub r1, #2
		add r1, r1 , r0    //ultima posiciòn de memoria del vector de entrada
		.loop_invertir:
			ldrh r3, [r0]
			ldrh r4, [r1]
			strh r4, [r0], #2
			strh r3, [r1], #-2
			cmp r1, r0
			bcs .loop_invertir
		 pop {r4}
		 bx lr
