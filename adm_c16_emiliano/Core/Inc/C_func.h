/*
 * C_func.h
 *
 *  Created on: 18 abr. 2022
 *      Author: emiliano
 */

#ifndef INC_C_FUNC_H_
#define INC_C_FUNC_H_

#include <stdint.h>

void zeros (uint32_t * vector, uint32_t longitud);  //FUNCION CORRESPONDIENTE AL EJERCICIO N°1//
void productoEscalar32 (uint32_t * vectorIn, uint32_t * vectorOut, uint32_t longitud, uint32_t escalar); //FUNCION CORRESPONDIENTE AL EJERCICIO N°2//
void productoEscalar16 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitud, uint16_t escalar); //FUNCION CORRESPONDIENTE AL EJERCICIO N°3//
void productoEscalar12 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitud, uint16_t escalar); //FUNCION CORRESPONDIENTE AL EJERCICIO N°4//
void filtroVentana10 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitudVectorIn); //FUNCION CORRESPONDIENTE AL EJERCICIO N°5//
void pack32to16 (int32_t * vectorIn, int16_t *vectorOut, uint32_t longitud); //FUNCION CORRESPONDIENTE AL EJERCICIO N°6//
int32_t max (int32_t * vectorIn, uint32_t longitud); //FUNCION CORRESPONDIENTE AL EJERCICIO N°7//
void downsampleM (int32_t * vectorIn, int32_t * vectorOut, uint32_t longitud, uint32_t N); //FUNCION CORRESPONDIENTE AL EJERCICIO N°8//
void invertir (uint16_t * vector, uint32_t longitud); //FUNCION CORRESPONDIENTE AL EJERCICIO N°9//



#endif /* INC_C_FUNC_H_ */
