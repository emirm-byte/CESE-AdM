/*
 * C_func.c
 *
 *  Created on: 18 abr. 2022
 *      Author: emiliano
 */

#include "C_func.h"


void zeros (uint32_t * vector, uint32_t longitud){

	for(uint32_t i=0 ; i<longitud; i++){
		*(vector+i) = 0;

	}

}


void productoEscalar32 (uint32_t * vectorIn, uint32_t * vectorOut, uint32_t longitud, uint32_t escalar){

	for(uint32_t i=0 ; i < longitud ; i++){
		*(vectorOut+i) = (*(vectorIn+i))*escalar;

	}


}


void productoEscalar16 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitud, uint16_t escalar){

	for(uint32_t i=0 ; i < longitud ; i++){
		*(vectorOut+i) = (*(vectorIn+i))*escalar;

	}

}


void productoEscalar12 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitud, uint16_t escalar){


	for(uint32_t i=0 ; i < longitud ; i++){
		*(vectorOut+i) = (*(vectorIn+i))*escalar;
		if(*(vectorOut+i) > 4095){  //SATURO A 12 bits CON CODIGO C//
			*(vectorOut+i) = 4095;
		}

	}

}

void filtroVentana10 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitudVectorIn){
	const uint8_t ventana = 10;
	for(uint32_t i=0;i<longitudVectorIn;i++){

		for(uint32_t k=0;k<ventana;k++){
			if((i+k)<longitudVectorIn){
				vectorOut[i] += vectorIn[i+k];
			}
			else{
				vectorOut[i] += vectorIn[(i+k)-longitudVectorIn];
			}

		}
		vectorOut[i]=vectorOut[i]/ventana;

	}

}

void pack32to16 (int32_t * vectorIn, int16_t *vectorOut, uint32_t longitud){
	for(uint32_t i=0 ; i<longitud ; i++){
		vectorOut[i] = (uint16_t)(vectorIn[i]>>16);

	}

}

int32_t max (int32_t * vectorIn, uint32_t longitud){
	int32_t indice = 0;
	for(uint32_t i=0 ; i<longitud ; i++){
		if(vectorIn[i] > vectorIn[indice]){
			indice = i;
		}

	}
	return indice;

}


void downsampleM (int32_t * vectorIn, int32_t * vectorOut, uint32_t longitud, uint32_t N){
	for(uint32_t i=1 ; i<longitud ; i++){
		if(i%3){
			vectorOut[i]=vectorIn[i];
		}
		else{
			vectorOut[i]=0;
		}
	}
}


void invertir (uint16_t * vector, uint32_t longitud){
	uint16_t aux=0;
	for(uint32_t i=0 ; i<(longitud/2) ; i++){
		aux=vector[i];
		vector[i]=vector[longitud-1-i];
		vector[longitud-1-i]=aux;
	}
}

//44100 muestras/seg 
//Si el eco comienza a los 20 mseg => (44100 muestras/seg)*(20 mseg /1000) => 882 muestras 

//Para test ingresar:

// int16_t vectorIn[4096]
// int16_t vectorOut[4096]
// longitud_vectores = 4096;
// tasa_muestreo = 44100;
// t_inicio_eco_ms = 20;

void eco (int16_t *vector, int16_t *eco_out, uint32_t longitud_vectores, uint32_t tasa_muestreo , uint32_t t_inicio_eco_ms) {
	
	uint32_t muestras_eco = (tasa_muestreo/1000)*inicio_eco_ms;
	
	for(uint32_t i=0 ; i<longitud ; i++){
		if(i<=muestras_eco){
			*(eco_out+i) = *(vector+i);
		}
		else{
			*(eco_out+i) = *(vector+i)+ (*(vector+i-muestras_eco))/2;
		}		
	}
	
}